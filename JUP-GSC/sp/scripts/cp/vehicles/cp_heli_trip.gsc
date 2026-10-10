/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\vehicles\cp_heli_trip.gsc
***************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_pickup_hostage;
#using scripts\cp\cp_weapons;
#using scripts\cp\infilexfil\blima_exfil;
#using scripts\cp\infilexfil\infilexfil;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\infilexfil;
#namespace cp_heli_trip;

function start_heli_trip_sequence(heli_spawner, var_afe93dce3222d6c1, path_struct, var_85bdae40d5e5afed, var_cc7b5c3d58edaee5) {
  level endon("game_ended");
  initanims();
  level.heli_trip_vehicle = spawn_chopper(heli_spawner, var_afe93dce3222d6c1);
  level.heli_trip_vehicle scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(level.heli_trip_vehicle.exfil_struct, 1);
  level.heli_trip_vehicle thread wait_for_passengers(var_85bdae40d5e5afed);
  level.heli_trip_vehicle waittill_any_2("all_players_on_board", "heli_trip_timed_out");

  if(isDefined(var_cc7b5c3d58edaee5) && flag_exist(var_cc7b5c3d58edaee5)) {
    flag_wait(var_cc7b5c3d58edaee5);
  }

  if(isDefined(level.heli_trip_vehicle) && isDefined(level.heli_trip_vehicle.navobstacle)) {
    destroynavobstacle(level.heli_trip_vehicle.navobstacle);
  }

  level notify("heli_trip_took_off");
  level.heli_trip_vehicle notify("heli_taking_off");
  level.heli_trip_vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(path_struct);
  level.heli_trip_vehicle notify("unload");
  level notify("heli_trip_over");
  wait 2;
  level.heli_trip_vehicle thread exit_map();
  level.helitrip_next_rig_num = undefined;
}

#using_animtree("script_model");

function playerpassengerthink(seatnumber) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  var_967aeb4d5a42ebc5 = "tag_seat_2";

  switch (seatnumber) {
    case #"hash_818e3b2db6fa04fb":
      var_967aeb4d5a42ebc5 = "tag_seat_2";
      break;
    case #"hash_818e3c2db6fa068e":
      var_967aeb4d5a42ebc5 = "tag_seat_3";
      break;
    case #"hash_818e3d2db6fa0821":
      var_967aeb4d5a42ebc5 = "tag_seat_4";
      break;
    case #"hash_818e3e2db6fa09b4":
      var_967aeb4d5a42ebc5 = "tag_seat_5";
      break;
  }

  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  self.is_riding_heli = 1;
  get_rid_of_minigun();

  if(scripts\cp\utility::riotshield_hasweapon()) {
    self.bhadriotshield = 1;
  }

  scripts\cp\cp_weapons::takeriotshield(self);
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  thread create_player_rig(self, "player");
  anim_first_frame_solo(self.player_rig, "blima_getin");
  link_player_to_rig(self, 0.4);
  self.player_rig.weapon_state_func = &handleweaponstatenotetrackcp;
  level.heli_trip_vehicle thread anim_player_solo(self, self.player_rig, "blima_getin", var_967aeb4d5a42ebc5);
  wait getanimlength(%sdr_cp_veh_lbravo_seat_2_getin);
  self.player_rig linkTo(level.heli_trip_vehicle, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  self.inchopper = 1;
  level notify("exfil_sequence_started");
  level.heli_trip_vehicle notify("player_boarded_heli");
  thread watchfornagstootherplayers();
  thread rideloop(var_967aeb4d5a42ebc5);
  level.heli_trip_vehicle waittill("unload");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self stopanimscriptsceneevent();
  self notify("remove_rig");
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  self.is_riding_heli = 0;
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  takegunlesscp();

  if(istrue(self.bhadriotshield)) {
    shield = makeweapon("iw9_me_riotshield_mp");
    scripts\cp_mp\utility\inventory_utility::_giveweapon(shield, undefined, undefined, 1);
    scripts\cp\weapon::riotshieldonweaponchange();
    self.bhadriotshield = undefined;
  }

  self.inchopper = undefined;
}

function get_rid_of_minigun() {
  if(scripts\cp\weapon::player_has_minigun(self)) {
    scripts\cp\weapon::drop_minigun(self);
    var_102d661b1caa8bc1 = undefined;
    primaryweapons = self getweaponslistprimaries();

    foreach(weapon in primaryweapons) {
      if(isnullweapon(weapon)) {
        continue;
      }

      if(isriotshield(weapon)) {
        continue;
      }

      if(!isDefined(var_102d661b1caa8bc1)) {
        noaltweapon = weapon getnoaltweapon();

        if(noaltweapon.inventorytype != "primary") {
          continue;
        }

        var_102d661b1caa8bc1 = weapon;
      }
    }

    if(isDefined(var_102d661b1caa8bc1)) {
      childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_102d661b1caa8bc1);
    }
  }
}

function create_player_rig(player, animname, rig_model) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }

  player.animname = animname;

  if(!isDefined(rig_model)) {
    rig_model = "viewhands_base_iw8";
  }

  player function_b88c89bb7cd1ab8e(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  player watch_remove_rig();
  remove_player_rig(player);
}

function watch_remove_rig(struct) {
  waittill_any_3("remove_rig", "death", "disconnect");
}

function remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

function link_player_to_rig(player, blendtime) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  player playerlinktoblend(player.player_rig, "tag_player", blendtime, 0.25, 0.25);
  wait blendtime;
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

function rideloop(tag) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  level.heli_trip_vehicle endon("unload");

  while(true) {
    level.heli_trip_vehicle anim_player_solo(self, self.player_rig, "blima_idle", tag);
  }
}

function watchfornagstootherplayers() {
  self endon("death");
  self endon("disconnect");
  level.heli_trip_vehicle endon("heli_taking_off");

  while(true) {
    wait 10;
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

function load_hvt(player) {
  scripts\cp\cp_pickup_hostage::init_anims();
  heli = self;
  heli.vip = player.hostagecarried;

  if(!isDefined(heli.hvtboardingside)) {
    heli.hvtboardingside = "left";
  }

  scripts\cp\cp_pickup_hostage::load_hvt(player, heli, heli.hvtboardingside);
  level thread do_secured_player_vo(player);
}

function do_secured_player_vo(player) {
  level endon("game_ended");

  while(istrue(level.isteamvoplaying)) {
    wait 1;
  }

  level notify("cp_heli_trip_obj_secured_vo_done");
}

function all_alive_players_in_chopper() {
  var_44992e6b98f5ec99 = 0;
  playersinlaststand = 0;
  var_9c59d410d0f1b202 = 0;

  foreach(player in level.players) {
    if(scripts\cp\laststand::player_in_laststand(player)) {
      playersinlaststand++;
    }

    if(istrue(player.inchopper)) {
      var_44992e6b98f5ec99++;
    }

    if(istrue(player.var_250796613b419e6b)) {
      var_9c59d410d0f1b202++;
    }
  }

  return var_44992e6b98f5ec99 > 0 && level.players.size == var_44992e6b98f5ec99 + playersinlaststand + var_9c59d410d0f1b202;
}

function isvalidplayer(var_873769d3e3ec0986) {
  if(!isPlayer(self)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  if(!isDefined(var_873769d3e3ec0986) && scripts\cp\laststand::player_in_laststand(self)) {
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

  while(true) {
    if(all_alive_players_in_chopper()) {
      level.heli_trip_vehicle notify("all_players_on_board");
      return;
    }

    wait 0.1;
  }
}

function spawn_chopper(origin_spawner, exfil_struct) {
  heli = scripts\common\vehicle::vehicle_spawn(origin_spawner);
  heli.vehicle_skipdeathmodel = 1;
  heli.script_disconnectpaths = 0;
  heli.death_fx_on_self = 1;
  heli.exfil_struct = exfil_struct;
  exfil_struct.smoke_canister = smoke_canister_spawn(exfil_struct.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(heli);
  heli.godmode = 1;
  heli.health = 10000;
  heli.maxhealth = 10000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);
  heli spawnhelihvtexfilactors();

  if(isDefined(heli.wmexfilally)) {
    if(!isDefined(heli.actors)) {
      heli.actors = [];
    }

    heli.actors[heli.actors.size] = heli.wmexfilally;
  }

  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  return heli;
}

function spawnhelihvtexfilactors(var_f97dd5b98052176a, var_91e906ddd7521a40) {
  if(!isDefined(var_f97dd5b98052176a)) {
    var_f97dd5b98052176a = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var_91e906ddd7521a40)) {
    var_91e906ddd7521a40 = "head_sas_urban_ar_rain";
  }

  var_c7d12eecee25e41d = self;
  wmexfilally = spawn("script_model", var_c7d12eecee25e41d.origin);
  wmexfilally setModel("allied_pilot_fullbody_3");
  wmexfilally useanimtree(level.scr_animtree["exfil_ally"]);
  wmexfilally.animname = "exfil_ally";
  startpos = getstartorigin(var_c7d12eecee25e41d.origin, var_c7d12eecee25e41d.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  startangles = getstartangles(var_c7d12eecee25e41d.origin, var_c7d12eecee25e41d.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  wmexfilally.origin = startpos + (0, 0, 210);
  wmexfilally.angles = startangles;
  wmexfilally linkTo(var_c7d12eecee25e41d);
  var_c7d12eecee25e41d.wmexfilally = wmexfilally;
  var_8cab70160b4f7ff4 = spawn("script_model", startpos + (0, 0, 210));
  var_8cab70160b4f7ff4 setModel("tag_origin");
  var_8cab70160b4f7ff4 linkTo(var_c7d12eecee25e41d);
  var_c7d12eecee25e41d thread idle_exfilally_loop(wmexfilally, var_8cab70160b4f7ff4);
}

function idle_exfilally_loop(exfilally, var_8cab70160b4f7ff4) {
  self endon("death");
  exfilally endon("stop_idle_anim");

  while(true) {
    var_8cab70160b4f7ff4 scripts\common\anim::anim_single_solo(exfilally, "blima_drop_l_idle_in", "tag_origin");
  }
}

function wait_for_passengers(var_85bdae40d5e5afed) {
  level endon("game_ended");
  self solid();

  if(istrue(var_85bdae40d5e5afed)) {
    closerightblimadoor(self);
    waitforhvtonboard();
    level.heli_trip_vehicle openrightblimadoor(level.heli_trip_vehicle);
  }

  startplayerboarding();
}

function toggleconnectpaths(toggle) {
  heli = self;

  if(!isDefined(heli.pathblocker)) {
    heli.pathblocker = spawn("script_model", heli.origin - (0, 0, 100));
    heli.pathblocker.angles = ter_op(isDefined(heli.angles), heli.angles, (0, 0, 0));
    heli.pathblocker hide();
    heli.pathblocker setModel(heli.model);
  }

  if(toggle) {
    heli.pathblocker connectpaths();
    heli.pathblocker delete();
    heli.pathblocker = undefined;
    return;
  }

  heli.pathblocker disconnectPaths();
}

function init_interactions(usefuncoverride) {
  fwd = anglesToForward(self.angles);
  rt = anglestoright(self.angles);
  lft = anglestoleft(self.angles);
  org = self.origin + (0, 0, -60);
  pos4 = org + fwd * 20 + lft * 45;
  pos2 = org + fwd * 20 + rt * 45;
  pos3 = org + fwd * -20 + lft * 45;
  pos1 = org + fwd * -20 + rt * 45;
  create_vehicle_interaction(pos1, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self, usefuncoverride);
  create_vehicle_interaction(pos2, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self, usefuncoverride);
  create_vehicle_interaction(pos3, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self, usefuncoverride);
  create_vehicle_interaction(pos4, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self, usefuncoverride);
}

function create_vehicle_interaction(loc, hintstring, var_d079963b8d1ff3af, vehicle, usefuncoverride) {
  interaction = spawn("script_model", loc);
  interaction setModel("tag_origin");
  interaction makeusable();
  interaction setHintString(hintstring);
  interaction setCursorHint("HINT_BUTTON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(72);
  interaction setusefov(90);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");

  if(isDefined(usefuncoverride) && isfunction(usefuncoverride)) {
    interaction thread[[usefuncoverride]](vehicle, var_d079963b8d1ff3af);
  } else {
    interaction thread interaction_use_think(vehicle, var_d079963b8d1ff3af);
  }

  level thread draw_circle(loc, 128, (0, 0, 1), 1, 0, 3000);
  interaction thread function_1522105805bb751(vehicle, var_d079963b8d1ff3af);
}

function interaction_use_think(vehicle, var_d079963b8d1ff3af) {
  level endon("game_ended");
  vehicle endon("heli_taking_off");
  self function_dfb78b3e724ad620(1);

  while(true) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self function_dfb78b3e724ad620(0);
    player thread playerpassengerthink(var_d079963b8d1ff3af);
    break;
  }
}

function function_1522105805bb751(vehicle, var_d079963b8d1ff3af) {
  level endon("game_ended");
  vehicle waittill_any_2("heli_taking_off", "disable_" + var_d079963b8d1ff3af);
  self function_dfb78b3e724ad620(0);
}

function watchforexfilallyturntoside() {
  level endon("game_ended");
  self endon("death");
  self endon("load_hvt_started");
  fwd = anglesToForward(self.angles);
  rt = anglestoright(self.angles);
  lft = anglestoleft(self.angles);
  org = self.origin + (0, 0, -110);
  leftpos = org + fwd * 20 + lft * 45;
  rightpos = org + fwd * 20 + rt * 45;
  exfilally = self.wmexfilally;

  if(!isDefined(exfilally)) {
    return;
  }

  hvt = undefined;

  foreach(player in level.players) {
    if(isDefined(player.hostagecarried)) {
      hvt = player.hostagecarried;
      break;
    }
  }

  if(!isDefined(hvt)) {
    level waittill("player_picked_up_hostage", player);
    hvt = player.hostagecarried;
  }

  var_bd5e53637fc4f840 = "left";
  var_bf7e8c22b315bf07 = "left";

  while(true) {
    var_7ab1343bcc5bcd5e = distance2dsquared(hvt.origin, rightpos);
    var_59c930fa00b280c5 = distance2dsquared(hvt.origin, leftpos);

    if(var_7ab1343bcc5bcd5e > var_59c930fa00b280c5) {
      var_bf7e8c22b315bf07 = "left";
    } else {
      var_bf7e8c22b315bf07 = "right";
    }

    if(var_bd5e53637fc4f840 != var_bf7e8c22b315bf07) {
      self.exfilallyturning = 1;
      var_bd5e53637fc4f840 = var_bf7e8c22b315bf07;
      exfilally turnexfiltoside(self, var_bd5e53637fc4f840);
      self.hvtboardingside = var_bd5e53637fc4f840;
      self.exfilallyturning = 0;
    }

    wait 0.5;
  }
}

function turnexfiltoside(heli, facing) {
  self notify("stop_idle_anim");
  turnanim = ter_op(facing == "left", "turn_left", "turn_right");
  idleanim = ter_op(facing == "left", "blima_drop_l_idle_in", "blima_drop_r_idle_in");
  heli scripts\common\anim::anim_single_solo(self, turnanim, "tag_origin");
  heli thread doexfilallyidle(self, idleanim);
}

function doexfilallyidle(exfilally, idleanim) {
  self endon("death");
  exfilally endon("stop_idle_anim");

  while(true) {
    scripts\common\anim::anim_single_solo(exfilally, idleanim, "tag_origin");
  }
}

function waitforhvtonboard() {
  level endon("game_ended");
  var_214da032eefdfe74 = self;
  var_214da032eefdfe74.animname = "exfil_chopper";
  fwd = anglesToForward(var_214da032eefdfe74.angles);
  lft = anglestoleft(var_214da032eefdfe74.angles);
  var_cbac2203146ae84a = anglestoright(var_214da032eefdfe74.angles);
  pos1 = var_214da032eefdfe74.origin + fwd * 10 + lft * 64 + (0, 0, -110);
  var_aa573402a27ca636 = spawn("trigger_radius", pos1 + (0, 0, -200), 0, 64, 500);
  var_214da032eefdfe74.hvtboardingside = "left";
  var_214da032eefdfe74 thread waitforhvttrigger(var_aa573402a27ca636, "left", "hvt_triggered_right");
  var_214da032eefdfe74 waittill("load_hvt_started");
  var_aa573402a27ca636 delete();
}

function waitforhvttrigger(trig, side, endonstring) {
  level endon("game_ended");
  level endon(endonstring);
  var_f33ad00f7e48889a = 0;

  while(true) {
    trig waittill("trigger", ent);

    if(!ent isvalidplayer() && isDefined(ent.inchopper)) {
      continue;
    }

    if(isDefined(ent.hostagecarried) && !istrue(ent.is_dropping_hostage) && !istrue(var_f33ad00f7e48889a) && !isDefined(self.vip) && !istrue(self.exfilallyturning)) {
      self notify("load_hvt_started");
      level notify("hvt_triggered_" + side);
      load_hvt(ent);
      var_f33ad00f7e48889a = 1;
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
  level thread wait_for_all_players_ready();
  thread watchforhelitriptimeout();
  var_214da032eefdfe74 = self;
  var_214da032eefdfe74.animname = "exfil_chopper";
  var_214da032eefdfe74 init_interactions();
}

function watchforhelitriptimeout() {
  level endon("game_ended");
  self endon("all_players_on_board");
  self waittill("player_boarded_heli");
  endtime = gettime() + 45000;

  while(gettime() <= endtime) {
    wait 3;
  }

  self notify("heli_trip_timed_out");
}

function go_to_landing_destination(var_818b6eaace794492) {
  level endon("game_ended");
  var_f8ba776ff60edd65 = [];
  var_f8ba776ff60edd65[0] = var_818b6eaace794492.origin;

  for(var_aafce2b1bbdd60b3 = var_818b6eaace794492; isDefined(var_aafce2b1bbdd60b3.target); var_aafce2b1bbdd60b3 = var_bf0747570224990a) {
    var_bf0747570224990a = getStruct(var_aafce2b1bbdd60b3.target, "targetname");
    var_f8ba776ff60edd65[var_f8ba776ff60edd65.size] = var_bf0747570224990a.origin;
  }

  var_32968d58d8099ef5 = var_f8ba776ff60edd65.size;
  self notify("heli_taking_off");
  heli = self;
  heli disconnectPaths();
  heli vehicle_setspeed(5, 10);
  heli cleartargetyaw();
  heli setvehgoalpos(heli.origin + (0, 0, 1200), 1);
  wait 2;
  level notify("heli_trip_took_off");
  heli vehicle_setspeed(90, 10);
  heli waittill("goal");

  if(var_32968d58d8099ef5 > 1) {
    heli vehicle_setspeed(80, 250, 250);

    for(i = 0; i < var_32968d58d8099ef5 - 1; i++) {
      heli setvehgoalpos(var_f8ba776ff60edd65[i], 0);
      heli setneargoalnotifydist(200);
      heli waittill("near_goal");
    }
  }

  heli vehicle_setspeed(90, 10);
  heli setvehgoalpos(var_f8ba776ff60edd65[var_f8ba776ff60edd65.size - 1] + (0, 0, 1200), 1);
  heli waittill("goal");
  heli settargetyaw(heli.exfil_struct.angles[1]);
  heli setyawspeed(50, 25, 25, 0);
  wait 3;
  heli.goalradius = 4;
  heli setvehgoalpos(var_f8ba776ff60edd65[var_f8ba776ff60edd65.size - 1], 1);
  heli waittill("goal");
  heli vehicle_setspeedimmediate(0);
  heli vehicle_cleardrivingstate();
}

function exit_map() {
  level endon("game_ended");
  heli = self;
  heli vehicle_setspeed(5, 10);
  heli cleartargetyaw();
  heli setvehgoalpos(heli.origin + (0, 0, 1200), 1);
  wait 2;
  heli vehicle_setspeed(90, 10);
  heli waittill("goal");
  heli setvehgoalpos(heli.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(heli.vip)) {
    heli.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(heli.minigun)) {
    heli.minigun delete();
  }

  foreach(actor in heli.actors) {
    if(isDefined(actor.head)) {
      actor.head delete();
    }

    actor delete();
  }

  if(isDefined(heli.headicon)) {
    deleteheadicon(heli.headicon);
  }

  heli delete();
  level.heli_trip_vehicle = undefined;
  level notify("heli_trip_deleted");
}

#using_animtree("mp_vehicles_always_loaded");

function openrightblimadoor(heli) {
  level endon("game_ended");
  heli endon("death");
  heli notify("opening_right_door");
  heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_open_blima);
}

function keeprightdooropen(heli) {
  level endon("game_ended");
  heli endon("death");
  heli endon("opening_right_door");
  heli endon("closing_right_door");

  while(true) {
    heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
    wait getanimlength(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
  }
}

function closerightblimadoor(heli) {
  level endon("game_ended");
  heli endon("death");
  heli notify("closing_right_door");
  heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_blima);
}

function initanims(subtype) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
}

#using_animtree("script_model");

function script_model_alpha_anims() {
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_hvt;
  level.scr_anim["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["blima_getin"] = % sdr_cp_veh_lbravo_seat_2_getin;
  level.scr_eventanim["player"]["blima_getin"] = % "hash_4a22cc3793b9ca05";
  level.scr_anim["player"]["blima_idle"] = % sdr_cp_veh_lbravo_seat_2_idle;
  level.scr_eventanim["player"]["blima_idle"] = % "hash_1c1981f19fcbef18";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
}

function smoke_canister_spawn(location, start_on) {
  spawnpos = drop_to_ground(location, 50, -200, (0, 0, 1));
  spawnpos += (0, 0, 1);
  magicgrenademanual("deploy_airdrop_mp", spawnpos, (0, randomint(360), 0), 0.01);
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_alpha_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}