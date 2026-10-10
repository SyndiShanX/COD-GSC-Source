/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\infilexfil\blima_exfil.gsc
****************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\cp_objective_mechanics;
#using scripts\cp\cp_objectives;
#using scripts\cp\infilexfil\infilexfil;
#using scripts\cp\interaction;
#using scripts\cp\laststand;
#using scripts\cp\powers\cp_tactical_cover;
#using scripts\cp\utility;
#using scripts\cp\vehicles\cp_heli_trip;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\infilexfil;
#namespace blima_exfil;

function player_exfil_think(var_214da032eefdfe74, seat) {
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  thread infil_player_rig(seat, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  self.player_rig linkTo(var_214da032eefdfe74, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  var_214da032eefdfe74 anim_player_solo(self, self.player_rig, "exfil", "body_animate_jnt");
  var_214da032eefdfe74 thread rideloop(self);
}

function spawnactors(team, scene_name, extra_crew) {
  initanims();

  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.actors[self.actors.size] = spawn_anim_model("pilot", "body_animate_jnt", "allied_pilot_fullbody_3");
}

function spawn_anim_model(animname, linkto_tag, body, head, weapon, hat) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    guy_head = spawn("script_model", (0, 0, 0));
    guy_head setModel(head);
    guy_head linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = guy_head;
    guy thread delete_on_death(guy_head);
  }

  if(isDefined(hat)) {
    guy_hat = spawn("script_model", (0, 0, 0));
    guy_hat setModel(hat);
    guy_hat linkTo(guy.head, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.hat = guy_hat;
    guy thread delete_on_death(guy_hat);
  }

  guy.animname = animname;
  guy setanimtree();

  if(isDefined(linkto_tag)) {
    thread delete_on_death(guy);
    guy linkTo(self, linkto_tag, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

function initanims(subtype) {
  script_model_anims();
  vehicle_anims();
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["exfil"] = % vh_blima_rappel_pilot;
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["exfil"] = % vh_blima_rappel_copilot;
  level.scr_animtree["seat1"] = #animtree;
  level.scr_anim["seat1"]["exfil"] = % cp_exfil_blima_plr01_wm;
  level.scr_eventanim["seat1"]["exfil"] = % "hash_1a45a000005b7977";
  level.scr_anim["seat1"]["exfil_idle"] = % cp_exfil_blima_plr01_idle_wm;
  level.scr_eventanim["seat1"]["exfil_idle"] = % "hash_45fdcebc7ada32aa";
  level.scr_animtree["seat2"] = #animtree;
  level.scr_anim["seat2"]["exfil"] = % cp_exfil_blima_plr02_wm;
  level.scr_eventanim["seat2"]["exfil"] = % "hash_1a45a100005b7b2a";
  level.scr_anim["seat2"]["exfil_idle"] = % cp_exfil_blima_plr02_idle_wm;
  level.scr_eventanim["seat2"]["exfil_idle"] = % "hash_44236875bd5b27d";
  level.scr_animtree["seat3"] = #animtree;
  level.scr_anim["seat3"]["exfil"] = % cp_exfil_blima_plr03_wm;
  level.scr_eventanim["seat3"]["exfil"] = % "hash_1a45a200005b7cdd";
  level.scr_anim["seat3"]["exfil_idle"] = % cp_exfil_blima_plr03_idle_wm;
  level.scr_eventanim["seat3"]["exfil_idle"] = % "hash_213c21a9b30a48d0";
  level.scr_animtree["seat4"] = #animtree;
  level.scr_anim["seat4"]["exfil"] = % cp_exfil_blima_plr04_wm;
  level.scr_eventanim["seat4"]["exfil"] = % "hash_13e4ff431b84ab3";
  level.scr_anim["seat4"]["exfil_idle"] = % cp_exfil_blima_plr04_idle_wm;
  level.scr_eventanim["seat4"]["exfil_idle"] = % "hash_13e4ff431b84ab3";
}

#using_animtree("mp_vehicles_always_loaded");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function exfil_players(var_214da032eefdfe74, objnum, custompassengerwaitfunc) {
  exfil(var_214da032eefdfe74, objnum, custompassengerwaitfunc);
  var_214da032eefdfe74 thread leave_and_end_game();
}

function function_9149f78899f36b7(var_214da032eefdfe74, objnum, custompassengerwaitfunc) {
  exfil(var_214da032eefdfe74, objnum, custompassengerwaitfunc);
  var_214da032eefdfe74 heli_leave(1, 1);

  if(isDefined(var_214da032eefdfe74.headicon)) {
    deleteheadicon(var_214da032eefdfe74.headicon);
  }

  var_214da032eefdfe74 notify("death");
  wait 0.1;

  if(isDefined(var_214da032eefdfe74)) {
    var_214da032eefdfe74 delete();
  }
}

function exfil(var_214da032eefdfe74, objnum, custompassengerwaitfunc) {
  scripts\cp\vehicles\cp_heli_trip::initanims();
  level.heli_trip_vehicle = var_214da032eefdfe74;

  if(isDefined(custompassengerwaitfunc) && isfunction(custompassengerwaitfunc)) {
    level.heli_trip_vehicle thread[[custompassengerwaitfunc]]();
  } else {
    level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers(0);
  }

  objective_setlabel(objnum, &"COOP_GAME_PLAY/EXFIL");
  var_214da032eefdfe74 notify("waiting_to_leave");
  level.heli_trip_vehicle waittill_any_2("all_players_on_board", "heli_trip_timed_out");
  level notify("ready_to_exfil");
  objective_delete(objnum);
}

function spawn_vehicle_actors(vehicle) {
  vehicle.animname = "exfil_chopper";
  vehicle spawnactors();
  vehicle thread actorloopthink();
}

function leave_and_end_game() {
  heli_leave();
  end_game();
}

function heli_leave(var_28fb9ce9b6706e97, var_4461656ab93d2faa) {
  wait 1;
  self cleargoalyaw();
  self vehicle_setspeed(15, 10);
  org = self.origin + (0, 0, 1200);
  self setvehgoalpos(org, 1);
  wait 5;

  if(isDefined(self.exfil_speed)) {
    self vehicle_setspeed(self.exfil_speed, 20);
  } else {
    self vehicle_setspeed(60, 20);
  }

  if(isDefined(self.exfil_struct) && isDefined(self.exfil_struct.target)) {
    [var_f1b25ad1d7caa88e] = getStructArray(self.exfil_struct.target, "targetname");
    var_f13e0951028d543f = (var_f1b25ad1d7caa88e.origin[0], var_f1b25ad1d7caa88e.origin[1], self.origin[2]);
    var_1dc53a6f1393b456 = vectorNormalize(var_f13e0951028d543f - self.origin);
    var_1dc53a6f1393b456 *= 20000;
    self setvehgoalpos(org + var_1dc53a6f1393b456);
  } else {
    self setvehgoalpos(org + (0, -20000, 0));
  }

  if(istrue(var_28fb9ce9b6706e97)) {
    self waittill("goal");
  }

  if(!istrue(var_4461656ab93d2faa)) {
    if(flag_exist("endgame_delay")) {
      flag_wait("endgame_delay");
    } else {
      wait 4;
    }

    wait 3;
  }

  self notify("end_of_path");
}

function end_game() {
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function all_alive_players_in_chopper() {
  var_44992e6b98f5ec99 = 0;
  playersinlaststand = 0;
  axis_players = [];
  allies_players = [];

  foreach(player in level.players) {
    if(player.team == "axis") {
      axis_players[axis_players.size] = player;
      continue;
    }

    allies_players[allies_players.size] = player;
  }

  foreach(player in allies_players) {
    if(scripts\cp\laststand::player_in_laststand(player) || player isspectatingplayer()) {
      playersinlaststand++;
    }

    if(istrue(player.inchopper)) {
      var_44992e6b98f5ec99++;
    }
  }

  return var_44992e6b98f5ec99 > 0 && allies_players.size == var_44992e6b98f5ec99 + playersinlaststand;
}

function wait_for_all_players_ready() {
  while(true) {
    if(all_alive_players_in_chopper()) {
      level notify("ready_to_exfil");
      return;
    }

    wait 0.1;
  }
}

function actorloopthink() {
  thread actorloop(self.actors[0], "tag_seat_0");
}

function actorloop(actor, tag) {
  self endon("unload");
  self endon("death");
  actor endon("death");
  anim_single_solo(actor, "exfil", tag);
}

function init_interactions() {
  fwd = anglesToForward(self.angles);
  rt = anglestoright(self.angles);
  lft = anglestoleft(self.angles);
  org = self.origin + (0, 0, -110);
  pos4 = org + fwd * 20 + lft * 45;
  pos2 = org + fwd * 20 + rt * 45;
  pos3 = org + fwd * -20 + lft * 45;
  pos1 = org + fwd * -20 + rt * 45;
  create_vehicle_interaction(pos4, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self);
  create_vehicle_interaction(pos2, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self);
  create_vehicle_interaction(pos3, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self);
  create_vehicle_interaction(pos1, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self);
}

function create_vehicle_interaction(loc, hintstring, name, vehicle) {
  interaction = spawn("script_model", loc);
  interaction setModel("tag_origin");
  interaction setHintString(hintstring);
  interaction setCursorHint("HINT_BUTTON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(72);
  interaction setusefov(90);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");
  interaction thread use_think(vehicle, name);
}

function use_think(vehicle, name) {
  self makeusable();

  while(true) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(level.nuclear_core)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        iprintln(" PICK THE CORE UP BEFORE LEAVING! ");
        continue;
      }
    }

    self makeunusable();
    player scripts\cp\infilexfil\infilexfil::infil_player_allow_cp(0);
    waitframe();
    player thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
    player.inchopper = 1;
  }
}

function allow_players_exfil() {
  foreach(player in level.players) {
    player notify("allow_exfil");
  }
}

function player_listen_for_exfil() {
  self endon("disconnect");
  self waittill("allow_exfil");

  while(true) {
    if(self useButtonPressed() && self getcurrentweapon().basename == "ks_remote_map_cp") {
      self iprintlnbold("EXFIL CALLED");
      level notify("call_exfil", self.origin);
      return;
    }

    if(self meleeButtonPressed()) {
      timepressed = 0;

      while(self meleeButtonPressed()) {
        timepressed++;
        wait 0.05;

        if(timepressed >= 60) {
          break;
        }
      }

      if(timepressed >= 60) {
        self iprintlnbold("EXFIL CALLED");
        level notify("call_exfil", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

function function_387b5e2e4b970437(var_f94346053e3f63e5, var_e1e1732f234cf593, var_cf805cd60ef50d4f, custompassengerwaitfunc) {
  if(!isDefined(var_f94346053e3f63e5)) {
    var_f94346053e3f63e5 = "exfil_location";
  }

  self notify("listen_for_exfil_" + var_f94346053e3f63e5);
  self endon("listen_for_exfil_" + var_f94346053e3f63e5);

  if(!isDefined(var_e1e1732f234cf593)) {
    var_e1e1732f234cf593 = "player_exfil";
  }

  level waittill("call_exfil_" + var_f94346053e3f63e5, pos, return_heli);
  var_2f5be15466f1811d = getStruct(var_e1e1732f234cf593, "targetname");

  if(isDefined(level.player_exfil_struct)) {
    var_2f5be15466f1811d = level.player_exfil_struct;
  }

  var_2f5be15466f1811d.vehicletype = "blima_cp";
  heli = function_aa22ac000bb68a77(var_2f5be15466f1811d);
  heli thread function_8e002faa7893c07c(pos, var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc);

  if(istrue(return_heli)) {
    level.exfil_heli = heli;
    return heli;
  }
}

function function_8e002faa7893c07c(pos, var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc) {
  heli = self;
  exfil_struct = getclosest(pos, getStructArray(var_f94346053e3f63e5, "targetname"));

  if(isDefined(level.use_airdrop_fx)) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(exfil_struct.origin, 16), (0, 90, 0), 0.01);
  } else {
    exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(exfil_struct.origin, 1);
  }

  heli.exfil_struct = exfil_struct;
  objnum = function_283c1ba04595d987(heli, exfil_struct);
  heli thread rumble_nearby_players();
  heli thread wait_while_exfil_arrives(objnum);
  heli waittill("wait_done");

  if(isDefined(var_cf805cd60ef50d4f)) {
    heli go_to_exfil_location(exfil_struct, var_cf805cd60ef50d4f);
  } else {
    heli go_to_exfil_location(exfil_struct, 1);
  }

  heli function_9149f78899f36b7(heli, objnum, custompassengerwaitfunc);
}

function function_aa22ac000bb68a77(var_2f5be15466f1811d) {
  heli = scripts\common\vehicle::vehicle_spawn(var_2f5be15466f1811d);
  heli thread damage_players_on_blades();
  heli.godmode = 1;
  heli.health = 100000;
  heli.maxhealth = 100000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);
  thread spawn_vehicle_actors(heli);
  return heli;
}

function function_283c1ba04595d987(heli, exfil_struct) {
  objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(objnum, "current");
  objective_position(objnum, exfil_struct.origin - (0, 0, 100));
  objective_icon(objnum, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objnum, "icon_regular");
  objective_setshowdistance(objnum, 1);
  objective_setplayintro(objnum, 1);
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  heli.objnum = objnum;
  return objnum;
}

function listen_for_exfil(var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc) {
  self notify("listen_for_exfil");
  self endon("listen_for_exfil");

  if(!isDefined(var_f94346053e3f63e5)) {
    var_f94346053e3f63e5 = "exfil_location";
  }

  level waittill("call_exfil", pos, return_heli);
  var_2f5be15466f1811d = getStruct("player_exfil", "targetname");

  if(isDefined(level.player_exfil_struct)) {
    var_2f5be15466f1811d = level.player_exfil_struct;
  }

  var_2f5be15466f1811d.vehicletype = "blima_cp";
  heli = scripts\common\vehicle::vehicle_spawn(var_2f5be15466f1811d);
  heli thread damage_players_on_blades();
  heli.godmode = 1;
  heli.health = 100000;
  heli.maxhealth = 100000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);

  if(istrue(return_heli)) {
    level.exfil_heli = heli;
  }

  exfil_struct = getclosest(pos, getStructArray(var_f94346053e3f63e5, "targetname"));

  if(isDefined(level.use_airdrop_fx)) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(exfil_struct.origin, 16), (0, 90, 0), 0.01);
  } else {
    exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(exfil_struct.origin, 1);
  }

  heli.exfil_struct = exfil_struct;
  objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(objnum, "current");
  objective_position(objnum, exfil_struct.origin - (0, 0, 100));
  objective_icon(objnum, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objnum, "icon_regular");
  objective_setshowdistance(objnum, 1);
  objective_setplayintro(objnum, 1);
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  heli.objnum = objnum;
  spawn_vehicle_actors(heli);
  heli thread rumble_nearby_players();
  heli thread wait_while_exfil_arrives(objnum);
  heli waittill("wait_done");

  if(isDefined(var_cf805cd60ef50d4f)) {
    heli go_to_exfil_location(exfil_struct, var_cf805cd60ef50d4f);
  } else {
    heli go_to_exfil_location(exfil_struct, 1);
  }

  heli exfil_players(heli, objnum, custompassengerwaitfunc);
}

function go_to_exfil_location(exfil_struct, do_cleanup, var_ea300f7c7016466d) {
  if(!isDefined(exfil_struct.angles)) {
    exfil_struct.angles = (0, 0, 0);
  }

  self.going_to_exfil = 1;

  if(!isDefined(var_ea300f7c7016466d) || !istrue(var_ea300f7c7016466d)) {
    self vehicleplayanim(%est_blima_doors_open);
  }

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(exfil_struct.origin + (0, 0, 1200), 1);
  self waittill("goal");
  self vehicle_setspeed(15, 10);
  arrive_at_exfil_location(self);
}

function wait_while_exfil_arrives(objectiveindex) {
  objective_setlabel(objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  level thread scripts\cp\utility::objective_update("exfil_enroute");
  objective_setshowprogress(objectiveindex, 1);
  objective_setprogress(objectiveindex, 0);
  objective_setbackground(objectiveindex, 1);
  time = 10;
  progress = 10;

  while(true) {
    wait 1;
    progress--;
    objective_setprogress(objectiveindex, progress / time);

    if(progress <= 15) {
      self notify("wait_done");
    }

    if(progress <= 0) {
      return;
    }
  }
}

function heli_cleanup_exfil_area(heli) {
  heli endon("death");
  level notify("starting_cleanup");
  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  invalid_targets = 0;

  while(true) {
    valid_target = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(valid_target)) {
      heli.minigun cleartargetentity();
      wait 1;
      invalid_targets++;

      if(invalid_targets >= 3) {
        return;
      }

      continue;
    }

    invalid_targets = 0;
    dest_vec = valid_target.origin + (0, 0, 1100);
    heli.minigun settargetentity(valid_target);

    if(distance(dest_vec, heli.origin) > 500) {
      heli setvehgoalpos(dest_vec, 1);
    }

    msg = heli.minigun waittill_notify_or_timeout_return("turret_on_target", 3);

    if(msg == "timeout") {
      heli.minigun cleartargetentity();
      continue;
    }

    if(gettime() > nextfiretime) {
      for(i = 0; i < 35; i++) {
        heli.minigun shootturret();
        wait 0.1;
      }

      nextfiretime = gettime() + 1000;
    }
  }
}

function arrive_at_exfil_location(heli) {
  heli setvehgoalpos(heli.exfil_struct.origin + (0, 0, 1200), 1);
  heli waittill("goal");
  heli settargetyaw(heli.exfil_struct.angles[1]);
  heli setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location", heli.origin);
  level.exfil_heli_landing = heli;
  heli thread keep_from_crushing_players();
  heli thread destroy_vehicles();
  heli.goalradius = 4;
  heli setvehgoalpos(heli.exfil_struct.origin, 1);
  heli waittill("goal");
  heli vehicle_setspeedimmediate(0);
  heli vehicle_cleardrivingstate();
  level notify("arrived_at_exfil_location");
  level.exfil_heli_landing = undefined;
}

function destroy_vehicles() {
  self endon("goal");
  wait 4;

  if(!isDefined(level.vehicle)) {
    return;
  }

  if(!isDefined(level.vehicle.instances)) {
    return;
  }

  foreach(vehicles_instance in level.vehicle.instances) {
    foreach(vehicle in vehicles_instance) {
      if(!isDefined(vehicle) || !isDefined(vehicle.origin)) {
        continue;
      }

      if(vehicle == self) {
        continue;
      }

      if(distance2d(vehicle.origin, self.origin) < 512) {
        vehicle dodamage(vehicle.health + 1000, self.origin);
      }
    }
  }
}

function keep_from_crushing_players() {
  self endon("goal");

  while(true) {
    foreach(player in level.players) {
      if(player istouching(self)) {
        thread move_player_from_under_heli(player);
      }

      thread kill_sentries(player);
      thread kill_tac_covers(player);
    }

    if(isDefined(level.hvtlist)) {
      foreach(hvt in level.hvtlist) {
        if(isDefined(hvt) && !istrue(hvt.carried) && distance2d(self.origin, hvt.origin) <= 200) {
          thread move_hvt_from_under_heli(hvt);
        }
      }
    }

    waitframe();
  }
}

function kill_tac_covers(player) {
  if(isDefined(player.taccovers) && isarray(player.taccovers) && player.taccovers.size > 0) {
    foreach(tac_cover in player.taccovers) {
      if(isDefined(tac_cover) && isDefined(tac_cover.collision)) {
        if(tac_cover istouching(self) || tac_cover.collision istouching(self)) {
          tac_cover scripts\cp\powers\cp_tactical_cover::tac_cover_delete(0.05);
        }
      }
    }
  }
}

function kill_sentries(player) {
  if(isDefined(player.placedsentries)) {
    if(isDefined(player.placedsentries["sentry_turret"]) && isarray(player.placedsentries["sentry_turret"]) && player.placedsentries["sentry_turret"].size > 0) {
      foreach(turret in player.placedsentries["sentry_turret"]) {
        if(isDefined(turret)) {
          if(turret istouching(self)) {
            turret notify("kill_turret", 1, 0);
          }
        }
      }
    }

    if(isDefined(player.placedsentries["manual_turret"]) && isarray(player.placedsentries["manual_turret"]) && player.placedsentries["manual_turret"].size > 0) {
      foreach(turret in player.placedsentries["manual_turret"]) {
        if(isDefined(turret)) {
          if(turret istouching(self)) {
            turret notify("kill_turret", 1, 0);
          }
        }
      }
    }
  }
}

function move_player_from_under_heli(player) {
  vec = player.origin - self.origin;
  vec = vectorNormalize(vec);
  vec *= 200;
  vec = (vec[0], vec[1], 0);
  player setOrigin(player.origin + vec, 1);
}

function move_hvt_from_under_heli(hvt) {
  vec = hvt.origin - self.origin;
  vec = vectorNormalize(vec);
  vec *= 200;
  vec = (vec[0], vec[1], 0);
  hvt.origin += vec;
  hvt notify("displaced");
}

function get_nearby_enemy(org, dist_check) {
  if(!isDefined(dist_check)) {
    dist_check = 2250000;
  }

  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  guys = sortbydistance(guys, self.origin);

  foreach(guy in guys) {
    if(!isalive(guy)) {
      continue;
    }

    if(distancesquared(guy.origin, org) < dist_check && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), guy.origin + (0, 0, 100), guys)) {
      return guy;
    }
  }

  return undefined;
}

function heli_mg_create(mg_model, turret_weapon) {
  tag = "tag_flash";
  originoffset = (-64, 0, 0);
  origin = self gettagorigin(tag);

  if(!isDefined(turret_weapon)) {
    turret_weapon = "sentry_minigun_mp";
  }

  self.minigun = spawnturret("misc_turret", origin, turret_weapon);
  self.minigun.angles = self gettagangles(tag);

  if(isDefined(mg_model)) {
    self.minigun setModel(mg_model);
  } else {
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self.minigun linkTo(self, tag, originoffset, (0, 0, 0));
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

  while(true) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.2;
  }
}

function rideloop(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  while(true) {
    anim_player_solo(player, player.player_rig, "exfil_idle", "body_animate_jnt");
  }
}

function damage_players_on_blades() {
  self endon("death");
  rotor_trigger = spawn("trigger_radius", self.origin, 0, 350, 64);
  rotor_trigger enablelinkTo();
  rotor_trigger linkTo(self, "tag_origin");
  tail_trigger = spawn("trigger_radius", self gettagorigin("tail_rotor_jnt"), 0, 64, 64);
  tail_trigger enablelinkTo();
  tail_trigger linkTo(self, "tail_rotor_jnt");
  rotor_trigger thread blade_trigger_think(self);
  tail_trigger thread blade_trigger_think(self);
}

function blade_trigger_think(heli) {
  heli endon("death");

  while(true) {
    self waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }

    if(istrue(ent.inlaststand)) {
      ent notify("force_bleed_out");
      continue;
    }

    if(istrue(ent.isjuggernaut)) {
      ent scripts\cp\cp_juggernaut::jugg_removejuggernaut();
    }

    ent setvelocity((-500, 0, 500));
    ent.shouldskiplaststand = 1;
    ent dodamage(ent.health + 1000, self.origin);
  }
}

function function_a195b29bf788fbc7() {
  scripts\cp\interaction::register_interaction("exfil_spot", "null", undefined, &function_1ef16b5bead75324, &function_f0e0473d6c709fdc, 0, 0, &function_b540a63f7d14e39f);
}

function function_53b91a8ca24ad84(active) {
  while(!isDefined(level.var_ec373b5131038e2d)) {
    wait 0.1;
  }

  if(istrue(active)) {
    objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
    objective_state(objnum, "current");
    objective_icon(objnum, "icon_waypoint_objective_general");
    objective_setminimapiconsize(objnum, "icon_regular");
    objective_setshowdistance(objnum, 1);
    objective_setplayintro(objnum, 1);
    objective_setlabel(objnum, &"CP_STRIKE/CALL_EXFIL");

    foreach(interaction_struct in level.var_ec373b5131038e2d) {
      objective_position(objnum, interaction_struct.origin);
      scripts\cp\interaction::add_to_current_interaction_list(interaction_struct);
    }

    return;
  }

  foreach(interaction_struct in level.var_ec373b5131038e2d) {
    scripts\cp\interaction::remove_from_current_interaction_list(interaction_struct);
  }
}

function function_b540a63f7d14e39f(var_6071184f8a3861b3) {
  level.var_ec373b5131038e2d = var_6071184f8a3861b3;

  foreach(interaction_struct in var_6071184f8a3861b3) {
    scripts\cp\interaction::add_to_current_interaction_list(interaction_struct);
  }
}

function function_1ef16b5bead75324(interaction_struct, player) {
  return &"CP_STRIKE/CALL_EXFIL";
}

function function_f0e0473d6c709fdc(interaction_struct, player) {
  player endon("disconnect");
  scripts\cp\cp_objectives::freeworldid("exfil_loc");
  level notify("call_exfil", player.origin, 1);
  scripts\cp\interaction::remove_from_current_interaction_list(interaction_struct);
  player scripts\cp\interaction::refresh_interaction();
}