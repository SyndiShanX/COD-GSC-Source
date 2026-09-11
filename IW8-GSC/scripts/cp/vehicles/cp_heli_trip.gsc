/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cp_heli_trip.gsc
************************************************/

function start_heli_trip_sequence(var0, var1, var2, var3) {
  level endon("game_ended");
  initanims();
  level.heli_trip_vehicle = spawn_chopper(var0, var1);
  level.heli_trip_vehicle scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(level.heli_trip_vehicle.exfil_struct, 1);
  thread wait_for_passengers(level.heli_trip_vehicle);
  level.heli_trip_vehicle scripts\engine\utility::ref_143a5("all_players_on_board", "heli_trip_timed_out");

  if(isDefined(level.heli_trip_vehicle)) {
    destroynavobstacle(level.heli_trip_vehicle.navobstacle);
  }

  level notify("heli_trip_took_off");
  level.heli_trip_vehicle notify("heli_taking_off");
  level.heli_trip_vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(var2);
  level.heli_trip_vehicle notify("unload");
  level notify("heli_trip_over");
  wait 2;
  thread exit_map();
  level.helitrip_next_rig_num = undefined;
}

#using_animtree("script_model");

function playerpassengerthink(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  var1 = "tag_seat_2";

  switch (var0) {
    case "seat1":
      var1 = "tag_seat_2";
      break;
    case "seat2":
      var1 = "tag_seat_3";
      break;
    case "seat3":
      var1 = "tag_seat_4";
      break;
    case "seat4":
      var1 = "tag_seat_5";
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
  level.heli_trip_vehicle thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_getin", var1);
  wait getanimlength(%sdr_cp_veh_lbravo_seat_2_getin);
  self.player_rig linkTo(level.heli_trip_vehicle, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  self.inchopper = 1;
  level notify("exfil_sequence_started");
  level.heli_trip_vehicle notify("player_boarded_heli");
  thread ref_144c2();
  thread rideloop(var1);
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
    var2 = getcompleteweaponname("iw8_me_riotshield_mp");
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var2, undefined, undefined, 1);
    scripts\cp\cp_weapon::riotshieldonweaponchange();
    self.clearsixthsense = undefined;
  }

  self.inchopper = undefined;
}

function raid_seq4_objectives_func() {
  if(scripts\cp\cp_weapon::ref_124ad(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    var0 = undefined;
    var1 = self getweaponslistprimaries();

    foreach(var3 in var1) {
      if(nullweapon(var3)) {
        continue;
      }

      if(scripts\cp\utility::isriotshield(var3)) {
        continue;
      }

      if(!isDefined(var0)) {
        var4 = var3 getnoaltweapon();

        if(var4.inventorytype != "primary") {
          continue;
        }

        var0 = var3;
      }
    }

    if(isDefined(var0)) {
      childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var0);
      return;
    }

    return;
  }
}

#using_animtree("");

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0 predictstreampos(var0.origin);
  var3 = spawn("script_arms", var0.origin, 0, 0, var0);
  var3.player = var0;
  var0.player_rig = var3;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var0.player_rig delete();
  var0.player_rig = undefined;
}

function link_player_to_rig(var0, var1) {
  var0 endon("death");
  var0 endon("disconnect");

  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0.2;
  }

  var0 playerlinktoblend(var0.player_rig, "tag_player", var1, 0.25, 0.25);
  wait var1;
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

function rideloop(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  level.heli_trip_vehicle endon("unload");

  for(;;) {
    level.heli_trip_vehicle scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_idle", var0);
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

function load_hvt(var0) {
  scripts\cp\cp_pickup_hostage::init_anims();
  var1 = self;
  var1.vip = var0.hostagecarried;

  if(!isDefined(var1.spawnintermissionatplayer)) {
    var1.spawnintermissionatplayer = "left";
  }

  scripts\cp\cp_pickup_hostage::load_hvt(var0, var1, var1.spawnintermissionatplayer);
  thread loscheckpassed(level);
}

function loscheckpassed(var0) {
  level endon("game_ended");

  while(istrue(level.validatealivecount)) {
    wait 1;
  }

  wait level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_secured");
  level notify("cp_heli_trip_obj_secured_vo_done");
}

function all_alive_players_in_chopper() {
  var0 = 0;
  var1 = 0;

  foreach(var3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      var1++;
    }

    if(istrue(var3.inchopper)) {
      var0++;
    }
  }

  return var0 > 0 && level.players.size == var0 + var1;
}

function isvalidplayer(var0) {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(var0) && scripts\cp\cp_laststand::player_in_laststand(self)) {
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

function spawn_chopper(var0, var1) {
  var2 = scripts\common\vehicle::vehicle_spawn(var0);
  var2.vehicle_skipdeathmodel = 1;
  var2.script_disconnectpaths = 0;
  var2.death_fx_on_self = 1;
  var2.exfil_struct = var1;
  var1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var2);
  var2.godmode = 1;
  var2.health = 10000;
  var2.maxhealth = 10000;
  var2.team = "allies";
  var2.script_team = "allies";
  var2 setvehicleteam("allies");
  var2 setCanDamage(0);
  spawnhelihvtexfilactors(var2);

  if(isDefined(var2.wmexfilally)) {
    if(!isDefined(var2.actors)) {
      var2.actors = [];
    }

    var2.actors[var2.actors.size] = var2.wmexfilally;
  }

  var2.headicon = deleteheadicon(var2);
  setheadiconfriendlyimage(var2.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var2.headicon, 12000);
  setheadiconmaxdistance(var2.headicon, 1500);
  addclienttoheadiconmask(var2.headicon, 10);
  setheadicondrawthroughgeo(var2.headicon, 1);
  return var2;
}

function spawnhelihvtexfilactors(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var1)) {
    var1 = "head_sas_urban_ar_rain";
  }

  var2 = self;
  var3 = spawn("script_model", var2.origin);
  var3 setModel("allied_pilot_fullbody_3");
  var3 useanimtree(level.scr_animtree["exfil_ally"]);
  var3.animname = "exfil_ally";
  var4 = getstartorigin(var2.origin, var2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var5 = getstartangles(var2.origin, var2.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  var3.origin = var4;
  var3.angles = var5;
  var3 linkTo(var2);
  var2.wmexfilally = var3;
  thread idle_exfilally_loop(var2);
}

function idle_exfilally_loop(var0) {
  self endon("death");
  var0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, "blima_drop_l_idle_in", "tag_origin");
  }
}

function wait_for_passengers(var0) {
  level endon("game_ended");
  self solid();
  self.navobstacle = createnavobstaclebybounds(self.origin, (350, 350, 350), (0, 0, 0), "axis");

  if(istrue(var0)) {
    heli_rpg_enemy_think(self);
    waitforhvtonboard();
    ref_1212d(level.heli_trip_vehicle, level.heli_trip_vehicle);
  }

  startplayerboarding();
}

function ref_13bc7(var0) {
  var1 = self;

  if(!isDefined(var1.ref_121fb)) {
    var1.ref_121fb = spawn("script_model", var1.origin - (0, 0, 100));
    var1.ref_121fb.angles = scripts\engine\utility::ter_op(isDefined(var1.angles), var1.angles, (0, 0, 0));
    var1.ref_121fb hide();
    var1.ref_121fb setModel(var1.model);
  }

  if(var0) {
    var1.ref_121fb connectpaths();
    var1.ref_121fb delete();
    var1.ref_121fb = undefined;
    return;
  }

  var1.ref_121fb disconnectPaths();
}

function init_interactions(var0) {
  var1 = anglesToForward(self.angles);
  var2 = anglestoright(self.angles);
  var3 = anglestoleft(self.angles);
  var4 = self.origin + (0, 0, -110);
  var5 = var4 + var1 * 20 + var3 * 45;
  var6 = var4 + var1 * 20 + var2 * 45;
  var7 = var4 + var1 * -20 + var3 * 45;
  var8 = var4 + var1 * -20 + var2 * 45;
  create_vehicle_interaction(var8, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self, var0);
  create_vehicle_interaction(var6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self, var0);
  create_vehicle_interaction(var7, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self, var0);
  create_vehicle_interaction(var5, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self, var0);
}

function create_vehicle_interaction(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", var0);
  var5 setModel("tag_origin");
  var5 setHintString(var1);
  var5 setCursorHint("HINT_BUTTON");
  var5 sethintdisplayrange(200);
  var5 sethintdisplayfov(90);
  var5 setuserange(72);
  var5 setusefov(90);
  var5 sethintonobstruction("hide");
  var5 setuseholdduration("duration_short");

  if(isDefined(var4) && isbuiltinfunction(var4)) {
    var5 thread[[var4]](var3, var2);
  } else {
    thread interaction_use_think(var5, var3);
  }

  thread interaction_disable_on_exit(var5);
}

function interaction_use_think(var0, var1) {
  level endon("game_ended");
  var0 endon("heli_taking_off");
  self makeusable();

  for(;;) {
    self waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread playerpassengerthink(var2);
    break;
  }
}

function interaction_disable_on_exit(var0) {
  level endon("game_ended");
  var0 waittill("heli_taking_off");
  self makeunusable();
}

function ref_144ba() {
  level endon("game_ended");
  self endon("death");
  self endon("load_hvt_started");
  var0 = anglesToForward(self.angles);
  var1 = anglestoright(self.angles);
  var2 = anglestoleft(self.angles);
  var3 = self.origin + (0, 0, -110);
  var4 = var3 + var0 * 20 + var2 * 45;
  var5 = var3 + var0 * 20 + var1 * 45;
  var6 = self.wmexfilally;

  if(!isDefined(var6)) {
    return;
  }

  var7 = undefined;

  foreach(var9 in level.players) {
    if(isDefined(var9.hostagecarried)) {
      var7 = var9.hostagecarried;
      break;
    }
  }

  if(!isDefined(var7)) {
    level waittill("player_picked_up_hostage", var9);
    var7 = var9.hostagecarried;
  }

  var11 = "left";
  var12 = "left";

  for(;;) {
    var13 = distance2dsquared(var7.origin, var5);
    var14 = distance2dsquared(var7.origin, var4);

    if(var13 > var14) {
      var12 = "left";
    } else {
      var12 = "right";
    }

    if(var11 != var12) {
      self.onjointeamnospectatorcallbacks = 1;
      var11 = var12;
      ref_13e58(var6, self, var11);
      self.spawnintermissionatplayer = var11;
      self.onjointeamnospectatorcallbacks = 0;
    }

    wait 0.5;
  }
}

function ref_13e58(var0, var1) {
  self notify("stop_idle_anim");
  var2 = scripts\engine\utility::ter_op(var1 == "left", "turn_left", "turn_right");
  var3 = scripts\engine\utility::ter_op(var1 == "left", "blima_drop_l_idle_in", "blima_drop_r_idle_in");
  var0 scripts\common\anim::anim_single_solo(self, var2, "tag_origin");
  thread make_chopper_boss_look_at_ent(var0, self);
}

function make_chopper_boss_look_at_ent(var0, var1) {
  self endon("death");
  var0 endon("stop_idle_anim");

  for(;;) {
    scripts\common\anim::anim_single_solo(var0, var1, "tag_origin");
  }
}

function waitforhvtonboard() {
  level endon("game_ended");
  var0 = self;
  var0.animname = "exfil_chopper";
  var1 = anglesToForward(var0.angles);
  var2 = anglestoleft(var0.angles);
  var3 = anglestoright(var0.angles);
  var4 = var0.origin + var1 * 10 + var2 * 64 + (0, 0, -110);
  var5 = spawn("trigger_radius", var4 + (0, 0, -200), 0, 64, 500);
  var0.spawnintermissionatplayer = "left";
  thread ref_14371(var0, var5, "left");
  var0 waittill("load_hvt_started");
  var5 delete();
}

function ref_14371(var0, var1, var2) {
  level endon("game_ended");
  level endon(var2);
  var3 = 0;

  for(;;) {
    var0 waittill("trigger", var4);

    if(!isvalidplayer(var4) && isDefined(var4.inchopper)) {
      continue;
    }

    if(isDefined(var4.hostagecarried) && !istrue(var4.trigger_water_fx) && !istrue(var3) && !isDefined(self.vip) && !istrue(self.onjointeamnospectatorcallbacks)) {
      self notify("load_hvt_started");
      level notify("hvt_triggered_" + var1);
      load_hvt(var4);
      var3 = 1;
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
  var0 = self;
  var0.animname = "exfil_chopper";
  init_interactions(var0);
}

function watchforhelitriptimeout() {
  level endon("game_ended");
  self endon("all_players_on_board");
  self waittill("player_boarded_heli");
  var0 = gettime() + 45000;

  while(gettime() <= var0) {
    wait 3;
  }

  self notify("heli_trip_timed_out");
}

function go_to_landing_destination(var0) {
  level endon("game_ended");
  var1 = [];
  GscBinSkip0(0x2e, 0, var0.origin);
}

function exit_map() {
  level endon("game_ended");
  var0 = self;
  var0 vehicle_setspeed(5, 10);
  var0 cleartargetyaw();
  var0 setvehgoalpos(var0.origin + (0, 0, 1200), 1);
  wait 2;
  var0 vehicle_setspeed(90, 10);
  var0 waittill("goal");
  var0 setvehgoalpos(var0.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(var0.vip)) {
    var0.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var0.minigun)) {
    var0.minigun delete();
  }

  foreach(var2 in var0.actors) {
    if(isDefined(var2.head)) {
      var2.head delete();
    }

    var2 delete();
  }

  if(isDefined(var0.headicon)) {
    setheadiconimage(var0.headicon);
  }

  var0 delete();
  level.heli_trip_vehicle = undefined;
  level notify("heli_trip_deleted");
}

#using_animtree("mp_vehicles_always_loaded");

function ref_1212d(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 notify("opening_right_door");
  var0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_open_blima);
}

#using_animtree("");

function vehicle_register_on_level(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("opening_right_door");
  var0 endon("closing_right_door");

  for(;;) {
    var0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
    wait getanimlength(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
  }
}

function heli_rpg_enemy_think(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 notify("closing_right_door");
  var0 vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_blima);
}

function initanims(var0) {
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