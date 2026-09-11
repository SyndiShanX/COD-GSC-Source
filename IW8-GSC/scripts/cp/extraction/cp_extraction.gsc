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

  foreach(var1 in level.players) {
    var1 notify("toggle_extraction_function", 0, self);
  }

  level.extraction_in_progress = undefined;
}

function get_extraction_cooldown() {
  level.extraction_cooldown = 30 + 10 * level.extraction_uses;
  return level.extraction_cooldown;
}

function toggle_extraction_functionality_after_timeout(var0, var1) {
  level.extraction_in_progress = 1;
  self notify("toggle_extraction_function", 0, var1);
  level.time_till_next_extraction = level.extraction_cooldown;
  thread time_till_next_extraction_tick();
  var2 = gettime() + var0 * 1000;

  for(var3 = var0; var3 >= 0; var3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var1);
  level.extraction_in_progress = undefined;
}

function turn_on_after_timeout(var0, var1) {
  level.time_till_next_extraction = level.extraction_cooldown;
  thread time_till_next_extraction_tick();
  var2 = gettime() + var0 * 1000;

  for(var3 = var0; var3 >= 0; var3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var1);
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
    self waittill("toggle_extraction_function", var0, var1);

    if(istrue(var0)) {
      if(!istrue(self.extraction_active)) {
        foreach(var3 in level.players) {
          var3.extraction_active = 1;
        }
      }

      continue;
    }

    if(self == var1) {
      if(!isDefined(self.extractioninfo)) {
        var5 = spawnStruct();
        var5.owner = self;
        var5.streakname = "extraction";
        var5.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp");
        self.extractioninfo = var5;
      }

      var6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(self.extractioninfo, self.extractioninfo.deployweaponobj, "grenade_fire", undefined, &scripts\cp_mp\killstreaks\airdrop::airdropmarkerswitchended, &airdropmarkerfired, undefined, &scripts\cp_mp\killstreaks\airdrop::airdropmarkertaken);

      if(!istrue(var6)) {
        continue;
      }
    }

    level.extraction_uses++;
    level.extraction_in_progress = 1;
    level.extraction_in_progress = undefined;
    self iprintln(" Extraction FUNCTION ON COOLDOWN ");

    foreach(var3 in level.players) {
      thread turn_on_after_timeout(var3, get_extraction_cooldown());
    }
  }
}

function airdropmarkerfired(var0, var1, var2) {
  var0.airdroptype = var0.streakname;
  var2.owner = self;
  thread airdropmarkeractivate(var2);
  var0.airdropmarkerfired = 1;
  return "success";
}

function airdropmarkeractivate(var0, var1) {
  level endon("game_ended");
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  var2 = self.owner.angles;
  self waittill("explode", var3);
  var4 = self.owner;

  if(!isDefined(var4)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  if(var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isKillStreakDenied")]]()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  waitframe();
  weapondetonatedextraction(var4.extractioninfo, var3, var4);
}

function weapondetonatedextraction(var0, var1, var2) {
  level.extraction_structs = scripts\engine\utility::get_array_of_closest(var1, scripts\engine\utility::getStructArray("cp_donetsk_heli_spawns", "targetname"), undefined, 1, 6669);
  var3 = (var1[0], var1[1], 5000);

  if(level.script == "cp_donetsk") {
    if(level.extraction_structs.size > 0) {
      var3 = (level.extraction_structs[0].origin[0], level.extraction_structs[0].origin[1], 5000);
    }
  }

  var4 = (0, randomfloat(360), 0);
  var5 = var3 + -1 * anglesToForward(var4) * 30000;
  var3 *= (1, 1, 0);
  var6 = var3 + (0, 0, 5000);
  var7 = 5000;
  level.extraction_vehicle = spawnlittlebird(0, var2, var5, var6, var2.extractioninfo, var3);
  var8 = vectortoangles(var6 - var5);
  level.extraction_vehicle.vehiclename = "little_bird";
  level.extraction_vehicle.speed = 50;
  level.extraction_vehicle.accel = 125;
  level.extraction_vehicle.isheli = 1;
  level.extraction_vehicle.vehicletype = "apache";
  level.extraction_vehicle vehicle_setspeed(level.extraction_vehicle.speed, level.extraction_vehicle.accel);
  level.extraction_vehicle sethoverparams(50, 100, 50);
  level.extraction_vehicle setturningability(0.05);
  level.extraction_vehicle setotherent(var2);
  level.extraction_vehicle.pathgoal = var6;
  var9 = randomint(10);
  var10 = 10 + var9;
  thread monitorarriveoverdestination(var2, level.extraction_vehicle, var1, "allies");
  level notify("extraction_called");
}

function spawnlittlebird(var0, var1, var2, var3, var4, var5) {
  var6 = vectortoangles(var3 - var2);
  var7 = 99;
  var8 = 99999;
  var9 = spawnhelicopter(var1, var2, var6, "lbravo_infil_mp", "veh8_mil_air_lbravo");

  if(!isDefined(var9)) {
    return;
  }

  if(isDefined(var5)) {
    var9.lz = scripts\engine\utility::drop_to_ground(var5) + (0, 0, 150);
  }

  var9.damagecallback = &callback_vehicledamage;
  var10 = 1;
  var9.speed = 50;
  var9.accel = 125;
  var9.health = var8;
  var9.maxhealth = var9.health;
  var9.team = var1.team;
  var9.owner = var1;
  var9 setCanDamage(var10);
  var9.defendloc = var3;
  var9.lifeid = var0;
  var9.jackal = 1;
  var9.streakinfo = var4;
  var9.streakname = var4.streakname;
  var9.streakinfo = var4;
  var9.flaresreservecount = var7;
  var9 setmaxpitchroll(0, 90);
  var9 vehicle_setspeed(var9.speed, var9.accel);
  var9 sethoverparams(50, 100, 50);
  var9 setturningability(0.05);
  var9 setyawspeed(45, 25, 25, 0.5);
  var9 setotherent(var1);
  var9.exfilspace = level.players.size;
  var11 = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(var11, "current");
  objective_position(var11, var9.lz + (0, 0, 20));
  objective_icon(var11, "icon_waypoint_extract");
  objective_setminimapiconsize(var11, "icon_regular");
  objective_setshowdistance(var11, 1);
  objective_setplayintro(var11, 1);
  thread show_exfil_progress(level, var11, var2, var3);
  var9 thread scripts\cp\infilexfil\blima_exfil::keep_from_crushing_players();
  var9.objnum = var11;
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var9);
  var9.occupancy = [];
  var9.passengers[0] = self;
  var9.passengers[1] = self;
  var9.passengers[2] = self;
  var9.passengers[3] = self;
  var9.passengers[4] = self;
  var9.passengers[5] = self;
  init_useprompt_interactions(var9);
  level.extraction_vehicles[level.extraction_vehicles.size] = var9;
  level.extraction_vehicles = scripts\engine\utility::array_removeundefined(level.extraction_vehicles);
  var9 thread scripts\cp\cp_flares::flares_handleincomingstinger(undefined, undefined);
  thread littlebirddestroyed();
  return var9;
}

function show_exfil_progress(var0, var1, var2, var3) {
  var3 endon("death");
  var3 endon("goal");
  level endon("vehicle_descent");
  objective_setlabel(var0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var0, 1);
  objective_setprogress(var0, 0);
  objective_setbackground(var0, 1);
  var4 = distance(var1, var2) / 50;

  for(;;) {
    wait 1;
    var5 = distance(var3.origin, var2) / 50;
    objective_setprogress(var0, var5 / var4);

    if(var5 <= 0) {
      return;
    }
  }
}

function init_useprompt_interactions(var0) {
  self.interactiontriggers = [];
  var1 = self gettagorigin("tag_passenger1");
  var2 = self gettagorigin("tag_passenger2");
  var3 = self gettagorigin("tag_passenger3");
  var4 = self gettagorigin("tag_passenger4");
  var5 = self gettagorigin("tag_passenger5");
  var6 = self gettagorigin("tag_passenger6");
  create_exfil_interaction(var2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var0);
  create_exfil_interaction(var3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var0);
  create_exfil_interaction(var5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var0);
  create_exfil_interaction(var6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var0);
}

function create_exfil_interaction(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0);
  var4 setModel("tag_origin");
  var4 linkTo(self);
  var4 setHintString(var1);
  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(200);
  var4 sethintdisplayfov(90);
  var4 setuserange(72);
  var4 setusefov(90);
  var4 sethintonobstruction("hide");
  var4 setuseholdduration("duration_short");
  thread exfil_use_think(var4, self, var2);
  self.interactiontriggers[self.interactiontriggers.size] = var4;
}

function exfil_use_think(var0, var1, var2) {
  if(isDefined(var2)) {
    makechopperseatplayerusable(var2);
    goto LOC_00000023;
  }

  makechopperseatteamusable(var0.team);

  for(;;) {
    self waittill("trigger", var3);
    self makeunusable();
    exfilusetriggerused(var0, var3, var1, self);
  }
}

function makechopperseatteamusable(var0) {
  self makeusable();
  thread _updatechopperseatteamusable(var0);
}

function makechopperseatplayerusable(var0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var0);
}

function _updatechopperseatteamusable(var0) {
  self endon("death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2.team == var0) {
        self showtoplayer(var2);
        self enableplayeruse(var2);
        continue;
      }

      self disableplayeruse(var2);
      self hidefromplayer(var2);
    }

    level waittill("joined_team");
  }
}

function _updatechopperseatplayerusable(var0) {
  self endon("death");

  for(;;) {
    foreach(var2 in level.players) {
      if(var2 == var0) {
        self showtoplayer(var2);
        self enableplayeruse(var2);
        continue;
      }

      self disableplayeruse(var2);
      self hidefromplayer(var2);
    }

    level waittill("joined_team");
  }
}

function exfilusetriggerused(var0, var1, var2) {
  if(!isDefined(self.exfilspace)) {
    self.exfilspace = level.players.size;
  }

  if(self.exfilspace > 0) {
    thread playeranimlinktochopper(var0, self);
    self.occupancy = scripts\engine\utility::array_add(self.occupancy, var0);
    var2.occupied = var0;

    foreach(var4 in self.interactiontriggers) {
      if(var4 != var2) {
        thread makechopperseatteamusable(var4);
      }
    }

    thread disableotherseats(var0, var1, var2);
    self.exfilspace--;

    if(self.exfilspace <= 0) {
      self notify("exfil_leave");
      return;
    }

    return;
  }

  self notify("exfil_leave");
}

function disableotherseats(var0, var1, var2) {
  foreach(var4 in self.interactiontriggers) {
    var4 disableplayeruse(var0);
  }

  if(isDefined(var2)) {
    thread enableexitprompt(var0, var1, self);
    return;
  }
}

function enableexitprompt(var0, var1, var2) {
  var3 = spawn("script_model", self.origin);
  var3 setModel("tag_origin");
  var3 linkTo(self);
  var3 setHintString(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var3 setCursorHint("HINT_NOICON");
  var3 sethintdisplayrange(200);
  var3 sethintdisplayfov(90);
  var3 setuserange(200);
  var3 setusefov(360);
  var3 sethintonobstruction("hide");
  var3 setuseholdduration("duration_short");
  thread exfil_hopoff_think(var3, var1, self, var0);
  var1.exitinteract = var3;
}

function exfil_hopoff_think(var0, var1, var2, var3) {
  makechopperseatplayerusable(var1);

  for(;;) {
    self waittill("trigger", var1);
    self makeunusable();
    var1 lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
    var0.exfilspace++;
    var1 stopanimscriptsceneevent();
    var0 scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var1.player_rig unlink();
    var1 unlink();
    makechopperseatteamusable(var3, var0.team);
    var0.occupancy = scripts\engine\utility::array_remove(var0.occupancy, var1);
    var3.occupied = undefined;

    foreach(var5 in level.players) {
      if(scripts\engine\utility::array_contains(var0.occupancy, var5)) {
        var3 hidefromplayer(var5);
        var3 disableplayeruse(var5);
      }
    }

    foreach(var8 in var0.interactiontriggers) {
      if(!isDefined(var8.occupied)) {
        var8 showtoplayer(var1);
        var8 enableplayeruse(var1);
        continue;
      }

      var8 hidefromplayer(var8.occupied);
      var8 disableplayeruse(var8.occupied);
    }

    var1 notify("remove_rig");
    var1.player_rig delete();
    var0 notify("unloaded");
    self delete();
  }
}

function playerlinktochopper(var0, var1, var2) {
  level endon("game_ended");
  var0.extracted = 1;
  var0.spawnprotection = 1;

  while(!var0 isonground()) {
    waitframe();
  }

  var0 allowmovement(0);
  var0 playerlinkTo(var1, "tag_passenger" + var2, 1, 180, -180, 180, 180, 0);
}

function playeranimlinktochopper(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var1)) {
    for(var2 = 0; var2 < var0.passengers.size; var2++) {
      if(var0.passengers[var2] == var0.extractzone) {
        var0.passengers[var2] = self;
        var1 = var2;
      }
    }

    thread disableotherseats(var0);
  }

  thread extraction_infil_player_rig("slot_" + var1, "viewhands_base_iw8");
  self.player_rig linkTo(var0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var1) {
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
  rideloop(var0);
}

function extraction_infil_player_rig(var0, var1, var2) {
  self.animname = var0;
  self predictstreampos(self.origin);
  var3 = spawn("script_arms", self.origin, 0, 0, self);
  var3.angles = self.angles;
  var3.player = self;
  self.player_rig = var3;
  self.player_rig hide(1);
  self.player_rig.animname = var0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var2) && var2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");
  scripts\engine\utility::ref_143a5("remove_rig", "player_free_spot");

  if(isDefined(var2) && var2) {
    self playersetgroundreferenceent(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function rideloop(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var0 endon("unload");
  var0 endon("unloaded");

  while(isDefined(var0)) {
    var0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

function register_extraction_interactions() {
  scripts\cp\cp_interaction::registerinteraction("extraction", &hint_extraction, &activate_extraction, &init_extraction, 0, "duration_long");
}

function init_extraction(var0) {
  if(var0.size > 0) {
    foreach(var2 in var0) {}

    return;
  }
}

function hint_extraction(var0, var1) {
  return &"";
}

function activate_extraction(var0, var1) {}

function delayjackalloopsfx(var0, var1) {
  self endon("death");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var0);
  self playLoopSound(var1);
}

function littlebirddestroyed() {
  self endon("jackal_gone");
  var0 = self.owner;
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

  foreach(var1 in self.interactiontriggers) {
    var1 delete();
  }

  self delete();
}

function littlebirdcrash(var0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var0, var0, var0);
  self settargetyaw(self.angles[1] + var0 * 2.5);
}

function callback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(isDefined(var1)) {
    if(isDefined(var1.owner)) {
      var1 = var1.owner;
    }
  }

  if((var1 == self || isDefined(var1.pers) && var1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  if(self.health <= var2) {
    if(isPlayer(var1) && (!isDefined(self.owner) || var1 != self.owner)) {}
  }

  if(self.health - var2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function monitorarriveoverdestination(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("leaving");
  var0 setvehgoalpos(var0.pathgoal, 1);
  thread changemaxpitchrollwhenclosetogoal(var0);
  var0 waittill("goal");
  level notify("vehicle_descent");

  if(isDefined(var0.objnum)) {
    objective_delete(var0.objnum);
  }

  thread watchgameendleave();

  if(isDefined(var3)) {
    var4 = var0.speed;
    var5 = var0.accel;
  } else {
    var4 = var2.speed / 4;
    var5 = var2.accel / 6;
  }

  var2 vehicle_setspeed(var4, var5);
  littlebirddescendtoextraction(var2, var3, var2.zone, var4);
}

function littlebirdleave() {
  self endon("death");
  var0 = self.speed;
  var1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.leaving = 1;
  self clearlookatent();
  var2 = int(self.speed / 14);
  var3 = int(self.accel / 16);

  if(isDefined(var0)) {
    var2 = var0;
  }

  if(isDefined(var1)) {
    var3 = var1;
  }

  self vehicle_setspeed(var2, var3);
  var4 = self.origin + (0, 0, 5000);
  self setvehgoalpos(var4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var4 = self.origin + anglesToForward((0, randomint(360), 0)) * 5000;
  var4 += (0, 0, 1000);
  self setvehgoalpos(var4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var5, 1);
  self waittill("goal");
  self stoploopsound();
  level.extraction_vehicles[level.extraction_vehicles.size - 1] = undefined;
  self notify("jackal_gone");

  if(self.occupancy.size == level.players.size) {
    level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
  } else {
    foreach(var7 in self.occupancy) {
      var7 iprintln(" GAME OVER OVER OVER OVER!! ");
      kick(var7 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
    }
  }

  littlebirddelete();
}

function getpathend() {
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function littlebirddescendtoextraction(var0, var1, var2) {
  descend(var0, var1);
  scripts\engine\utility::ref_143b9(60, "infinite");
  thread littlebirdleave();
}

function descend(var0, var1) {
  self endon("bugOut");
  var2 = undefined;
  var3 = var0[0];
  var4 = var0[1];
  var5 = tracegroundheight(var3, var4, 0);
  var2 = (var3, var4, var5);
  var2 = self.lz;
  self clearlookatent();
  self setvehgoalpos(var2, 1);
  self waittill("goal");
  self sethoverparams(0, 0, 0);
  self vehicle_setspeedimmediate(0);
}

function tracegroundheight(var0, var1, var2, var3) {
  var4 = 30;
  var5 = tracegroundpoint(var0, var1, var3);
  var6 = var5 + var4;
  return var6;
}

function tracegroundpoint(var0, var1, var2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var3 = -99999;
  var4 = self.origin[2] + 2000;
  var5 = level.averagealliesz;
  var6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var8 in self.dropcrates) {
      var6 = var8;
    }
  }

  var10 = 256;

  if(isDefined(var2)) {
    var11 = scripts\engine\trace::ray_trace((var0, var1, var4), (var0, var1, var3), var6, undefined, undefined, 1);
  } else {
    var11 = scripts\engine\trace::sphere_trace((var1, var2, var5), (var1, var2, var4), 256, var10, undefined, 1);
  }

  if(var11["position"][2] < var6) {
    var12 = var6;
  } else {
    var12 = var12["position"][2];
  }

  return var12;
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread littlebirdleave();
}

function changemaxpitchrollwhenclosetogoal(var0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function abortextractpickup() {
  thread littlebirdleave();
}