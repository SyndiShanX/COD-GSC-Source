/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_interception_chopper.gsc
************************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.attackerswaittime = &ascendermodelview;
  var_0.isfeaturedisabled = &deactivate;
  var_0.ref_14382 = &ref_14382;
  var_0.postinitfunc = &postinitfunc;
  var_0.weight = getdvarfloat("scr_br_pe_interception_weight", 0);
  var_0.ref_11B78 = getdvarint("scr_br_pe_interception_max_times", 0);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("interception", "02020200 0 0 0");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("interception");
  thread tracegroundheightexfil();
  scripts\mp\gametypes\br_publicevents::ref_12B35(17, var_0);
}

function postinitfunc() {
  tr_vis_radius_override_lod2();
  initloottables();
  thermite_linktostuck();
  thermite_watchglstuck();
  scripts\engine\scriptable::ref_12F5B("scriptable_interception_bag", &chopper_bag_used);
}

function tr_vis_radius_override_lod2() {
  level.ref_12E2B = spawnStruct();
  level.ref_12E2B.a_s_event_locations = get_possible_event_locations();
  level.ref_12E2B.a_v_used_event_locations = [];
  level.ref_12E2B.sg_ontimerexpired = getdvarint("scr_interception_hasLootPinata", 1);
  level.ref_12E2B.ref_11F1F = getdvarint("scr_interception_numEnemyAgents", 5);
  level.ref_12E2B.spawnregions = getdvarint("scr_interception_chopperWaitTime", 120);
  level.ref_12E2B.pre_pinata_uses = getdvarint("scr_interception_prePinataUses", 4);
  level.ref_12E2B.cash_looted_xp_small = getdvarint("scr_interception_cashLootedXpSmall", 50);
  level.ref_12E2B.cash_looted_xp_large = getdvarint("scr_interception_cashLootedXpLarge", 100);
  level.ref_12E2B.agent_killed_xp = getdvarint("scr_interception_agentKilledXp", 10);
  level.ref_12E2B.cash_aliases = ["cashlootsm", "cashlootmd", "cashlootlrg", "cashlootepic", "cashlootlegend"];
  var_0 = getDvar("scr_interception_minCashRewards", "");
  level.ref_12E2B.min_cash_rewards = [];

  if(var_0 != "") {
    var_1 = strtok(var_0, " ");

    foreach(var_3 in var_1) {
      level.ref_12E2B.min_cash_rewards[level.ref_12E2B.min_cash_rewards.size] = int(var_3);
    }
  } else {
    level.ref_12E2B.min_cash_rewards = [15, 0, 0, 0, 0];
  }

  var_5 = getDvar("scr_interception_maxCashRewards", "");
  level.ref_12E2B.max_cash_rewards = [];

  if(var_5 != "") {
    var_6 = strtok(var_5, " ");

    foreach(var_3 in var_6) {
      level.ref_12E2B.max_cash_rewards[level.ref_12E2B.max_cash_rewards.size] = float(var_3);
    }
  } else {
    level.ref_12E2B.max_cash_rewards = [25, 0, 0, 0, 0];
  }

  if(level.ref_12E2B.max_cash_rewards.size != level.ref_12E2B.cash_aliases.size || level.ref_12E2B.min_cash_rewards.size != level.ref_12E2B.cash_aliases.size) {}

  level.ref_12E2B.ref_11BAB = ["brloot_plunder_cash_uncommon_1", "brloot_plunder_cash_uncommon_2", "brloot_plunder_cash_uncommon_3"];
  level.ref_12E2B.waitteardowninfilmapomnvars = ["brloot_plunder_cash_rare_1", "brloot_plunder_cash_rare_2"];
  level.ref_12E2B.ref_14292 = ["brloot_plunder_cash_epic_1", "brloot_plunder_cash_epic_2"];
  level.ref_12E2B.ammo_objects = ["brloot_ammo_12g", "brloot_ammo_50cal", "brloot_ammo_rocket", "brloot_ammo_919", "brloot_ammo_762"];
  level.ref_12E2B.hascircle = !level.br_circle_disabled;
  level._effect["vfx_smk_signal_green"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_green");
}

function initloottables() {
  var_0 = [];

  switch (getDvar("mapname")) {
    default:
      switch (scripts\mp\utility\game::getgametype()) {
        default:
          var_0["brloot_offhand_kioskdrop"] = 1;
          var_0["brloot_offhand_advancedsupplydrop"] = 1;
          var_0["brloot_killstreak_uav"] = 1;
          var_0["brloot_offhand_jammer"] = 1;
          var_0["brloot_super_munitionsbox"] = 1;
          var_0["brloot_plate_pouch"] = 1;
          var_0["brloot_offhand_decon_station"] = 1;
      }
      break;
  }

  _handlevehiclerepair::ref_11A45("interception_final_pinata", var_0);
}

function tracegroundheightexfil() {
  waitframe();

  if(!isDefined(game["dialogForAllTeams"])) {
    game["dialogForAllTeams"] = [];
  }

  register_interception_dialogue("interception_agent_respawn", "dx_bra_hcpt_public_events_agent_respawn");
  register_interception_dialogue("interception_event_start", "dx_bra_bchr_public_events_event_start");
  register_interception_dialogue("interception_chopper_crash", "dx_bra_hcpt_public_events_helicopter_crash");
  register_interception_dialogue("interception_chopper_health_75", "dx_bra_hcpt_public_events_helicopter_health_low");
  register_interception_dialogue("interception_chopper_health_50", "dx_bra_hcpt_public_events_helicopter_health_50");
  register_interception_dialogue("interception_chopper_health_25", "dx_bra_hcpt_public_events_helicopter_health_25");
  register_interception_dialogue("interception_chopper_return", "dx_bra_hcpt_public_events_helicopter_return");
  register_interception_dialogue("interception_loot_bag", "dx_bra_hcpt_public_events_loot_interact");
  register_interception_dialogue("interception_empty_bag", "dx_bra_hcpt_public_events_loot_interact_empty");
}

function play_vo_near_location(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3) {
    if(scripts\mp\utility\player::isreallyalive(var_5)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_5);
    }
  }
}

function get_possible_event_locations() {
  var_0 = [];

  switch (getDvar("mapname")) {
    case "mp_sm_island_1":
      var_0[var_0.size] = ref_12ADE((-224, -302, 1290), [], 100, 700);
      var_0[var_0.size] = ref_12ADE((-4432, 1726, 1406), [], 100, 800);
      var_0[var_0.size] = ref_12ADE((9991, 5704, 130), [], 100, 800);
      var_0[var_0.size] = ref_12ADE((10952, 2090, 633), [], 100, 700);
      var_0[var_0.size] = ref_12ADE((7518, -5720, 605), [], 100, 700);
      var_0[var_0.size] = ref_12ADE((11280, -4330, 605), [], 100, 700);
      var_0[var_0.size] = ref_12ADE((-8000, 4046, 250), [], 100, 700);
      var_0[var_0.size] = ref_12ADE((-4300, -4520, 1118), [], 100, 700);
      break;
    default:
      var_0[var_0.size] = ref_12ADE((-146, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      var_0[var_0.size] = ref_12ADE((0, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      var_0[var_0.size] = ref_12ADE((146, -246, 20), [[(-146, -246, 0), (146, -246, 0)], [(-246, -146, 0), (246, -146, 0)]], 100, 500);
      break;
  }

  return var_0;
}

function ref_12ADE(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.minecart_run = var_0;
  var_4.patrol_paths = var_1;
  var_4.minigun_internal = var_2;
  var_4.nav_radius = var_3;
  var_4.ref_13B91 = 0;
  var_4.new_rider_combat_logic = [];
  return var_4;
}

#using_animtree("");

function thermite_linktostuck() {
  level.scr_anim["plunder_extract_heli"]["heli_in"] = % iw8_br_plunder_heli_in;
  level.scr_anim["plunder_extract_heli"]["heli_loop"] = $iw8_br_plunder_heli_loop;
  level.scr_anim["plunder_extract_heli"]["heli_out"] = % iw8_br_plunder_heli_out;
}

function thermite_watchglstuck() {
  level.scr_animtree["plunder_extract_heli"] = #animtree;
  level.scr_anim["plunder_extract_heli"]["rope_in"] = $iw8_br_plunder_heli_rope_in;
  level.scr_animname["plunder_extract_heli"]["rope_in"] = "iw8_br_plunder_heli_rope_in";
  level.scr_anim["plunder_extract_heli"]["rope_out"] = % iw8_br_plunder_heli_rope_out;
  level.scr_animname["plunder_extract_heli"]["rope_out"] = "iw8_br_plunder_heli_rope_out";
  level.scr_anim["plunder_extract_heli"]["bag_in"] = % iw8_br_plunder_heli_bag_in;
  level.scr_animname["plunder_extract_heli"]["bag_in"] = "iw8_br_plunder_heli_bag_in";
  level.scr_anim["plunder_extract_heli"]["bag_out"] = % iw8_br_plunder_heli_bag_out;
  level.scr_animname["plunder_extract_heli"]["bag_out"] = "iw8_br_plunder_heli_bag_out";
}

function register_interception_dialogue(var_0, var_1) {
  game["dialog"][var_0] = var_1;
  game["dialogForAllTeams"][var_0] = 1;
}

function ascendermodelview() {
  level.ref_12E2B.a_s_event_locations = scripts\engine\utility::array_randomize(level.ref_12E2B.a_s_event_locations);
  var_0 = undefined;
  var_1 = 0;
  var_2 = 0;

  if(level.ref_12E2B.hascircle) {
    var_1 = scripts\mp\gametypes\br_circle::inithelirepository() < 30 + level.ref_12E2B.spawnregions && !scripts\mp\gametypes\br_circle::islastcircle();
    var_2 = scripts\mp\gametypes\br_circle::inithelirepository() < 30 && !scripts\mp\gametypes\br_circle::islastcircle();
  }

  foreach(var_4 in level.ref_12E2B.a_s_event_locations) {
    if(!level.ref_12E2B.hascircle) {
      if(!scripts\engine\utility::array_contains(level.ref_12E2B.a_v_used_event_locations, var_4.minecart_run)) {
        var_0 = var_4;
      }

      continue;
    }

    if(var_2) {
      if(scripts\mp\gametypes\br_circle::updatescavengerhud(var_4.minecart_run) && !scripts\engine\utility::array_contains(level.ref_12E2B.a_v_used_event_locations, var_4.minecart_run)) {
        var_0 = var_4;
      }

      continue;
    }

    if(var_1) {
      if(scripts\mp\gametypes\br_circle::updatescavengerhud(var_4.minecart_run) && scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_4.minecart_run) && !scripts\engine\utility::array_contains(level.ref_12E2B.a_v_used_event_locations, var_4.minecart_run)) {
        var_0 = var_4;
      }

      continue;
    }

    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_4.minecart_run) && !scripts\engine\utility::array_contains(level.ref_12E2B.a_v_used_event_locations, var_4.minecart_run)) {
      var_0 = var_4;
    }
  }

  if(isDefined(var_0)) {
    foreach(var_7 in level.players) {
      var_7 thread scripts\mp\hud_message::showsplash("br_pe_interception_start");

      if(scripts\mp\utility\player::isreallyalive(var_7)) {
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("interception_event_start", var_7);
      }
    }

    level.ref_12E2B.a_v_used_event_locations[level.ref_12E2B.a_v_used_event_locations.size] = var_0.minecart_run;
    thread ref_13794(var_0);
    scripts\common\vehicle_code::vehicle_start_ai_avoidance();
    return;
  }
}

function deactivate() {}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");

  if(getdvarint("scr_br_loadout_delay", 0) == 1 && level.br_circle.circleindex <= 1) {
    level waittill("br_circle_closing");
    return;
  }
}

function ref_13794(var_0) {
  var_0.nav_volume = spawn("trigger_radius", var_0.minecart_run + (0, 0, -30), 0, var_0.nav_radius, var_0.nav_radius * 2);
  var_1 = randomfloat(360);
  var_2 = var_0.minecart_run + -1 * anglesToForward((0, var_1, 0)) * 26000 + (0, 0, 3300);
  var_3 = vectortoangles(var_0.minecart_run - var_2);
  var_4 = 99;
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_mercenary_extraction_x");

  if(!isDefined(var_5)) {
    return;
  }

  var_6 = var_0.minecart_run * (1, 1, 0) + (0, 0, 3300);
  var_0.heli = var_5;
  var_5.ref_11980 = var_0;
  var_5.damagecallback = &callback_vehicledamage;
  var_5.speed = 50;
  var_5.accel = 125;
  var_5.health = 10000;
  var_5.maxhealth = var_5.health;
  var_5.defendloc = var_0.minecart_run;
  var_5.lifeid = 0;
  var_5.flaresreservecount = var_4;
  var_5.pathgoal = var_6;
  var_5.ref_121FF = var_0.minecart_run + anglesToForward(var_3) * 26000 + (0, 0, 3300);
  var_5.endpoint = var_6;
  var_5.select_mountain_two_spawners = var_3[1];
  var_5.animname = "plunder_extract_heli";
  var_5.leaving = 0;
  var_5.currentlyplayingvo = 0;
  var_5.played75healthbark = 0;
  var_5.played50healthbark = 0;
  var_5.played25healthbark = 0;
  var_5.scenenode = spawn("script_model", var_5.defendloc);
  var_5.scenenode.angles = var_3;
  var_5.scenenode setModel("tag_origin");
  var_5.vehiclename = "magma_plunder_chopper";
  var_5 setCanDamage(1);
  var_5 setmaxpitchroll(10, 25);
  var_5 vehicle_setspeed(var_5.speed, var_5.accel);
  var_5 sethoverparams(50, 100, 50);
  var_5 setturningability(0.05);
  var_5 setyawspeed(45, 25, 25, 0.5);
  ref_13693(var_5);
  thread showquestcircletoplayer();
  thread handledestroydamage();
  thread givebrbonusxp();
  var_5 method_87e8();
  thread helidestroyvehiclescollisionnotify();
  thread givebrweaponxp();
}

function givebrweaponxp() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "bag_in", "origin_animate_jnt");
  var_0 = givequestsplash(self.pathgoal, self.ref_11980);
  thread heli_spawn_smoke_marker();
  scripts\mp\gametypes\br_quest_util::ref_140B1(self.ref_11980.ground_drop_point, "dom");
  var_1 = spawnStruct();
  var_1 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(11, 4, 2, self.ref_11980.ground_drop_point);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1316F(1000);
  var_1 scripts\mp\gametypes\br_quest_util::ref_13369();
  thread quest_circle_cleanup_on_chopper_death(level);
  self waittill("goal");
  var_1 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
  thread givespecialistbonusifneeded();
  givebmodevloadouts(self.endpoint, var_0);
}

function quest_circle_cleanup_on_chopper_death(var_0) {
  level endon("game_ended");
  level endon("cancel_public_event");
  self endon("goal");
  self waittill("death");
  var_0 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
}

function heli_spawn_smoke_marker() {
  var_0 = spawn("script_model", self.ref_11980.ground_drop_point - (0, 0, 3));
  var_0 setModel("tag_origin");
  self.smokevfxent = var_0;
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), var_0, "tag_origin");
}

function givebmodevloadouts(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25, 31.25);
  thread chopper_start_agent_spawn(0.1, 0.8);
  thread agent_watch_danger_circle(level);
  self waittill("goal");
  self sethoverparams(1, 1);
  thread giverandomloadoutindex();
}

function helidestroyvehiclescollisionnotify() {
  self endon("heli_gone");
  self endon("death");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_7) && nuke_vault_suicidebomber_internal(var_7)) {
      var_7 dodamage(var_7.health, self.origin, self, self, "MOD_CRUSH");
      self dodamage(self.maxhealth / 2, self.origin, var_7, var_7, "MOD_CRUSH");
    }
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function agent_watch_danger_circle(var_0) {
  level endon("game_ended");

  if(getdvarint("scr_br_circle_disable") == 0) {
    while(var_0.new_rider_combat_logic.size > 0 || isDefined(var_0.heli) && !var_0.heli.leaving) {
      foreach(var_2 in var_0.new_rider_combat_logic) {
        if(isDefined(var_2) && isalive(var_2)) {
          if(!scripts\mp\gametypes\br_circle::updateprestreamrespawn(var_2.origin)) {
            var_2 dodamage(var_2.health, var_2.origin, var_2, undefined, "MOD_TRIGGER_HURT", undefined);
          }
        }
      }

      wait 0.1;
    }

    scripts\common\vehicle_code::vehicle_stop_ai_avoidance();
    return;
  }
}

function chopper_start_agent_spawn(var_0, var_1) {
  waitframe();
  var_2 = level.ref_12E2B.ref_11F1F - self.ref_11980.new_rider_combat_logic.size;

  if(var_2 == 0) {
    return;
  }

  var_3 = 360 / var_2;
  var_4 = anglesToForward(self.angles);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = var_3 * var_5;
    var_7 = var_3 * (var_5 + 1);
    var_8 = randomfloatrange(var_6, var_7);
    var_9 = self.ref_11980.nav_radius * var_0;
    var_10 = self.ref_11980.nav_radius * var_1;
    var_11 = randomfloatrange(var_9, var_10);
    var_12 = vectorNormalize(rotatevector(var_4, (0, var_8, 0)));
    var_13 = self.ref_11980.minecart_run + var_12 * var_11;
    var_13 = getclosestpointonnavmesh(var_13);
    var_14 = getgroundposition(var_13, 32, 2000, 1500);
    var_15 = 0;

    while(distancesquared(var_14, var_13) > 1024 && var_15 < 5) {
      var_15++;
      var_8 = randomfloatrange(var_6, var_7);
      var_12 = vectorNormalize(rotatevector(var_4, (0, var_8, 0)));
      var_11 = randomfloatrange(var_9, var_10);
      var_13 = self.ref_11980.minecart_run + var_12 * var_11;
      var_13 = getclosestpointonnavmesh(var_13);
      var_14 = getgroundposition(var_13, 32, 2000, 1500);
    }

    var_16 = spawn_guard_agent(var_14, self.ref_11980, (0, 0, 180), 1, "actor_enemy_lw_br", "team_twenty");
    thread agent_mini_map_pings();
    thread agent_watch_death(var_16);

    if(var_5 < self.ref_11980.patrol_paths.size) {
      var_16.patrolpathpoints = self.ref_11980.patrol_paths[var_5];
    }

    self.ref_11980.new_rider_combat_logic = scripts\engine\utility::array_add(self.ref_11980.new_rider_combat_logic, var_16);
    waitframe();
  }
}

function agent_mini_map_pings() {
  level endon("game_ended");
  level endon("cancel_public_event");
  self endon("death");
  var_0 = 0.5;
  var_1 = 15;

  for(;;) {
    self setperk("specialty_radarblip", 1);
    wait var_0;
    self unsetperk("specialty_radarblip", 1);
    wait var_1;
  }
}

function agent_watch_death(var_0) {
  self endon("game_ended");
  self waittill("death", var_1);
  var_0.new_rider_combat_logic = scripts\engine\utility::array_remove(var_0.new_rider_combat_logic, self);

  if(isPlayer(var_1)) {
    var_1 thread scripts\mp\rank::giverankxp("kill", level.ref_12E2B.agent_killed_xp, var_1 getcurrentweapon());
    var_1 thread scripts\mp\rank::scoreeventpopup("kill");
  }

  var_2 = [];

  if(randomint(2) == 1) {
    var_2[var_2.size] = "brloot_plunder_cash_common_1";
  }

  switch (randomint(3)) {
    case 0:
      var_2[var_2.size] = "brloot_armor_plate";
      break;
    case 1:
      var_3 = randomintrange(0, level.ref_12E2B.ammo_objects.size);
      var_2[var_2.size] = level.ref_12E2B.ammo_objects[var_3];
      break;
  }

  var_4 = scripts\mp\gametypes\br_pickups::test_ai_anim();

  foreach(var_6 in var_2) {
    var_7 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_4, self.origin + (0, 0, 2), self.angles, self);
    var_8 = scripts\mp\gametypes\br_pickups::spawnpickup(var_6, var_7, 1, 1);
  }
}

function giverandomloadoutindex() {
  self endon("death");
  self endon("leaving");
  wait level.ref_12E2B.spawnregions;
  play_vo_near_location("interception_chopper_return", self.origin, 1000);
  thread givequestreward();
}

function chopper_bag_used(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0.entity.ref_11980.heli endon("leaving");
  var_5 = level.ref_12E2B.pre_pinata_uses + level.ref_12E2B.sg_ontimerexpired;
  var_6 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_7 = ref_13C2D(var_0.entity, var_0.origin, 100, [var_0.entity]);
  var_8 = var_7[2] + 2;
  var_0.entity.ref_11980.ref_13B91++;

  if(var_0.entity.ref_11980.ref_13B91 >= var_5) {
    var_0 setscriptablepartstate("scriptable_interception_bag", "unusable");

    if(level.ref_12E2B.sg_ontimerexpired) {
      level thread _handlevehiclerepair::ref_13673("interception_final_pinata", (var_0.origin[0], var_0.origin[1], var_8), randomint(3) + 2, 0);
      var_3 thread scripts\mp\rank::giverankxp("br_cacheOpen", level.ref_12E2B.cash_looted_xp_large);
      var_3 thread scripts\mp\rank::scoreeventpopup("br_cacheOpen");
    } else {
      chopper_gunner_assigntargetmarkers(var_0.entity, var_6, var_8, 1, 1);
      var_3 thread scripts\mp\rank::giverankxp("br_cacheOpen", level.ref_12E2B.cash_looted_xp_small);
      var_3 thread scripts\mp\rank::scoreeventpopup("br_cacheOpen");
    }

    play_vo_near_location("interception_empty_bag", var_0.origin, 800);
    thread givequestreward();
    return;
  }

  chopper_gunner_assigntargetmarkers(var_0.entity, var_6, var_8, 1, 1);
  var_3 thread scripts\mp\rank::giverankxp("br_cacheOpen", level.ref_12E2B.cash_looted_xp_small);
  var_3 thread scripts\mp\rank::scoreeventpopup("br_cacheOpen");

  if(var_0.entity.ref_11980.ref_13B91 == 2) {
    chopper_start_agent_spawn(var_0.entity.ref_11980.heli, 0.75, 1);
    play_vo_near_location("interception_agent_respawn", var_0.origin, 800);
    return;
  }

  if(scripts\engine\utility::cointoss()) {
    play_vo_near_location("interception_loot_bag", var_0.origin, 800);
    return;
  }
}

function givespecialistbonusifneeded() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread givequestreward();
}

function givequestreward() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;

  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\hud_message::showsplash("br_pe_interception_end");
  }

  self sethoverparams(25, 20, 10);
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "bag_out", "origin_animate_jnt");
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.ref_121FF, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("goal");
  self stoploopsound();
  self notify("heli_gone");
  giveachievementsmoke();
  giveawardfake();
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if(var_1 == self) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  if(!self.currentlyplayingvo) {
    if(!self.played25healthbark && self.health < self.maxhealth * 0.25) {
      self.played25healthbark = 1;
      self.played50healthbark = 1;
      self.played75healthbark = 1;
      play_vo_near_location("interception_chopper_health_25", self.origin, 1000);
      thread vo_bark_lockout(lookupsoundlength("interception_chopper_health_25", 1) / 1000);
    } else if(!self.played50healthbark && self.health < self.maxhealth * 0.5) {
      self.played50healthbark = 1;
      self.played75healthbark = 1;
      play_vo_near_location("interception_chopper_health_50", self.origin, 1000);
      thread vo_bark_lockout(lookupsoundlength("interception_chopper_health_50", 1) / 1000);
    } else if(!self.played75healthbark && self.health < self.maxhealth * 0.75) {
      self.played75healthbark = 1;
      play_vo_near_location("interception_chopper_health_75", self.origin, 1000);
      thread vo_bark_lockout(lookupsoundlength("interception_chopper_health_75", 1) / 1000);
    }
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function vo_bark_lockout(var_0) {
  self endon("death");
  level endon("game_ended");
  self.currentlyplayingvo = 1;
  wait var_0;
  self.currentlyplayingvo = 0;
}

function chopper_gunner_assigntargetmarkers(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(var_3) {
    var_6 = randomintrange(1, 3);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_5 = "brloot_armor_plate";
    }
  }

  if(var_4) {
    var_8 = randomintrange(1, 3);

    for(var_7 = 0; var_7 < var_8; var_7++) {
      var_9 = randomintrange(0, level.ref_12E2B.ammo_objects.size);
      var_5 = level.ref_12E2B.ammo_objects[var_9];
    }
  }

  for(var_7 = 0; var_7 < level.ref_12E2B.cash_aliases.size; var_7++) {
    var_10 = randomintrange(level.ref_12E2B.min_cash_rewards[var_7], level.ref_12E2B.max_cash_rewards[var_7] + 1);

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_5 = level.ref_12E2B.cash_aliases[var_7];
    }
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);

  foreach(var_13 in var_5) {
    var_14 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, (var_0.origin[0], var_0.origin[1], var_2), var_0.angles, var_0);
    var_15 = "";

    switch (var_13) {
      case "cashlootsm":
        var_15 = "brloot_plunder_cash_common_1";
        break;
      case "cashlootmd":
        var_15 = scripts\engine\utility::random(level.ref_12E2B.ref_11BAB);
        break;
      case "cashlootlrg":
        var_15 = scripts\engine\utility::random(level.ref_12E2B.waitteardowninfilmapomnvars);
        break;
      case "cashlootepic":
        var_15 = scripts\engine\utility::random(level.ref_12E2B.ref_14292);
        break;
      case "cashlootlegend":
        var_15 = "brloot_plunder_cash_legendary_1";
        break;
      default:
        var_15 = var_13;
        break;
    }

    var_16 = scripts\mp\gametypes\br_pickups::spawnpickup(var_15, var_14, 1, 1);
  }
}

function showquestcircletoplayer() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  }
}

function givebrbonusxp() {
  self endon("heli_gone");
  self endon("swapped");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("death", var_2, var_3, var_4, var_5);
  play_vo_near_location("interception_chopper_crash", self.origin, 1000);
  var_6 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  chopper_gunner_assigntargetmarkers(self, var_6, self.origin[2], 0, 0);

  foreach(var_8 in level.players) {
    var_8 thread scripts\mp\hud_message::showsplash("br_pe_interception_destroyed");
  }

  giveachievementsmoke();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread giveammo(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  givelaststandifneeded(var_2);
}

function handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      giveachievementwildfire();
    }
  }
}

function ref_13693(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("misc_rapelling_rope_01_fiber_br");
  var_1 linkTo(var_0, "origin_animate_jnt", (11, 20, 42), (0, 180, 0));
  var_1.animname = "plunder_extract_heli";
  var_1 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "rope_in", "origin_animate_jnt");
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("br_mercenary_extraction_delivery_bag");
  var_2 linkTo(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  var_2.animname = "plunder_extract_heli";
  var_2 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "bag_in", "origin_animate_jnt");
  var_0.rope = var_1;
  var_0.crate = var_2;
  var_2.ref_11980 = var_0.ref_11980;
}

function giveachievementsmoke() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    self.crate delete();
  }

  if(isDefined(self.ref_11980.nav_volume)) {
    self.ref_11980.nav_volume delete();
  }

  giveachievementwildfire();
}

function givelaststandifneeded(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  giveachievementwildfire();
  giveawardfake();
}

function giveawardfake() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function giveammo(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function giveachievementwildfire() {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(isDefined(self.smokevfxent)) {
    self.smokevfxent delete();
    return;
  }
}

function givequestsplash(var_0, var_1) {
  var_2 = 715;
  var_3 = ref_13C2D(var_0, 100, [self]);
  var_4 = var_3[2];
  var_5 = var_4 + var_2;
  var_1.ground_drop_point = var_3;
  return var_5;
}

function ref_13C2D(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  if(isDefined(var_6)) {
    return var_6["position"];
  }

  return undefined;
}

function ____ai_helpers() {}

function spawn_guard_agent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = "actor_enemy_lw_br";
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = "team_two_hundred";
  }

  var_6 = spawnStruct();
  var_6.is_parachute_spawner = 1;
  var_7 = _testing_ending::spawnnewparachuteagent(var_0, var_2, 1, var_4, var_5);

  if(!isDefined(var_7)) {
    return;
  }

  var_7.guid = var_7 getguid();
  var_7 setgoalvolumeauto(var_1.nav_volume);
  var_7.move_closest_chopper_boss_vandalize_node_down = 1;
  var_7 _testing_ending::ammobox_getbufferedattachmentsourceweapon();
  var_7 thread _testing_ending::alwaysdoskyspawnontacinsert();
  var_7 thread _testing_ending::activeparachutersfactionvo();
  var_7 thread _testing_ending::activestate();

  if(var_3) {
    var_7 _testing_ending::scriptable_token_scriptable_touched_callback(250);
  }

  var_7.maxsightdistsqrd = 9000000;
  level.deposit_from_compromised_convoy_delayed.ref_1363D = scripts\engine\utility::array_add(level.deposit_from_compromised_convoy_delayed.ref_1363D, var_7);
  return var_7;
}

function activate_destructible_cinderblock() {}