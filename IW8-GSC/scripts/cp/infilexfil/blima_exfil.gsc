/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\blima_exfil.gsc
*************************************************/

function player_exfil_think(var0, var1) {
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  thread scripts\cp\cp_infilexfil::infil_player_rig(var1, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(var0, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  var0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "exfil", "body_animate_jnt");
  thread rideloop(var0);
}

function spawnactors(var0, var1, var2) {
  initanims();

  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.actors[self.actors.size] = spawn_anim_model("pilot", "body_animate_jnt", "allied_pilot_fullbody_3");
}

function spawn_anim_model(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_model", (0, 0, 0));
  var6 setModel(var2);

  if(isDefined(var3)) {
    var7 = spawn("script_model", (0, 0, 0));
    var7 setModel(var3);
    var7 linkTo(var6, "j_spine4", (0, 0, 0), (0, 0, 0));
    var6.head = var7;
    var6 thread scripts\engine\utility::delete_on_death(var7);
  }

  if(isDefined(var5)) {
    var8 = spawn("script_model", (0, 0, 0));
    var8 setModel(var5);
    var8 linkTo(var6.head, "j_spine4", (0, 0, 0), (0, 0, 0));
    var6.hat = var8;
    var6 thread scripts\engine\utility::delete_on_death(var8);
  }

  var6.animname = var0;
  var6 scripts\common\anim::setanimtree();

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var6);
    var6 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var6;
}

function initanims(var0) {
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

function exfil_players(var0, var1, var2) {
  scripts\cp\vehicles\cp_heli_trip::initanims();
  level.heli_trip_vehicle = var0;

  if(isDefined(var2) && isbuiltinfunction(var2)) {
    level.heli_trip_vehicle thread[[var2]]();
  } else {
    level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers(0);
  }

  objective_setlabel(var1, &"COOP_GAME_PLAY/EXFIL");
  level.heli_trip_vehicle scripts\engine\utility::ref_143a5("all_players_on_board", "heli_trip_timed_out");
  level notify("ready_to_exfil");
  objective_delete(var1);
  thread leave_and_end_game();
}

function spawn_vehicle_actors(var0) {
  var0.animname = "exfil_chopper";
  spawnactors(var0);
  thread actorloopthink();
}

function leave_and_end_game() {
  wait 1;
  self cleargoalyaw();
  self vehicle_setspeed(15, 10);
  var0 = self.origin + (0, 0, 1200);
  self setvehgoalpos(var0, 1);
  wait 5;

  if(isDefined(self.onexitfunc)) {
    self vehicle_setspeed(self.onexitfunc, 20);
  } else {
    self vehicle_setspeed(60, 20);
  }

  if(isDefined(self.exfil_struct) && isDefined(self.exfil_struct.target)) {
    var1 = scripts\engine\utility::getStructArray(self.exfil_struct.target, "targetname");
    var2 = var1[0];
    var3 = (var2.origin[0], var2.origin[1], self.origin[2]);
    var4 = vectorNormalize(var3 - self.origin);
    var4 *= 20000;
    self setvehgoalpos(var0 + var4);
  } else {
    self setvehgoalpos(var0 + (0, -20000, 0));
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
  var0 = 0;
  var1 = 0;
  var2 = [];
  var3 = [];

  foreach(var5 in level.players) {
    if(var5.team == "axis") {
      var2 = var5;
      continue;
    }

    var3 = var5;
  }

  foreach(var5 in var3) {
    if(scripts\cp\cp_laststand::player_in_laststand(var5) || var5 isspectatingplayer()) {
      var1++;
    }

    if(istrue(var5.inchopper)) {
      var0++;
    }
  }

  return var0 > 0 && var3.size == var0 + var1;
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

function actorloop(var0, var1) {
  self endon("unload");
  self endon("death");
  var0 endon("death");
  scripts\common\anim::anim_single_solo(var0, "exfil", var1);
}

function init_interactions() {
  var0 = anglesToForward(self.angles);
  var1 = anglestoright(self.angles);
  var2 = anglestoleft(self.angles);
  var3 = self.origin + (0, 0, -110);
  var4 = var3 + var0 * 20 + var2 * 45;
  var5 = var3 + var0 * 20 + var1 * 45;
  var6 = var3 + var0 * -20 + var2 * 45;
  var7 = var3 + var0 * -20 + var1 * 45;
  create_vehicle_interaction(var4, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self);
  create_vehicle_interaction(var5, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self);
  create_vehicle_interaction(var6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self);
  create_vehicle_interaction(var7, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self);
}

function create_vehicle_interaction(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0);
  var4 setModel("tag_origin");
  var4 setHintString(var1);
  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(200);
  var4 sethintdisplayfov(90);
  var4 setuserange(72);
  var4 setusefov(90);
  var4 sethintonobstruction("hide");
  var4 setuseholdduration("duration_short");
  thread use_think(var4, var3);
}

function use_think(var0, var1) {
  self makeusable();

  for(;;) {
    self waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(level.nuclear_core)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        iprintln(" PICK THE CORE UP BEFORE LEAVING! ");
        continue;
      }
    }

    self makeunusable();
    var2 scripts\cp\infilexfil\infilexfil::infil_player_allow_cp(0);
    waitframe();
    var2 thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
    var2.inchopper = 1;
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
  foreach(var1 in level.players) {
    var1 notify("allow_exfil");
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
      var0 = 0;

      while(self meleeButtonPressed()) {
        var0++;
        wait 0.05;

        if(var0 >= 60) {
          break;
        }
      }

      if(var0 >= 60) {
        self iprintlnbold("EXFIL CALLED");
        level notify("call_exfil", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

function listen_for_exfil(var0, var1, var2) {
  self notify("listen_for_exfil");
  self endon("listen_for_exfil");
  jumpiftrue(isDefined(var0)) LOC_00000020;
  var0 = "exfil_location";
  level waittill("call_exfil", var3, var4);
  var5 = scripts\engine\utility::getStruct("player_exfil", "targetname");

  if(isDefined(level.ref_1248f)) {
    var5 = level.ref_1248f;
  }

  var5.vehicletype = "blima_cp";
  var6 = scripts\common\vehicle::vehicle_spawn(var5);
  thread is_dead();
  var6.godmode = 1;
  var6.health = 100000;
  var6.maxhealth = 100000;
  var6.team = "allies";
  var6.script_team = "allies";
  var6 setvehicleteam("allies");
  var6 setCanDamage(0);

  if(istrue(var4)) {
    level.exfil_heli = var6;
  }

  var7 = scripts\engine\utility::getclosest(var3, scripts\engine\utility::getStructArray(var0, "targetname"));

  if(isDefined(level.ref_14049)) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(var7.origin, 16), (0, 90, 0), 0.01);
  } else {
    var7.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var7.origin, 1);
  }

  var6.exfil_struct = var7;
  var8 = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(var8, "current");
  objective_position(var8, var7.origin - (0, 0, 100));
  objective_icon(var8, "icon_waypoint_objective_general");
  objective_setminimapiconsize(var8, "icon_regular");
  objective_setshowdistance(var8, 1);
  objective_setplayintro(var8, 1);
  var6.headicon = deleteheadicon(var6);
  setheadiconfriendlyimage(var6.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var6.headicon, 12000);
  setheadiconmaxdistance(var6.headicon, 1500);
  addclienttoheadiconmask(var6.headicon, 10);
  setheadicondrawthroughgeo(var6.headicon, 1);
  var6.objnum = var8;
  spawn_vehicle_actors(var6);
  thread rumble_nearby_players();
  thread wait_while_exfil_arrives(var6);
  var6 waittill("wait_done");

  if(isDefined(var1)) {
    go_to_exfil_location(var6, var7, var1);
  } else {
    go_to_exfil_location(var6, var7, 1);
  }

  exfil_players(var6, var6, var8, var2);
}

#using_animtree("");

function go_to_exfil_location(var0, var1, var2) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  self.going_to_exfil = 1;

  if(!isDefined(var2) || !istrue(var2)) {
    self vehicleplayanim(%est_blima_doors_open);
  }

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(var0.origin + (0, 0, 1200), 1);
  self waittill("goal");
  self vehicle_setspeed(15, 10);
  arrive_at_exfil_location(self);
}

function wait_while_exfil_arrives(var0) {
  objective_setlabel(var0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  level thread scripts\cp\utility::objective_update("exfil_enroute");
  objective_setshowprogress(var0, 1);
  objective_setprogress(var0, 0);
  objective_setbackground(var0, 1);
  var1 = 10;
  var2 = 10;

  for(;;) {
    wait 1;
    var2--;
    objective_setprogress(var0, var2 / var1);

    if(var2 <= 15) {
      self notify("wait_done");
    }

    if(var2 <= 0) {
      return;
    }
  }
}

function heli_cleanup_exfil_area(var0) {
  var0 endon("death");
  level notify("starting_cleanup");
  var0.minigun setturretteam("allies");
  var0.minigun setmode("manual");
  var1 = gettime();
  var2 = 0;

  for(;;) {
    var3 = get_nearby_enemy(var0, var0.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(var3)) {
      var0.minigun cleartargetentity();
      wait 1;
      var2++;

      if(var2 >= 3) {
        return;
      }

      continue;
    }

    var2 = 0;
    var4 = var3.origin + (0, 0, 1100);
    var0.minigun settargetentity(var3);

    if(distance(var4, var0.origin) > 500) {
      var0 setvehgoalpos(var4, 1);
    }

    var5 = var0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3);

    if(var5 == "timeout") {
      var0.minigun cleartargetentity();
      continue;
    }

    if(gettime() > var1) {
      for(var6 = 0; var6 < 35; var6++) {
        var0.minigun shootturret();
        wait 0.1;
      }

      var1 = gettime() + 1000;
    }
  }
}

function arrive_at_exfil_location(var0) {
  var0 setvehgoalpos(var0.exfil_struct.origin + (0, 0, 1200), 1);
  var0 waittill("goal");
  var0 settargetyaw(var0.exfil_struct.angles[1]);
  var0 setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location", var0.origin);
  level.oldkey = var0;
  thread keep_from_crushing_players();
  thread lb_mg_dmg_factor_fuselage();
  var0.goalradius = 4;
  var0 setvehgoalpos(var0.exfil_struct.origin, 1);
  var0 waittill("goal");
  var0 vehicle_setspeedimmediate(0);
  var0 vehicle_cleardrivingstate();
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

  foreach(var1 in level.vehicle.instances) {
    foreach(var3 in var1) {
      if(!isDefined(var3) || !isDefined(var3.origin)) {
        continue;
      }

      if(var3 == self) {
        continue;
      }

      if(distance2d(var3.origin, self.origin) < 512) {
        var3 dodamage(var3.health + 1000, self.origin);
      }
    }
  }
}

function keep_from_crushing_players() {
  self endon("goal");

  for(;;) {
    foreach(var1 in level.players) {
      if(var1 istouching(self)) {
        thread move_player_from_under_heli(var1);
      }

      thread vfx_htown_stab_blink_ak(var1);
      thread vfx_special_height(var1);
    }

    if(isDefined(level.spawnjuggernautcrateatposition)) {
      foreach(var4 in level.spawnjuggernautcrateatposition) {
        if(isDefined(var4) && !istrue(var4.carried) && distance2d(self.origin, var4.origin) <= 200) {
          thread ref_11d86(var4);
        }
      }
    }

    waitframe();
  }
}

function vfx_special_height(var0) {
  if(isDefined(var0.taccovers) && isarray(var0.taccovers) && var0.taccovers.size > 0) {
    foreach(var2 in var0.taccovers) {
      if(isDefined(var2) && isDefined(var2.collision)) {
        if(var2 istouching(self) || var2.collision istouching(self)) {
          var2 scripts\cp\powers\cp_tactical_cover::tac_cover_delete(0.05);
        }
      }
    }

    return;
  }
}

function vfx_htown_stab_blink_ak(var0) {
  if(isDefined(var0.placedsentries)) {
    if(isDefined(var0.placedsentries["sentry_turret"]) && isarray(var0.placedsentries["sentry_turret"]) && var0.placedsentries["sentry_turret"].size > 0) {
      foreach(var2 in var0.placedsentries["sentry_turret"]) {
        if(isDefined(var2)) {
          if(var2 istouching(self)) {
            var2 notify("kill_turret", 1, 0);
          }
        }
      }
    }

    if(isDefined(var0.placedsentries["manual_turret"]) && isarray(var0.placedsentries["manual_turret"]) && var0.placedsentries["manual_turret"].size > 0) {
      foreach(var2 in var0.placedsentries["manual_turret"]) {
        if(isDefined(var2)) {
          if(var2 istouching(self)) {
            var2 notify("kill_turret", 1, 0);
          }
        }
      }

      return;
    }

    return;
  }
}

function move_player_from_under_heli(var0) {
  var1 = var0.origin - self.origin;
  var1 = vectorNormalize(var1);
  var1 *= 200;
  var1 = (var1[0], var1[1], 0);
  var0 setOrigin(var0.origin + var1, 1);
}

function ref_11d86(var0) {
  var1 = var0.origin - self.origin;
  var1 = vectorNormalize(var1);
  var1 *= 200;
  var1 = (var1[0], var1[1], 0);
  var0.origin += var1;
  var0 notify("displaced");
}

function get_nearby_enemy(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 2250000;
  }

  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var2 = sortbydistance(var2, self.origin);

  foreach(var4 in var2) {
    if(!isalive(var4)) {
      continue;
    }

    if(distancesquared(var4.origin, var0) < var1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var4.origin + (0, 0, 100), var2)) {
      return var4;
    }
  }

  return undefined;
}

function heli_mg_create(var0, var1) {
  var2 = "tag_flash";
  var3 = (-64, 0, 0);
  var4 = self gettagorigin(var2);

  if(!isDefined(var1)) {
    var1 = "sentry_minigun_mp";
  }

  self.minigun = spawnturret("misc_turret", var4, var1);
  self.minigun.angles = self gettagangles(var2);

  if(isDefined(var0)) {
    self.minigun setModel(var0);
  } else {
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self.minigun linkTo(self, var2, var3, (0, 0, 0));
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

function rideloop(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("disconnect");

  for(;;) {
    scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "exfil_idle", "body_animate_jnt");
  }
}

function is_dead() {
  self endon("death");
  var0 = spawn("trigger_radius", self.origin, 0, 350, 64);
  var0 enablelinkTo();
  var0 linkTo(self, "tag_origin");
  var1 = spawn("trigger_radius", self gettagorigin("tail_rotor_jnt"), 0, 64, 64);
  var1 enablelinkTo();
  var1 linkTo(self, "tail_rotor_jnt");
  thread complete_trap_room(var0);
  thread complete_trap_room(var1);
}

function complete_trap_room(var0) {
  var0 endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(istrue(var1.inlaststand)) {
      var1 notify("force_bleed_out");
      continue;
    }

    if(istrue(var1.isjuggernaut)) {
      var1 scripts\cp\cp_juggernaut::jugg_removejuggernaut();
    }

    var1 setvelocity((-500, 0, 500));
    var1.shouldskiplaststand = 1;
    var1 dodamage(var1.health + 1000, self.origin);
  }
}