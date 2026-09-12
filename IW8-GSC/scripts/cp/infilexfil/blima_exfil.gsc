/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\blima_exfil.gsc
*************************************************/

function player_exfil_think(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  thread scripts\cp\cp_infilexfil::infil_player_rig(var_1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(var_0, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  var_0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "exfil", "body_animate_jnt");
  thread rideloop(var_0);
}

function spawnactors(var_0, var_1, var_2) {
  initanims();

  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.actors[self.actors.size] = spawn_anim_model("pilot", "body_animate_jnt", "allied_pilot_fullbody_3");
}

function spawn_anim_model(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel(var_2);

  if(isDefined(var_3)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel(var_3);
    var_7 linkTo(var_6, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_6.head = var_7;
    var_6 thread scripts\engine\utility::delete_on_death(var_7);
  }

  if(isDefined(var_5)) {
    var_8 = spawn("script_model", (0, 0, 0));
    var_8 setModel(var_5);
    var_8 linkTo(var_6.head, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_6.hat = var_8;
    var_6 thread scripts\engine\utility::delete_on_death(var_8);
  }

  var_6.animname = var_0;
  var_6 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_6);
    var_6 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_6;
}

function initanims(var_0) {
  script_model_anims();
  vehicle_anims();
}

#using_animtree("");

function script_model_anims() {
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["exfil"] = $vh_blima_rappel_pilot;
  level.scr_animname["pilot"]["exfil"] = "vh_blima_rappel_pilot";
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["exfil"] = % vh_blima_rappel_copilot;
  level.scr_animname["copilot"]["exfil"] = "vh_blima_rappel_copilot";
  level.scr_animtree["seat1"] = #animtree;
  level.scr_anim["seat1"]["exfil"] = % cp_exfil_blima_plr01_wm;
  level.scr_animname["seat1"]["exfil"] = "cp_exfil_blima_plr01_wm";
  level.scr_eventanim["seat1"]["exfil"] = "exfil_blima_exit_1";
  level.scr_anim["seat1"]["exfil_idle"] = % cp_exfil_blima_plr01_idle_wm;
  level.scr_animname["seat1"]["exfil_idle"] = "cp_exfil_blima_plr01_idle_wm";
  level.scr_eventanim["seat1"]["exfil_idle"] = "exfil_blima_exit_1_idle";
  level.scr_animtree["seat2"] = #animtree;
  level.scr_anim["seat2"]["exfil"] = % cp_exfil_blima_plr02_wm;
  level.scr_animname["seat2"]["exfil"] = "cp_exfil_blima_plr02_wm";
  level.scr_eventanim["seat2"]["exfil"] = "exfil_blima_exit_2";
  level.scr_anim["seat2"]["exfil_idle"] = % cp_exfil_blima_plr02_idle_wm;
  level.scr_animname["seat2"]["exfil_idle"] = "cp_exfil_blima_plr02_idle_wm";
  level.scr_eventanim["seat2"]["exfil_idle"] = "exfil_blima_exit_2_idle";
  level.scr_animtree["seat3"] = #animtree;
  level.scr_anim["seat3"]["exfil"] = % cp_exfil_blima_plr03_wm;
  level.scr_animname["seat3"]["exfil"] = "cp_exfil_blima_plr03_wm";
  level.scr_eventanim["seat3"]["exfil"] = "exfil_blima_exit_3";
  level.scr_anim["seat3"]["exfil_idle"] = % cp_exfil_blima_plr03_idle_wm;
  level.scr_animname["seat3"]["exfil_idle"] = "cp_exfil_blima_plr03_idle_wm";
  level.scr_eventanim["seat3"]["exfil_idle"] = "exfil_blima_exit_3_idle";
  level.scr_animtree["seat4"] = #animtree;
  level.scr_anim["seat4"]["exfil"] = % cp_exfil_blima_plr04_wm;
  level.scr_animname["seat4"]["exfil"] = "cp_exfil_blima_plr04_wm";
  level.scr_eventanim["seat4"]["exfil"] = "exfil_blima_exit_4_idle";
  level.scr_anim["seat4"]["exfil_idle"] = % cp_exfil_blima_plr04_idle_wm;
  level.scr_animname["seat4"]["exfil_idle"] = "cp_exfil_blima_plr04_idle_wm";
  level.scr_eventanim["seat4"]["exfil_idle"] = "exfil_blima_exit_4_idle";
}

#using_animtree("mp_vehicles_always_loaded");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function exfil_players(var_0, var_1, var_2) {
  scripts\cp\vehicles\cp_heli_trip::initanims();
  level.heli_trip_vehicle = var_0;

  if(isDefined(var_2) && isbuiltinfunction(var_2)) {
    level.heli_trip_vehicle thread[[var_2]]();
  } else {
    level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers(0);
  }

  objective_setlabel(var_1, &"COOP_GAME_PLAY/EXFIL");
  level.heli_trip_vehicle scripts\engine\utility::ref_143A5("all_players_on_board", "heli_trip_timed_out");
  level notify("ready_to_exfil");
  objective_delete(var_1);
  thread leave_and_end_game();
}

function spawn_vehicle_actors(var_0) {
  var_0.animname = "exfil_chopper";
  spawnactors(var_0);
  thread actorloopthink();
}

function leave_and_end_game() {
  wait 1;
  self cleargoalyaw();
  self vehicle_setspeed(15, 10);
  var_0 = self.origin + (0, 0, 1200);
  self setvehgoalpos(var_0, 1);
  wait 5;

  if(isDefined(self.onexitfunc)) {
    self vehicle_setspeed(self.onexitfunc, 20);
  } else {
    self vehicle_setspeed(60, 20);
  }

  if(isDefined(self.exfil_struct) && isDefined(self.exfil_struct.target)) {
    var_1 = scripts\engine\utility::getStructArray(self.exfil_struct.target, "targetname");
    var_2 = var_1[0];
    var_3 = (var_2.origin[0], var_2.origin[1], self.origin[2]);
    var_4 = vectorNormalize(var_3 - self.origin);
    var_4 *= 20000;
    self setvehgoalpos(var_0 + var_4);
  } else {
    self setvehgoalpos(var_0 + (0, -20000, 0));
  }

  if(scripts\engine\utility::flag_exist("endgame_delay")) {
    scripts\engine\utility::flag_wait("endgame_delay");
  } else {
    wait 4;
  }

  wait 3;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function all_alive_players_in_chopper() {
  var_0 = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.team == "axis") {
      var_2 = var_5;
      continue;
    }

    var_3 = var_5;
  }

  foreach(var_5 in var_3) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_5) || var_5 isspectatingplayer()) {
      var_1++;
    }

    if(istrue(var_5.inchopper)) {
      var_0++;
    }
  }

  return var_0 > 0 && var_3.size == var_0 + var_1;
}

function wait_for_all_players_ready() {
  for(;;) {
    if(all_alive_players_in_chopper()) {
      level notify("ready_to_exfil");
      return;
    }

    wait 0.1;
  }
}

function actorloopthink() {
  thread actorloop(self.actors[0], "tag_pilot1");
}

function actorloop(var_0, var_1) {
  self endon("unload");
  self endon("death");
  var_0 endon("death");
  scripts\common\anim::anim_single_solo(var_0, "exfil", var_1);
}

function init_interactions() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = var_3 + var_0 * -20 + var_2 * 45;
  var_7 = var_3 + var_0 * -20 + var_1 * 45;
  create_vehicle_interaction(var_4, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self);
  create_vehicle_interaction(var_5, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self);
  create_vehicle_interaction(var_6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self);
  create_vehicle_interaction(var_7, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self);
}

function create_vehicle_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 setHintString(var_1);
  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("hide");
  var_4 setuseholdduration("duration_short");
  thread use_think(var_4, var_3);
}

function use_think(var_0, var_1) {
  self makeusable();

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(level.nuclear_core)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        iprintln(" PICK THE CORE UP BEFORE LEAVING! ");
        continue;
      }
    }

    self makeunusable();
    var_2 scripts\cp\infilexfil\infilexfil::infil_player_allow_cp(0);
    waitframe();
    var_2 thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
    var_2.inchopper = 1;
  }
}

function do_fadeout() {
  self.endgame_overlay = newclienthudelem(self);
  self.endgame_overlay.x = 0;
  self.endgame_overlay.y = 0;
  self.endgame_overlay setshader("black", 640, 480);
  self.endgame_overlay.alignx = "left";
  self.endgame_overlay.aligny = "top";
  self.endgame_overlay.sort = 1;
  self.endgame_overlay.horzalign = "fullscreen";
  self.endgame_overlay.vertalign = "fullscreen";
  self.endgame_overlay.alpha = 0;
  self.endgame_overlay.foreground = 1;
  self.endgame_overlay fadeovertime(3);
  self.endgame_overlay.alpha = 1;
}

function allow_players_exfil() {
  foreach(var_1 in level.players) {
    var_1 notify("allow_exfil");
  }
}

function player_listen_for_exfil() {
  self endon("disconnect");
  self waittill("allow_exfil");

  for(;;) {
    if(self useButtonPressed() && self getcurrentweapon().basename == "ks_remote_map_cp") {
      self iprintlnbold("EXFIL CALLED");
      level notify("call_exfil", self.origin);
      return;
    }

    if(self meleeButtonPressed()) {
      var_0 = 0;

      while(self meleeButtonPressed()) {
        var_0++;
        wait 0.05;

        if(var_0 >= 60) {
          break;
        }
      }

      if(var_0 >= 60) {
        self iprintlnbold("EXFIL CALLED");
        level notify("call_exfil", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

function listen_for_exfil(var_0, var_1, var_2) {
  self notify("listen_for_exfil");
  self endon("listen_for_exfil");
  jumpiftrue(isDefined(var_0)) LOC_00000020;
  var_0 = "exfil_location";
  level waittill("call_exfil", var_3, var_4);
  var_5 = scripts\engine\utility::getStruct("player_exfil", "targetname");

  if(isDefined(level.ref_1248F)) {
    var_5 = level.ref_1248F;
  }

  var_5.vehicletype = "blima_cp";
  var_6 = scripts\common\vehicle::vehicle_spawn(var_5);
  thread is_dead();
  var_6.godmode = 1;
  var_6.health = 100000;
  var_6.maxhealth = 100000;
  var_6.team = "allies";
  var_6.script_team = "allies";
  var_6 setvehicleteam("allies");
  var_6 setCanDamage(0);

  if(istrue(var_4)) {
    level.exfil_heli = var_6;
  }

  var_7 = scripts\engine\utility::getclosest(var_3, scripts\engine\utility::getStructArray(var_0, "targetname"));

  if(isDefined(level.ref_14049)) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(var_7.origin, 16), (0, 90, 0), 0.01);
  } else {
    var_7.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_7.origin, 1);
  }

  var_6.exfil_struct = var_7;
  var_8 = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(var_8, "current");
  objective_position(var_8, var_7.origin - (0, 0, 100));
  objective_icon(var_8, "icon_waypoint_objective_general");
  objective_setminimapiconsize(var_8, "icon_regular");
  objective_setshowdistance(var_8, 1);
  objective_setplayintro(var_8, 1);
  var_6.headicon = deleteheadicon(var_6);
  setheadiconfriendlyimage(var_6.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var_6.headicon, 12000);
  setheadiconmaxdistance(var_6.headicon, 1500);
  addclienttoheadiconmask(var_6.headicon, 10);
  setheadicondrawthroughgeo(var_6.headicon, 1);
  var_6.objnum = var_8;
  spawn_vehicle_actors(var_6);
  thread rumble_nearby_players();
  thread wait_while_exfil_arrives(var_6);
  var_6 waittill("wait_done");

  if(isDefined(var_1)) {
    go_to_exfil_location(var_6, var_7, var_1);
  } else {
    go_to_exfil_location(var_6, var_7, 1);
  }

  exfil_players(var_6, var_6, var_8, var_2);
}

#using_animtree("");

function go_to_exfil_location(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  self.going_to_exfil = 1;

  if(!isDefined(var_2) || !istrue(var_2)) {
    self vehicleplayanim(%est_blima_doors_open);
  }

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  self waittill("goal");
  self vehicle_setspeed(15, 10);
  arrive_at_exfil_location(self);
}

function wait_while_exfil_arrives(var_0) {
  objective_setlabel(var_0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  level thread scripts\cp\utility::objective_update("exfil_enroute");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  var_1 = 10;
  var_2 = 10;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0, var_2 / var_1);

    if(var_2 <= 15) {
      self notify("wait_done");
    }

    if(var_2 <= 0) {
      return;
    }
  }
}

function heli_cleanup_exfil_area(var_0) {
  var_0 endon("death");
  level notify("starting_cleanup");
  var_0.minigun setturretteam("allies");
  var_0.minigun setmode("manual");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = get_nearby_enemy(var_0, var_0.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(var_3)) {
      var_0.minigun cleartargetentity();
      wait 1;
      var_2++;

      if(var_2 >= 3) {
        return;
      }

      continue;
    }

    var_2 = 0;
    var_4 = var_3.origin + (0, 0, 1100);
    var_0.minigun settargetentity(var_3);

    if(distance(var_4, var_0.origin) > 500) {
      var_0 setvehgoalpos(var_4, 1);
    }

    var_5 = var_0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3);

    if(var_5 == "timeout") {
      var_0.minigun cleartargetentity();
      continue;
    }

    if(gettime() > var_1) {
      for(var_6 = 0; var_6 < 35; var_6++) {
        var_0.minigun shootturret();
        wait 0.1;
      }

      var_1 = gettime() + 1000;
    }
  }
}

function arrive_at_exfil_location(var_0) {
  var_0 setvehgoalpos(var_0.exfil_struct.origin + (0, 0, 1200), 1);
  var_0 waittill("goal");
  var_0 settargetyaw(var_0.exfil_struct.angles[1]);
  var_0 setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location", var_0.origin);
  level.oldkey = var_0;
  thread keep_from_crushing_players();
  thread lb_mg_dmg_factor_fuselage();
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_0.exfil_struct.origin, 1);
  var_0 waittill("goal");
  var_0 vehicle_setspeedimmediate(0);
  var_0 vehicle_cleardrivingstate();
  level notify("arrived_at_exfil_location");
  level.oldkey = undefined;
}

function lb_mg_dmg_factor_fuselage() {
  self endon("goal");
  wait 4;

  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.instances)) {
    return;
  }

  foreach(var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isDefined(var_3.origin)) {
        continue;
      }

      if(var_3 == self) {
        continue;
      }

      if(distance2d(var_3.origin, self.origin) < 512) {
        var_3 dodamage(var_3.health + 1000, self.origin);
      }
    }
  }
}

function keep_from_crushing_players() {
  self endon("goal");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self)) {
        thread move_player_from_under_heli(var_1);
      }

      thread vfx_htown_stab_blink_ak(var_1);
      thread vfx_special_height(var_1);
    }

    if(isDefined(level.spawnjuggernautcrateatposition)) {
      foreach(var_4 in level.spawnjuggernautcrateatposition) {
        if(isDefined(var_4) && !istrue(var_4.carried) && distance2d(self.origin, var_4.origin) <= 200) {
          thread ref_11D86(var_4);
        }
      }
    }

    waitframe();
  }
}

function vfx_special_height(var_0) {
  if(isDefined(var_0.taccovers) && isarray(var_0.taccovers) && var_0.taccovers.size > 0) {
    foreach(var_2 in var_0.taccovers) {
      if(isDefined(var_2) && isDefined(var_2.collision)) {
        if(var_2 istouching(self) || var_2.collision istouching(self)) {
          var_2 scripts\cp\powers\cp_tactical_cover::tac_cover_delete(0.05);
        }
      }
    }

    return;
  }
}

function vfx_htown_stab_blink_ak(var_0) {
  if(isDefined(var_0.placedsentries)) {
    if(isDefined(var_0.placedsentries["sentry_turret"]) && isarray(var_0.placedsentries["sentry_turret"]) && var_0.placedsentries["sentry_turret"].size > 0) {
      foreach(var_2 in var_0.placedsentries["sentry_turret"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self)) {
            var_2 notify("kill_turret", 1, 0);
          }
        }
      }
    }

    if(isDefined(var_0.placedsentries["manual_turret"]) && isarray(var_0.placedsentries["manual_turret"]) && var_0.placedsentries["manual_turret"].size > 0) {
      foreach(var_2 in var_0.placedsentries["manual_turret"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self)) {
            var_2 notify("kill_turret", 1, 0);
          }
        }
      }

      return;
    }

    return;
  }
}

function move_player_from_under_heli(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 *= 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0 setOrigin(var_0.origin + var_1, 1);
}

function ref_11D86(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 *= 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0.origin += var_1;
  var_0 notify("displaced");
}

function get_nearby_enemy(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2250000;
  }

  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = sortbydistance(var_2, self.origin);

  foreach(var_4 in var_2) {
    if(!isalive(var_4)) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0) < var_1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var_4.origin + (0, 0, 100), var_2)) {
      return var_4;
    }
  }

  return undefined;
}

function heli_mg_create(var_0, var_1) {
  var_2 = "tag_flash";
  var_3 = (-64, 0, 0);
  var_4 = self gettagorigin(var_2);

  if(!isDefined(var_1)) {
    var_1 = "sentry_minigun_mp";
  }

  self.minigun = spawnturret("misc_turret", var_4, var_1);
  self.minigun.angles = self gettagangles(var_2);

  if(isDefined(var_0)) {
    self.minigun setModel(var_0);
  } else {
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self.minigun linkTo(self, var_2, var_3, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun setmode("auto_nonai");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun setconvergencetime(0.05, "yaw");
  self.minigun setconvergencetime(0.05, "pitch");
}

function rumble_nearby_players() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.2;
  }
}

function rideloop(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "exfil_idle", "body_animate_jnt");
  }
}

function is_dead() {
  self endon("death");
  var_0 = spawn("trigger_radius", self.origin, 0, 350, 64);
  var_0 enablelinkTo();
  var_0 linkTo(self, "tag_origin");
  var_1 = spawn("trigger_radius", self gettagorigin("tail_rotor_jnt"), 0, 64, 64);
  var_1 enablelinkTo();
  var_1 linkTo(self, "tail_rotor_jnt");
  thread complete_trap_room(var_0);
  thread complete_trap_room(var_1);
}

function complete_trap_room(var_0) {
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(istrue(var_1.inlaststand)) {
      var_1 notify("force_bleed_out");
      continue;
    }

    if(istrue(var_1.isjuggernaut)) {
      var_1 scripts\cp\cp_juggernaut::jugg_removejuggernaut();
    }

    var_1 setvelocity((-500, 0, 500));
    var_1.shouldskiplaststand = 1;
    var_1 dodamage(var_1.health + 1000, self.origin);
  }
}