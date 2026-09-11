/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cp_heli_trip.gsc
************************************************/

function start_heli_trip_sequence(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  initanims();
  level.heli_trip_vehicle = spawn_chopper(var_0, var_1);
  level.heli_trip_vehicle scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(level.heli_trip_vehicle.exfil_struct, 1);
  thread wait_for_passengers(level.heli_trip_vehicle);
  level.heli_trip_vehicle scripts\engine\utility::ref_143a5("all_players_on_board", "heli_trip_timed_out");

  if(isDefined(level.heli_trip_vehicle)) {
    destroynavobstacle(level.heli_trip_vehicle.navobstacle);
  }

  level notify("heli_trip_took_off");
  level.heli_trip_vehicle notify("heli_taking_off");
  level.heli_trip_vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(var_2);
  level.heli_trip_vehicle notify("unload");
  level notify("heli_trip_over");
  wait 2;
  thread exit_map();
  level.helitrip_next_rig_num = undefined;
}

#using_animtree("script_model");

function playerpassengerthink(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  var_1 = "tag_seat_2";

  switch (var_0) {
    case "seat1":
      var_1 = "tag_seat_2";
      break;
    case "seat2":
      var_1 = "tag_seat_3";
      break;
    case "seat3":
      var_1 = "tag_seat_4";
      break;
    case "seat4":
      var_1 = "tag_seat_5";
      break;
  }

  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  self.try_to_punish_with_jugg = 1;
  raid_seq4_objectives_func();

  if(scripts\cp\utility::riotshield_hasweapon()) {
    self.clearsixthsense = 1;
  }

  scripts\cp\cp_weapons::ref_13a3a(self);
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  thread create_player_rig(self, "player");
  scripts\common\anim::anim_first_frame_solo(self.player_rig, "blima_getin");
  link_player_to_rig(self, 0.4);
  self.player_rig.weapon_state_func = &scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  level.heli_trip_vehicle thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_getin", var_1);
  wait getanimlength(%sdr_cp_veh_lbravo_seat_2_getin);
  self.player_rig linkTo(level.heli_trip_vehicle, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  self.inchopper = 1;
  level notify("exfil_sequence_started");
  level.heli_trip_vehicle notify("player_boarded_heli");
  thread ref_144c2();
  thread rideloop(var_1);
  level.heli_trip_vehicle waittill("unload");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self stopanimscriptsceneevent();
  self notify("remove_rig");
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  self.try_to_punish_with_jugg = 0;
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  scripts\cp\cp_infilexfil::takegunlesscp();

  if(istrue(self.clearsixthsense)) {
    var_2 = getcompleteweaponname("iw8_me_riotshield_mp");
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
    scripts\cp\cp_weapon::riotshieldonweaponchange();
    self.clearsixthsense = undefined;
  }

  self.inchopper = undefined;
}

function raid_seq4_objectives_func() {
  if(scripts\cp\cp_weapon::ref_124ad(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    var_0 = undefined;
    var_1 = self getweaponslistprimaries();

    foreach(var_3 in var_1) {
      if(nullweapon(var_3)) {
        continue;
      }

      if(scripts\cp\utility::isriotshield(var_3)) {
        continue;
      }

      if(!isDefined(var_0)) {
        var_4 = var_3 getnoaltweapon();

        if(var_4.inventorytype != "primary") {
          continue;
        }

        var_0 = var_3;
      }
    }

    if(isDefined(var_0)) {
      childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_0);
      return;
    }

    return;
  }
}

#using_animtree("");

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function link_player_to_rig(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  var_0 playerlinktoblend(var_0.player_rig, "tag_player", var_1, 0.25, 0.25);
  wait var_1;
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

function rideloop(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  level.heli_trip_vehicle endon("unload");

  for(;;) {
    level.heli_trip_vehicle scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_idle", var_0);
  }
}

function ref_144c2() {
  self endon("death");
  self endon("disconnect");
  level.heli_trip_vehicle endon("heli_taking_off");

  for(;;) {
    wait 10;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "obj_exfil_nag");
  }
}

function get_player_rig() {
  if(!isDefined(level.next_rig_num)) {
    level.helitrip_next_rig_num = 0;
  }

  level.helitrip_next_rig_num++;
  level.helitrip_next_rig_num = clamp(level.helitrip_next_rig_num, 1, 4);
  return "seat" + level.helitrip_next_rig_num;
}

function load_hvt(var_0) {
  scripts\cp\cp_pickup_hostage::init_anims();
  var_1 = self;
  var_1.vip = var_0.hostagecarried;

  if(!isDefined(var_1.spawnintermissionatplayer)) {
    var_1.spawnintermissionatplayer = "left";
  }

  scripts\cp\cp_pickup_hostage::load_hvt(var_0, var_1, var_1.spawnintermissionatplayer);
  thread loscheckpassed(level);
}

function loscheckpassed(var_0) {
  level endon("game_ended");

  while(istrue(level.validatealivecount)) {
    wait 1;
  }

  wait level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_secured");
  level notify("cp_heli_trip_obj_secured_vo_done");
}

function all_alive_players_in_chopper() {
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      var_1++;
    }

    if(istrue(var_3.inchopper)) {
      var_0++;
    }
  }

  return var_0 > 0 && level.players.size == var_0 + var_1;
}

function isvalidplayer(var_0) {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(var_0) && scripts\cp\cp_laststand::player_in_laststand(self)) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(self.sessionstate == "spectator") {
    return false;
  }

  return true;
}

function wait_for_all_players_ready() {
  level endon("game_ended");
  level.heli_trip_vehicle endon("all_players_on_board");
  level.heli_trip_vehicle endon("heli_trip_timed_out");

  for(;;) {
    if(all_alive_players_in_chopper()) {
      level.heli_trip_vehicle notify("all_players_on_board");
      return;
    }

    wait 0.1;
  }
}

function spawn_chopper(var_0, var_1) {
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.script_disconnectpaths = 0;
  var_2.death_fx_on_self = 1;
  var_2.exfil_struct = var_1;
  var_1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_2);
  var_2.godmode = 1;
  var_2.health = 10000;
  var_2.maxhealth = 10000;
  var_2.team = "allies";
  var_2.script_team = "allies";
  var_2 setvehicleteam("allies");
  var_2 setCanDamage(0);
  spawnhelihvtexfilactors(var_2);

  if(isDefined(var_2.wmexfilally)) {
    if(!isDefined(var_2.actors)) {
      var_2.actors = [];
    }

    var_2.actors[var_2.actors.size] = var_2.wmexfilally;
  }

  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var_2.headicon, 12000);
  setheadiconmaxdistance(var_2.headicon, 1500);
  addclienttoheadiconmask(var_2.headicon, 10);
  setheadicondrawthroughgeo(var_2.headicon, 1);
  return var_2;
}

function spawnhelihvtexfilactors(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var_1)) {
    var_1 = "head_sas_urban_ar_rain";
  }

  var_2 = self;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("allied_pilot_fullbody_3");
  var_3 useanimtree(level.scr_animtree["exfil_ally"]);
  var_3.animname = "exfil_ally";
  var_4 = getstartorigin(var_2.origin, var_2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var_5 = getstartangles(var_2.origin, var_2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkTo(var_2);
  var_2.wmexfilally = var_3;
  thread idle_exfilally_loop(var_2);
}

function idle_exfilally_loop(var_0) {
  self endon("death");
  var_0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, "blima_drop_l_idle_in", "tag_origin");
  }
}

function wait_for_passengers(var_0) {
  level endon("game_ended");
  self solid();
  self.navobstacle = createnavobstaclebybounds(self.origin, (350, 350, 350), (0, 0, 0), "axis");

  if(istrue(var_0)) {
    heli_rpg_enemy_think(self);
    waitforhvtonboard();
    ref_1212d(level.heli_trip_vehicle, level.heli_trip_vehicle);
  }

  startplayerboarding();
}

function ref_13bc7(var_0) {
  var_1 = self;

  if(!isDefined(var_1.ref_121fb)) {
    var_1.ref_121fb = spawn("script_model", var_1.origin - (0, 0, 100));
    var_1.ref_121fb.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
    var_1.ref_121fb hide();
    var_1.ref_121fb setModel(var_1.model);
  }

  if(var_0) {
    var_1.ref_121fb connectpaths();
    var_1.ref_121fb delete();
    var_1.ref_121fb = undefined;
    return;
  }

  var_1.ref_121fb disconnectPaths();
}

function init_interactions(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + (0, 0, -110);
  var_5 = var_4 + var_1 * 20 + var_3 * 45;
  var_6 = var_4 + var_1 * 20 + var_2 * 45;
  var_7 = var_4 + var_1 * -20 + var_3 * 45;
  var_8 = var_4 + var_1 * -20 + var_2 * 45;
  create_vehicle_interaction(var_8, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self, var_0);
  create_vehicle_interaction(var_6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self, var_0);
  create_vehicle_interaction(var_7, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self, var_0);
  create_vehicle_interaction(var_5, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self, var_0);
}

function create_vehicle_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("tag_origin");
  var_5 setHintString(var_1);
  var_5 setCursorHint("HINT_BUTTON");
  var_5 sethintdisplayrange(200);
  var_5 sethintdisplayfov(90);
  var_5 setuserange(72);
  var_5 setusefov(90);
  var_5 sethintonobstruction("hide");
  var_5 setuseholdduration("duration_short");

  if(isDefined(var_4) && isbuiltinfunction(var_4)) {
    var_5 thread[[var_4]](var_3, var_2);
  } else {
    thread interaction_use_think(var_5, var_3);
  }

  thread interaction_disable_on_exit(var_5);
}

function interaction_use_think(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("heli_taking_off");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread playerpassengerthink(var_2);
    break;
  }
}

function interaction_disable_on_exit(var_0) {
  level endon("game_ended");
  var_0 waittill("heli_taking_off");
  self makeunusable();
}

function ref_144ba() {
  level endon("game_ended");
  self endon("death");
  self endon("load_hvt_started");
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = self.wmexfilally;

  if(!isDefined(var_6)) {
    return;
  }

  var_7 = undefined;

  foreach(var_9 in level.players) {
    if(isDefined(var_9.hostagecarried)) {
      var_7 = var_9.hostagecarried;
      break;
    }
  }

  if(!isDefined(var_7)) {
    level waittill("player_picked_up_hostage", var_9);
    var_7 = var_9.hostagecarried;
  }

  var_11 = "left";
  var_12 = "left";

  for(;;) {
    var_13 = distance2dsquared(var_7.origin, var_5);
    var_14 = distance2dsquared(var_7.origin, var_4);

    if(var_13 > var_14) {
      var_12 = "left";
    } else {
      var_12 = "right";
    }

    if(var_11 != var_12) {
      self.onjointeamnospectatorcallbacks = 1;
      var_11 = var_12;
      ref_13e58(var_6, self, var_11);
      self.spawnintermissionatplayer = var_11;
      self.onjointeamnospectatorcallbacks = 0;
    }

    wait 0.5;
  }
}

function ref_13e58(var_0, var_1) {
  self notify("stop_idle_anim");
  var_2 = scripts\engine\utility::ter_op(var_1 == "left", "turn_left", "turn_right");
  var_3 = scripts\engine\utility::ter_op(var_1 == "left", "blima_drop_l_idle_in", "blima_drop_r_idle_in");
  var_0 scripts\common\anim::anim_single_solo(self, var_2, "tag_origin");
  thread make_chopper_boss_look_at_ent(var_0, self);
}

function make_chopper_boss_look_at_ent(var_0, var_1) {
  self endon("death");
  var_0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var_0, var_1, "tag_origin");
  }
}

function waitforhvtonboard() {
  level endon("game_ended");
  var_0 = self;
  var_0.animname = "exfil_chopper";
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoleft(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_1 * 10 + var_2 * 64 + (0, 0, -110);
  var_5 = spawn("trigger_radius", var_4 + (0, 0, -200), 0, 64, 500);
  var_0.spawnintermissionatplayer = "left";
  thread ref_14371(var_0, var_5, "left");
  var_0 waittill("load_hvt_started");
  var_5 delete();
}

function ref_14371(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon(var_2);
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isvalidplayer(var_4) && isDefined(var_4.inchopper)) {
      continue;
    }

    if(isDefined(var_4.hostagecarried) && !istrue(var_4.trigger_water_fx) && !istrue(var_3) && !isDefined(self.vip) && !istrue(self.onjointeamnospectatorcallbacks)) {
      self notify("load_hvt_started");
      level notify("hvt_triggered_" + var_1);
      load_hvt(var_4);
      var_3 = 1;
      level notify("hvt_loaded_on_heli");
      break;
    }

    wait 0.2;
  }
}

function startplayerboarding() {
  level endon("game_ended");

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }

  level.heli_trip_vehicle notify("started_boarding");
  thread wait_for_all_players_ready();
  thread watchforhelitriptimeout();
  var_0 = self;
  var_0.animname = "exfil_chopper";
  init_interactions(var_0);
}

function watchforhelitriptimeout() {
  level endon("game_ended");
  self endon("all_players_on_board");
  self waittill("player_boarded_heli");
  var_0 = gettime() + 45000;

  while(gettime() <= var_0) {
    wait 3;
  }

  self notify("heli_trip_timed_out");
}

function go_to_landing_destination(var_0) {
  level endon("game_ended");
  var_1 = [];
  GscBinSkip0(0x2e, 0, var_0.origin);
}

function exit_map() {
  level endon("game_ended");
  var_0 = self;
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  wait 2;
  var_0 vehicle_setspeed(90, 10);
  var_0 waittill("goal");
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(var_0.vip)) {
    var_0.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var_0.minigun)) {
    var_0.minigun delete();
  }

  foreach(var_2 in var_0.actors) {
    if(isDefined(var_2.head)) {
      var_2.head delete();
    }

    var_2 delete();
  }

  if(isDefined(var_0.headicon)) {
    setheadiconimage(var_0.headicon);
  }

  var_0 delete();
  level.heli_trip_vehicle = undefined;
  level notify("heli_trip_deleted");
}

#using_animtree("mp_vehicles_always_loaded");

function ref_1212d(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("opening_right_door");
  var_0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_open_blima);
}

#using_animtree("");

function vehicle_register_on_level(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("opening_right_door");
  var_0 endon("closing_right_door");

  for(;;) {
    var_0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
    wait getanimlength(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
  }
}

function heli_rpg_enemy_think(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("closing_right_door");
  var_0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_blima);
}

function initanims(var_0) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
}

function script_model_alpha_anims() {
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["helidown_exfil"] = $cp_exfil_blima_hvt_lf_hvt;
  level.scr_animname["hvt"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_hvt";
  level.scr_anim["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level.scr_animname["hvt"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_hvt_idle";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["blima_getin"] = % sdr_cp_veh_lbravo_seat_2_getin;
  level.scr_animname["player"]["blima_getin"] = "sdr_cp_veh_lbravo_seat_2_getin";
  level.scr_eventanim["player"]["blima_getin"] = "cp_blima_getin";
  level.scr_anim["player"]["blima_idle"] = % sdr_cp_veh_lbravo_seat_2_idle;
  level.scr_animname["player"]["blima_idle"] = "sdr_cp_veh_lbravo_seat_2_idle";
  level.scr_eventanim["player"]["blima_idle"] = "cp_blima_idle";
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_alpha_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}