/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\veh9_jltv.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace veh9_jltv;

function main(model, type, classname) {
  build_template("milarmorbig", model, type, classname);
  build_localinit(&init_local);
  build_hud(classname, 0);
  function_2cf37d073c6bde84(classname, "headlight_front_left", "tag_light_front_left", "headlights");
  function_2cf37d073c6bde84(classname, "headlight_front_right", "tag_light_front_right", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_left", "tag_light_back_left", "headlights");
  function_2cf37d073c6bde84(classname, "taillight_back_right", "tag_light_back_right", "headlights");
  function_2cf37d073c6bde84(classname, "brakelight_back_left", "tag_light_back_left", "brakelights");
  function_2cf37d073c6bde84(classname, "brakelight_back_right", "tag_light_back_right", "brakelights");
  function_2cf37d073c6bde84(classname, "daylight_front_left", "tag_light_front_left", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_front_right", "tag_light_front_right", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_back_left", "tag_light_back_left", "daylights");
  function_2cf37d073c6bde84(classname, "daylight_back_right", "tag_light_back_right", "daylights");

  switch (classname) {
    case #"hash_2f258c5eff1031c6":
    case #"hash_433bfdd62201f1e8":
    case #"hash_cdf4f197603a8c27":
      build_turrets();
      build_aianims(&setanims_turret, &set_vehicle_anims, "veh9_jltv_turret");
      build_unload_groups(&function_1b5bc97e17d1f72e);
      break;
    case #"hash_3538a576aa03385e":
      build_aianims(&function_80eb2ed2f5952811, &set_vehicle_anims, "veh9_jltv_turret_hole");
      build_unload_groups(&function_1b5bc97e17d1f72e);
      break;
    case #"hash_9a0383913a3b78b":
    default:
      build_aianims(&function_a532deeab635da50, &set_vehicle_anims, "veh9_jltv");
      build_unload_groups(&unload_groups);
      break;
  }

  huskmodel = "veh9_mil_lnd_jltv_x_vehphys_hsk_sp";

  switch (classname) {
    case #"hash_2f258c5eff1031c6":
    case #"hash_3538a576aa03385e":
    case #"hash_433bfdd62201f1e8":
    case #"hash_cdf4f197603a8c27":
      huskmodel = "veh9_mil_lnd_jltv_turret_x_vehphys_hsk_sp";
      break;
  }

  husktype = "veh9_jltv_physics_sp";

  switch (classname) {
    case #"hash_d24cc88d8fcbebb7":
      husktype = "veh9_jltv_physics_sp_gunship";
      break;
    case #"hash_9a0383913a3b78b":
      husktype = "veh_jup_jltv_physics_sp_gunship";
      break;
    case #"hash_2f258c5eff1031c6":
      husktype = "veh9_jltv_physics_sp_backstabbed";
      break;
    case #"hash_433bfdd62201f1e8":
      husktype = "veh9_jltv_physics_sp_gunship";
      break;
  }

  level.vehicle.templates.husk["veh9_mil_lnd_jltv_vehphys_sp"] = "veh9_mil_lnd_jltv_x_vehphys_hsk_sp";
  level.vehicle.templates.husktype["veh9_mil_lnd_jltv_vehphys_sp"] = "veh9_jltv_physics_sp";
  level.vehicle.templates.husk["veh9_mil_lnd_jltv_turret_vehphys_sp"] = "veh9_mil_lnd_jltv_turret_x_vehphys_hsk_sp";
  level.vehicle.templates.husktype["veh9_mil_lnd_jltv_turret_vehphys_sp"] = "veh9_jltv_physics_sp";
  build_husk(model, huskmodel, husktype, 0);
  build_dependentparts(classname, "tag_door_front_left", ["tag_mirror_left"]);
  build_dependentparts(classname, "tag_door_front_right", ["tag_mirror_right"]);
}

#using_animtree("vehicles");

function init_local() {
  if(utility::issp()) {
    self useanimtree(#animtree);
  }

  self.script_badplace = 1;
  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(issubstr(classname, "turret_hole")) {
    self.vehicleanimalias = "veh9_jltv_turret_hole";
  } else if(issubstr(classname, "turret")) {
    self.vehicleanimalias = "veh9_jltv_turret";
  } else {
    self.vehicleanimalias = "veh9_jltv";
  }

  self.exitfunc = &function_60a4b3c7e1de8cf7;
  waitframe();

  if(isDefined(self.mgturret) && isDefined(self.mgturret[0])) {
    turret = self.mgturret[0];
    usefuncs = spawnStruct();
    usefuncs.startfuncs = [ &turret_playerstartfunc];
    usefuncs.stopfuncs = [ &turret_playerstopfunc];
    turret thread scripts\engine\utility::script_func("turret_watchPlayerUse", usefuncs);
    turret.weapon = makeweapon(turret.weaponinfo);
  }
}

function function_60a4b3c7e1de8cf7() {
  if(isDefined(self.exiting)) {
    return;
  }

  self.exiting = 1;
  veh = self getlinkedparent();
  bounds = veh getboundshalfsize();
  half_width = bounds[1];
  half_width += 40;

  while(true) {
    left_exit = veh.origin + anglestoleft(veh.angles) * half_width;
    left_exit = scripts\engine\utility::drop_to_ground(left_exit, 0, 0);
    in_solid = scripts\engine\trace::player_trace(left_exit + (0, 0, 70), left_exit + (0, 0, 5));

    if(in_solid["fraction"] < 0.9) {
      right_exit = veh.origin + anglestoright(veh.angles) * half_width;
      right_exit = scripts\engine\utility::drop_to_ground(right_exit, 0, 0);
      in_solid = scripts\engine\trace::player_trace(right_exit + (0, 0, 70), right_exit + (0, 0, 5));

      if(in_solid["fraction"] < 0.9) {
        waitframe();
        continue;
      } else {
        exitpos = right_exit;
      }
    } else {
      exitpos = left_exit;
    }

    if(isDefined(exitpos)) {
      break;
    }

    wait 0.25;
  }

  self.exiting = undefined;
  return exitpos;
}

function turret_playerstartfunc() {
  self endon("stop_turret_monitoring");
  level.player val::set("player_using_jltv_turret", "reload", 0);
  self setotherent(level.player);
  self setentityowner(level.player);
  self.owner = level.player;
  level.player remotecontrolturret(self);
  self waittill("death");

  if(!level.player val::get("reload")) {
    level.player val::set("player_using_jltv_turret", "reload", 1);
  }
}

function turret_playerstopfunc() {
  self notify("stop_turret_monitoring");
  level.player val::reset_all("player_using_jltv_turret");
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  level.player remotecontrolturretoff(self);
  gun_angles = self gettagangles("tag_flash");
  player_origin = getclosestpointonnavmesh(self.origin + anglesToForward(gun_angles) * 32);
  player_angles = (0, gun_angles[1], 0);
  level.player setOrigin(player_origin);
  level.player setplayerangles(player_angles);
}

function set_vehicle_anims(positions) {
  positions[0].vehicle_getinanim = % iw9_mp_veh_jltv_seat_0_getin_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getinanim = % iw9_mp_veh_jltv_seat_1_getin_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getinanim = % iw9_mp_veh_jltv_seat_2_getin_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getinanim = % iw9_mp_veh_jltv_seat_3_getin_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_0_exit_idle_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_1_exit_idle_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_2_exit_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_3_exit_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_0_exit_combat_idle_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_1_exit_combat_idle_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_2_exit_combat_idle_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_3_exit_combat_idle_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  positions[0].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_0_exit_combat_run_geo_door;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_1_exit_combat_run_geo_door;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_2_exit_combat_run_geo_door;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_3_exit_combat_run_geo_door;
  positions[3].vehicle_getinanim_clear = 0;
  return positions;
}

function setanims() {
  positions = [];

  for(i = 0; i < 4; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].bhasgunwhileriding = 0;
  positions[0].sittag = "TAG_SEAT_WM_0";
  positions[1].sittag = "TAG_SEAT_WM_1";
  positions[2].sittag = "TAG_SEAT_WM_2";
  positions[3].sittag = "TAG_SEAT_WM_3";
  positions[0].deathragdoll = 0;
  positions[1].deathragdoll = 0;
  positions[2].deathragdoll = 0;
  positions[3].deathragdoll = 0;
  positions[0].canshootinvehicle = 0;
  positions[1].canshootinvehicle = 0;
  positions[2].canshootinvehicle = 0;
  positions[3].canshootinvehicle = 0;
  positions[0].death_impulse = 0;
  positions[1].death_impulse = 0;
  positions[2].death_impulse = 0;
  positions[3].death_impulse = 0;
  positions[0].var_bcd0a0afd54c6491 = 0;
  positions[1].var_bcd0a0afd54c6491 = 0;
  positions[2].var_bcd0a0afd54c6491 = 0;
  positions[3].var_bcd0a0afd54c6491 = 0;
  positions[0].var_70aa9eaf339ddb20 = 0;
  positions[1].var_70aa9eaf339ddb20 = 0;
  positions[2].var_70aa9eaf339ddb20 = 0;
  positions[3].var_70aa9eaf339ddb20 = 0;
  return positions;
}

function function_a532deeab635da50() {
  positions = setanims();
  positions[4] = spawnStruct();
  positions[5] = spawnStruct();
  positions[4].sittag = "TAG_SEAT_WM_4";
  positions[5].sittag = "TAG_SEAT_WM_5";
  positions[4].deathragdoll = 1;
  positions[5].deathragdoll = 1;
  positions[4].canshootinvehicle = 1;
  positions[5].canshootinvehicle = 1;
  positions[4].death_impulse = 1;
  positions[5].death_impulse = 1;
  positions[4].var_bcd0a0afd54c6491 = 1;
  positions[5].var_bcd0a0afd54c6491 = 1;
  positions[4].var_70aa9eaf339ddb20 = 1;
  positions[5].var_70aa9eaf339ddb20 = 1;
  return positions;
}

function setanims_turret() {
  turretposition = function_6a27acd95f4c4c00();
  positions = setanims();
  positions[turretposition] = spawnStruct();
  positions[turretposition].bhasgunwhileriding = 0;
  positions[turretposition].sittag = "TAG_TURRET";
  positions[turretposition].deathragdoll = 1;
  positions[turretposition].canshootinvehicle = 0;
  positions[turretposition].death_impulse = 1;
  positions[turretposition].var_bcd0a0afd54c6491 = 0;
  positions[turretposition].var_70aa9eaf339ddb20 = 0;
  positions[turretposition].mgturret = 0;
  positions[turretposition].do_not_unload = 1;
  return positions;
}

function function_80eb2ed2f5952811() {
  turretposition = function_6a27acd95f4c4c00();
  positions = setanims();
  positions[turretposition] = spawnStruct();
  positions[turretposition].bhasgunwhileriding = 1;
  positions[turretposition].sittag = "TAG_SEAT_WM_TURRET_HOLE";
  positions[turretposition].deathragdoll = 1;
  positions[turretposition].canshootinvehicle = 0;
  positions[turretposition].death_impulse = 1;
  positions[turretposition].var_bcd0a0afd54c6491 = 1;
  positions[turretposition].var_70aa9eaf339ddb20 = 1;
  positions[turretposition].do_not_unload = 1;
  return positions;
}

function function_6a27acd95f4c4c00() {
  return 4;
}

function unload_groups() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5];
  unload_groups["passengers"] = [1, 2, 3, 4, 5];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}

function function_1b5bc97e17d1f72e() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5, 6];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}

function build_turrets() {
  if(istrue(self.script_nomg)) {
    return;
  }

  mapname = getDvar(@ "g_mapname");

  switch (mapname) {
    case #"hash_a53278cce220cfff":
      build_turret("iw9_mg_jltv_cp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      return;
    case #"hash_a6d774db4975ae40":
      build_turret("iw9_mg_jltv_sp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      return;
    default:
      build_turret("iw9_mg_jltv_sp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      break;
  }
}