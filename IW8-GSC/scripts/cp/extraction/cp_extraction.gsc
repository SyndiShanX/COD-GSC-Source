/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\extraction\cp_extraction.gsc
***************************************************/

function main() {
  register_extraction_interactions();
  script_model_exfil_anims();
  level.averagealliesz = 0;
  level.extraction_func = &blank;
  level.extraction_uses = 0;
  level.extraction_cooldown = 30 + 10 * level.extraction_uses;
  level.time_till_next_extraction = level.extraction_cooldown;

  if(!isDefined(level.extraction_vehicles)) {
    level.extraction_vehicles = [];
    return;
  }
}

function blank() {}

#using_animtree("");

function script_model_exfil_anims() {
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["lbravo_exfil"] = $mp_infil_lbravo_a_pilot;
  level.scr_animname["pilot"]["lbravo_exfil"] = "mp_infil_lbravo_a_pilot";
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_pilot_loop;
  level.scr_animname["pilot"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_pilot_loop";
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_pilot_loop_exit;
  level.scr_animname["pilot"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_pilot_loop_exit";
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["lbravo_exfil"] = % mp_infil_lbravo_a_copilot;
  level.scr_animname["copilot"]["lbravo_exfil"] = "mp_infil_lbravo_a_copilot";
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_copilot_loop;
  level.scr_animname["copilot"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_copilot_loop";
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_copilot_loop_exit;
  level.scr_animname["copilot"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_copilot_loop_exit";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy1_wm;
  level.scr_animname["slot_0"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy1_wm";
  level.scr_eventanim["slot_0"]["lbravo_exfil"] = "infil_lbravo_a_1";
  level.scr_anim["slot_0"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy1_exit_wm;
  level.scr_animname["slot_0"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy1_exit_wm";
  level.scr_eventanim["slot_0"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_1";
  level.scr_anim["slot_0"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy1_loop_wm;
  level.scr_animname["slot_0"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy1_loop_wm";
  level.scr_eventanim["slot_0"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_1";
  level.scr_anim["slot_0"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
  level.scr_animname["slot_0"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
  level.scr_eventanim["slot_0"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy2_wm;
  level.scr_animname["slot_1"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy2_wm";
  level.scr_eventanim["slot_1"]["lbravo_exfil"] = "infil_lbravo_a_2";
  level.scr_anim["slot_1"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy2_exit_wm;
  level.scr_animname["slot_1"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy2_exit_wm";
  level.scr_eventanim["slot_1"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_2";
  level.scr_anim["slot_1"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy2_loop_wm;
  level.scr_animname["slot_1"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy2_loop_wm";
  level.scr_eventanim["slot_1"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_2";
  level.scr_anim["slot_1"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
  level.scr_animname["slot_1"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
  level.scr_eventanim["slot_1"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy3_wm;
  level.scr_animname["slot_2"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy3_wm";
  level.scr_eventanim["slot_2"]["lbravo_exfil"] = "infil_lbravo_a_3";
  level.scr_anim["slot_2"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy3_exit_wm;
  level.scr_animname["slot_2"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy3_exit_wm";
  level.scr_eventanim["slot_2"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_3";
  level.scr_anim["slot_2"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy3_loop_wm;
  level.scr_animname["slot_2"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy3_loop_wm";
  level.scr_eventanim["slot_2"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_3";
  level.scr_anim["slot_2"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
  level.scr_animname["slot_2"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
  level.scr_eventanim["slot_2"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy4_wm;
  level.scr_animname["slot_3"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy4_wm";
  level.scr_eventanim["slot_3"]["lbravo_exfil"] = "infil_lbravo_a_4";
  level.scr_anim["slot_3"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy4_exit_wm;
  level.scr_animname["slot_3"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy4_exit_wm";
  level.scr_eventanim["slot_3"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_4";
  level.scr_anim["slot_3"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy4_loop_wm;
  level.scr_animname["slot_3"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy4_loop_wm";
  level.scr_eventanim["slot_3"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_4";
  level.scr_anim["slot_3"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
  level.scr_animname["slot_3"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
  level.scr_eventanim["slot_3"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy5_wm;
  level.scr_animname["slot_4"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy5_wm";
  level.scr_eventanim["slot_4"]["lbravo_exfil"] = "infil_lbravo_a_5";
  level.scr_anim["slot_4"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy5_exit_wm;
  level.scr_animname["slot_4"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy5_exit_wm";
  level.scr_eventanim["slot_4"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_5";
  level.scr_anim["slot_4"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy5_loop_wm;
  level.scr_animname["slot_4"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy5_loop_wm";
  level.scr_eventanim["slot_4"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_5";
  level.scr_anim["slot_4"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
  level.scr_animname["slot_4"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
  level.scr_eventanim["slot_4"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy6_wm;
  level.scr_animname["slot_5"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy6_wm";
  level.scr_eventanim["slot_5"]["lbravo_exfil"] = "infil_lbravo_a_6";
  level.scr_anim["slot_5"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy6_exit_wm;
  level.scr_animname["slot_5"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy6_exit_wm";
  level.scr_eventanim["slot_5"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_6";
  level.scr_anim["slot_5"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy6_loop_wm;
  level.scr_animname["slot_5"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy6_loop_wm";
  level.scr_eventanim["slot_5"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_6";
  level.scr_anim["slot_5"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
  level.scr_animname["slot_5"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
  level.scr_eventanim["slot_5"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_6";
}

function activate_extraction_flare() {
  if(istrue(self.bgivensentry)) {
    return;
  }

  if(istrue(self.tablet_out)) {
    return;
  }

  if(istrue(self.waiting_to_spawn)) {
    return;
  }

  if(self isskydiving()) {
    return;
  }

  if(istrue(self.spectating)) {
    return;
  }

  if(istrue(self.isreviving)) {
    return;
  }

  if(istrue(self.inlaststand)) {
    return;
  }

  if(!istrue(self.extraction_active)) {
    self iprintln("^3 Extraction on Cooldown for the next ^1" + level.time_till_next_extraction + " ^3 Seconds");
    return;
  }

  if(isDefined(level.extraction_vehicle)) {
    self iprintln("^3 Extraction Vehicle already present in the map at ^1" + level.extraction_vehicle.origin);
    return;
  }

  level.extraction_uses++;
  level.extraction_in_progress = 1;

  foreach(var_1 in level.players) {
    var_1 notify("toggle_extraction_function", 0, self);
  }

  level.extraction_in_progress = undefined;
}

function get_extraction_cooldown() {
  level.extraction_cooldown = 30 + 10 * level.extraction_uses;
  return level.extraction_cooldown;
}

function toggle_extraction_functionality_after_timeout(var_0, var_1) {
  level.extraction_in_progress = 1;
  self notify("toggle_extraction_function", 0, var_1);
  level.time_till_next_extraction = level.extraction_cooldown;
  thread time_till_next_extraction_tick();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var_1);
  level.extraction_in_progress = undefined;
}

function turn_on_after_timeout(var_0, var_1) {
  level.time_till_next_extraction = level.extraction_cooldown;
  thread time_till_next_extraction_tick();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var_1);
}

function time_till_next_extraction_tick() {
  for(;;) {
    if(level.time_till_next_extraction <= 0) {
      break;
    }

    level.time_till_next_extraction--;
    wait 1;
  }
}

function extraction_function_toggle() {
  self notify("extraction_function_toggle");
  self endon("extraction_function_toggle");

  for(;;) {
    self waittill("toggle_extraction_function", var_0, var_1);

    if(istrue(var_0)) {
      if(!istrue(self.extraction_active)) {
        foreach(var_3 in level.players) {
          var_3.extraction_active = 1;
        }
      }

      continue;
    }

    if(self == var_1) {
      if(!isDefined(self.extractioninfo)) {
        var_5 = spawnStruct();
        var_5.owner = self;
        var_5.streakname = "extraction";
        var_5.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp");
        self.extractioninfo = var_5;
      }

      var_6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(self.extractioninfo, self.extractioninfo.deployweaponobj, "grenade_fire", undefined, &scripts\cp_mp\killstreaks\airdrop::airdropmarkerswitchended, &airdropmarkerfired, undefined, &scripts\cp_mp\killstreaks\airdrop::airdropmarkertaken);

      if(!istrue(var_6)) {
        continue;
      }
    }

    level.extraction_uses++;
    level.extraction_in_progress = 1;
    level.extraction_in_progress = undefined;
    self iprintln(" Extraction FUNCTION ON COOLDOWN ");

    foreach(var_3 in level.players) {
      thread turn_on_after_timeout(var_3, get_extraction_cooldown());
    }
  }
}

function airdropmarkerfired(var_0, var_1, var_2) {
  var_0.airdroptype = var_0.streakname;
  var_2.owner = self;
  thread airdropmarkeractivate(var_2);
  var_0.airdropmarkerfired = 1;
  return "success";
}

function airdropmarkeractivate(var_0, var_1) {
  level endon("game_ended");
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  var_2 = self.owner.angles;
  self waittill("explode", var_3);
  var_4 = self.owner;

  if(!isDefined(var_4)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isKillStreakDenied")]]()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  waitframe();
  weapondetonatedextraction(var_4.extractioninfo, var_3, var_4);
}

function weapondetonatedextraction(var_0, var_1, var_2) {
  level.extraction_structs = scripts\engine\utility::get_array_of_closest(var_1, scripts\engine\utility::getStructArray("cp_donetsk_heli_spawns", "targetname"), undefined, 1, 6669);
  var_3 = (var_1[0], var_1[1], 5000);

  if(level.script == "cp_donetsk") {
    if(level.extraction_structs.size > 0) {
      var_3 = (level.extraction_structs[0].origin[0], level.extraction_structs[0].origin[1], 5000);
    }
  }

  var_4 = (0, randomfloat(360), 0);
  var_5 = var_3 + -1 * anglesToForward(var_4) * 30000;
  var_3 *= (1, 1, 0);
  var_6 = var_3 + (0, 0, 5000);
  var_7 = 5000;
  level.extraction_vehicle = spawnlittlebird(0, var_2, var_5, var_6, var_2.extractioninfo, var_3);
  var_8 = vectortoangles(var_6 - var_5);
  level.extraction_vehicle.vehiclename = "little_bird";
  level.extraction_vehicle.speed = 50;
  level.extraction_vehicle.accel = 125;
  level.extraction_vehicle.isheli = 1;
  level.extraction_vehicle.vehicletype = "apache";
  level.extraction_vehicle vehicle_setspeed(level.extraction_vehicle.speed, level.extraction_vehicle.accel);
  level.extraction_vehicle sethoverparams(50, 100, 50);
  level.extraction_vehicle setturningability(0.05);
  level.extraction_vehicle setotherent(var_2);
  level.extraction_vehicle.pathgoal = var_6;
  var_9 = randomint(10);
  var_10 = 10 + var_9;
  thread monitorarriveoverdestination(var_2, level.extraction_vehicle, var_1, "allies");
  level notify("extraction_called");
}

function spawnlittlebird(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 99;
  var_8 = 99999;
  var_9 = spawnhelicopter(var_1, var_2, var_6, "lbravo_infil_mp", "veh8_mil_air_lbravo");

  if(!isDefined(var_9)) {
    return;
  }

  if(isDefined(var_5)) {
    var_9.lz = scripts\engine\utility::drop_to_ground(var_5) + (0, 0, 150);
  }

  var_9.damagecallback = &callback_vehicledamage;
  var_10 = 1;
  var_9.speed = 50;
  var_9.accel = 125;
  var_9.health = var_8;
  var_9.maxhealth = var_9.health;
  var_9.team = var_1.team;
  var_9.owner = var_1;
  var_9 setCanDamage(var_10);
  var_9.defendloc = var_3;
  var_9.lifeid = var_0;
  var_9.jackal = 1;
  var_9.streakinfo = var_4;
  var_9.streakname = var_4.streakname;
  var_9.streakinfo = var_4;
  var_9.flaresreservecount = var_7;
  var_9 setmaxpitchroll(0, 90);
  var_9 vehicle_setspeed(var_9.speed, var_9.accel);
  var_9 sethoverparams(50, 100, 50);
  var_9 setturningability(0.05);
  var_9 setyawspeed(45, 25, 25, 0.5);
  var_9 setotherent(var_1);
  var_9.exfilspace = level.players.size;
  var_11 = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(var_11, "current");
  objective_position(var_11, var_9.lz + (0, 0, 20));
  objective_icon(var_11, "icon_waypoint_extract");
  objective_setminimapiconsize(var_11, "icon_regular");
  objective_setshowdistance(var_11, 1);
  objective_setplayintro(var_11, 1);
  thread show_exfil_progress(level, var_11, var_2, var_3);
  var_9 thread scripts\cp\infilexfil\blima_exfil::keep_from_crushing_players();
  var_9.objnum = var_11;
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_9);
  var_9.occupancy = [];
  var_9.passengers[0] = self;
  var_9.passengers[1] = self;
  var_9.passengers[2] = self;
  var_9.passengers[3] = self;
  var_9.passengers[4] = self;
  var_9.passengers[5] = self;
  init_useprompt_interactions(var_9);
  level.extraction_vehicles[level.extraction_vehicles.size] = var_9;
  level.extraction_vehicles = scripts\engine\utility::array_removeundefined(level.extraction_vehicles);
  var_9 thread scripts\cp\cp_flares::flares_handleincomingstinger(undefined, undefined);
  thread littlebirddestroyed();
  return var_9;
}

function show_exfil_progress(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  var_3 endon("goal");
  level endon("vehicle_descent");
  objective_setlabel(var_0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  var_4 = distance(var_1, var_2) / 50;

  for(;;) {
    wait 1;
    var_5 = distance(var_3.origin, var_2) / 50;
    objective_setprogress(var_0, var_5 / var_4);

    if(var_5 <= 0) {
      return;
    }
  }
}

function init_useprompt_interactions(var_0) {
  self.interactiontriggers = [];
  var_1 = self gettagorigin("tag_passenger1");
  var_2 = self gettagorigin("tag_passenger2");
  var_3 = self gettagorigin("tag_passenger3");
  var_4 = self gettagorigin("tag_passenger4");
  var_5 = self gettagorigin("tag_passenger5");
  var_6 = self gettagorigin("tag_passenger6");
  create_exfil_interaction(var_2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var_0);
  create_exfil_interaction(var_3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var_0);
  create_exfil_interaction(var_5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var_0);
  create_exfil_interaction(var_6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var_0);
}

function create_exfil_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 linkTo(self);
  var_4 setHintString(var_1);
  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("hide");
  var_4 setuseholdduration("duration_short");
  thread exfil_use_think(var_4, self, var_2);
  self.interactiontriggers[self.interactiontriggers.size] = var_4;
}

function exfil_use_think(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    makechopperseatplayerusable(var_2);
    goto LOC_00000023;
  }

  makechopperseatteamusable(var_0.team);

  for(;;) {
    self waittill("trigger", var_3);
    self makeunusable();
    exfilusetriggerused(var_0, var_3, var_1, self);
  }
}

function makechopperseatteamusable(var_0) {
  self makeusable();
  thread _updatechopperseatteamusable(var_0);
}

function makechopperseatplayerusable(var_0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var_0);
}

function _updatechopperseatteamusable(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

function _updatechopperseatplayerusable(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

function exfilusetriggerused(var_0, var_1, var_2) {
  if(!isDefined(self.exfilspace)) {
    self.exfilspace = level.players.size;
  }

  if(self.exfilspace > 0) {
    thread playeranimlinktochopper(var_0, self);
    self.occupancy = scripts\engine\utility::array_add(self.occupancy, var_0);
    var_2.occupied = var_0;

    foreach(var_4 in self.interactiontriggers) {
      if(var_4 != var_2) {
        thread makechopperseatteamusable(var_4);
      }
    }

    thread disableotherseats(var_0, var_1, var_2);
    self.exfilspace--;

    if(self.exfilspace <= 0) {
      self notify("exfil_leave");
      return;
    }

    return;
  }

  self notify("exfil_leave");
}

function disableotherseats(var_0, var_1, var_2) {
  foreach(var_4 in self.interactiontriggers) {
    var_4 disableplayeruse(var_0);
  }

  if(isDefined(var_2)) {
    thread enableexitprompt(var_0, var_1, self);
    return;
  }
}

function enableexitprompt(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("tag_origin");
  var_3 linkTo(self);
  var_3 setHintString(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var_3 setCursorHint("HINT_NOICON");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 sethintonobstruction("hide");
  var_3 setuseholdduration("duration_short");
  thread exfil_hopoff_think(var_3, var_1, self, var_0);
  var_1.exitinteract = var_3;
}

function exfil_hopoff_think(var_0, var_1, var_2, var_3) {
  makechopperseatplayerusable(var_1);

  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1 lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
    var_0.exfilspace++;
    var_1 stopanimscriptsceneevent();
    var_0 scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var_1.player_rig unlink();
    var_1 unlink();
    makechopperseatteamusable(var_3, var_0.team);
    var_0.occupancy = scripts\engine\utility::array_remove(var_0.occupancy, var_1);
    var_3.occupied = undefined;

    foreach(var_5 in level.players) {
      if(scripts\engine\utility::array_contains(var_0.occupancy, var_5)) {
        var_3 hidefromplayer(var_5);
        var_3 disableplayeruse(var_5);
      }
    }

    foreach(var_8 in var_0.interactiontriggers) {
      if(!isDefined(var_8.occupied)) {
        var_8 showtoplayer(var_1);
        var_8 enableplayeruse(var_1);
        continue;
      }

      var_8 hidefromplayer(var_8.occupied);
      var_8 disableplayeruse(var_8.occupied);
    }

    var_1 notify("remove_rig");
    var_1.player_rig delete();
    var_0 notify("unloaded");
    self delete();
  }
}

function playerlinktochopper(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_0 playerlinkTo(var_1, "tag_passenger" + var_2, 1, 180, -180, 180, 180, 0);
}

function playeranimlinktochopper(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0.passengers.size; var_2++) {
      if(var_0.passengers[var_2] == var_0.extractzone) {
        var_0.passengers[var_2] = self;
        var_1 = var_2;
      }
    }

    thread disableotherseats(var_0);
  }

  thread extraction_infil_player_rig("slot_" + var_1, "viewhands_base_iw8");
  self.player_rig linkTo(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
    case 0:
      self lerpviewangleclamp(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self lerpviewangleclamp(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self lerpviewangleclamp(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self lerpviewangleclamp(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("game_ended");
  self.extracted = 1;
  rideloop(var_0);
}

function extraction_infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  self predictstreampos(self.origin);
  var_3 = spawn("script_arms", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");
  scripts\engine\utility::ref_143A5("remove_rig", "player_free_spot");

  if(isDefined(var_2) && var_2) {
    self playersetgroundreferenceent(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function rideloop(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0 endon("unload");
  var_0 endon("unloaded");

  while(isDefined(var_0)) {
    var_0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function register_extraction_interactions() {
  scripts\cp\cp_interaction::registerinteraction("extraction", &hint_extraction, &activate_extraction, &init_extraction, 0, "duration_long");
}

function init_extraction(var_0) {
  if(var_0.size > 0) {
    foreach(var_2 in var_0) {}

    return;
  }
}

function hint_extraction(var_0, var_1) {
  return &"";
}

function activate_extraction(var_0, var_1) {}

function delayjackalloopsfx(var_0, var_1) {
  self endon("death");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

function littlebirddestroyed() {
  self endon("jackal_gone");
  var_0 = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread littlebirdcrash(75);
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz)) {
    self.lz notify("extraction_destroyed");
  }

  littlebirdexplode();
}

function littlebirdexplode() {
  self playSound("dropship_explode_mp");
  level.extraction_vehicles[level.extraction_vehicles.size - 1] = undefined;
  self notify("explode");
  wait 0.35;
  thread littlebirddelete();
}

function littlebirddelete() {
  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(var_1 in self.interactiontriggers) {
    var_1 delete();
  }

  self delete();
}

function littlebirdcrash(var_0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {}
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function monitorarriveoverdestination(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  thread changemaxpitchrollwhenclosetogoal(var_0);
  var_0 waittill("goal");
  level notify("vehicle_descent");

  if(isDefined(var_0.objnum)) {
    objective_delete(var_0.objnum);
  }

  thread watchgameendleave();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_2.speed / 4;
    var_5 = var_2.accel / 6;
  }

  var_2 vehicle_setspeed(var_4, var_5);
  littlebirddescendtoextraction(var_2, var_3, var_2.zone, var_4);
}

function littlebirdleave() {
  self endon("death");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();
  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + (0, 0, 5000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 5000;
  var_4 += (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var_5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("goal");
  self stoploopsound();
  level.extraction_vehicles[level.extraction_vehicles.size - 1] = undefined;
  self notify("jackal_gone");

  if(self.occupancy.size == level.players.size) {
    level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
  } else {
    foreach(var_7 in self.occupancy) {
      var_7 iprintln(" GAME OVER OVER OVER OVER!! ");
      kick(var_7 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
    }
  }

  littlebirddelete();
}

function getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function littlebirddescendtoextraction(var_0, var_1, var_2) {
  descend(var_0, var_1);
  scripts\engine\utility::ref_143B9(60, "infinite");
  thread littlebirdleave();
}

function descend(var_0, var_1) {
  self endon("bugOut");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = tracegroundheight(var_3, var_4, 0);
  var_2 = (var_3, var_4, var_5);
  var_2 = self.lz;
  self clearlookatent();
  self setvehgoalpos(var_2, 1);
  self waittill("goal");
  self sethoverparams(0, 0, 0);
  self vehicle_setspeedimmediate(0);
}

function tracegroundheight(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = tracegroundpoint(var_0, var_1, var_3);
  var_6 = var_5 + var_4;
  return var_6;
}

function tracegroundpoint(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level.averagealliesz;
  var_6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_8 in self.dropcrates) {
      var_6 = var_8;
    }
  }

  var_10 = 256;

  if(isDefined(var_2)) {
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  } else {
    var_11 = scripts\engine\trace::sphere_trace((var_1, var_2, var_5), (var_1, var_2, var_4), 256, var_10, undefined, 1);
  }

  if(var_11["position"][2] < var_6) {
    var_12 = var_6;
  } else {
    var_12 = var_12["position"][2];
  }

  return var_12;
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

function changemaxpitchrollwhenclosetogoal(var_0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function abortextractpickup() {
  thread littlebirdleave();
}