/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\veh9_jltv.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("milarmorbig", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::_id_26ADACDEDD87D439(classname, 0);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "headlight_front_left", "tag_light_front_left", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "headlight_front_right", "tag_light_front_right", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "taillight_back_left", "tag_light_back_left", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "taillight_back_right", "tag_light_back_right", "headlights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "brakelight_back_left", "tag_light_back_left", "brakelights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "brakelight_back_right", "tag_light_back_right", "brakelights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_front_left", "tag_light_front_left", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_front_right", "tag_light_front_right", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_back_left", "tag_light_back_left", "daylights");
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "daylight_back_right", "tag_light_back_right", "daylights");

  switch (classname) {
    case "script_vehicle_iw9_jltv_turret_physics_backstabbed":
    case "script_vehicle_iw9_jltv_turret_physics":
    case "script_vehicle_iw9_jltv_turret_physics_gunship":
      _id_F397A06934ED627B();
      scripts\common\vehicle_build::build_aianims(::_id_864A367053EAF622, ::set_vehicle_anims, "veh9_jltv_turret");
      scripts\common\vehicle_build::build_unload_groups(::_id_1B5BC97E17D1F72E);
      break;
    case "script_vehicle_iw9_jltv_turret_hole_physics":
      scripts\common\vehicle_build::build_aianims(::_id_80EB2ED2F5952811, ::set_vehicle_anims, "veh9_jltv_turret_hole");
      scripts\common\vehicle_build::build_unload_groups(::_id_1B5BC97E17D1F72E);
      break;
    default:
      scripts\common\vehicle_build::build_aianims(::_id_A532DEEAB635DA50, ::set_vehicle_anims, "veh9_jltv");
      scripts\common\vehicle_build::build_unload_groups(::unload_groups);
      break;
  }

  _id_12A4C0B2EEB1DB9D = "veh9_mil_lnd_jltv_x_vehphys_hsk_sp";

  switch (classname) {
    case "script_vehicle_iw9_jltv_turret_physics_backstabbed":
    case "script_vehicle_iw9_jltv_turret_physics":
    case "script_vehicle_iw9_jltv_turret_physics_gunship":
    case "script_vehicle_iw9_jltv_turret_hole_physics":
      _id_12A4C0B2EEB1DB9D = "veh9_mil_lnd_jltv_turret_x_vehphys_hsk_sp";
      break;
  }

  _id_CFB2CE4545421678 = "veh9_jltv_physics_sp";

  switch (classname) {
    case "script_vehicle_iw9_jltv_physics_gunship":
      _id_CFB2CE4545421678 = "veh9_jltv_physics_sp_gunship";
      break;
    case "script_vehicle_iw9_jltv_turret_physics_backstabbed":
      _id_CFB2CE4545421678 = "veh9_jltv_physics_sp_backstabbed";
      break;
    case "script_vehicle_iw9_jltv_turret_physics_gunship":
      _id_CFB2CE4545421678 = "veh9_jltv_physics_sp_gunship";
      break;
  }

  level.vehicle.templates._id_FB41D1CA75009BF0["veh9_mil_lnd_jltv_vehphys_sp"] = "veh9_mil_lnd_jltv_x_vehphys_hsk_sp";
  level.vehicle.templates._id_CFB2CE4545421678["veh9_mil_lnd_jltv_vehphys_sp"] = "veh9_jltv_physics_sp";
  level.vehicle.templates._id_FB41D1CA75009BF0["veh9_mil_lnd_jltv_turret_vehphys_sp"] = "veh9_mil_lnd_jltv_turret_x_vehphys_hsk_sp";
  level.vehicle.templates._id_CFB2CE4545421678["veh9_mil_lnd_jltv_turret_vehphys_sp"] = "veh9_jltv_physics_sp";
  scripts\common\vehicle_build::_id_98128821320ABA35(model, _id_12A4C0B2EEB1DB9D, _id_CFB2CE4545421678, 0);
  scripts\common\vehicle_build::_id_2660787CA33CF457(classname, "tag_door_front_left", ["tag_mirror_left"]);
  scripts\common\vehicle_build::_id_2660787CA33CF457(classname, "tag_door_front_right", ["tag_mirror_right"]);
}

#using_animtree("vehicles");

init_local() {
  if(scripts\common\utility::issp())
    self useanimtree(#animtree);

  self.script_badplace = 1;
  classname = scripts\common\vehicle_code::get_vehicle_classname();

  if(issubstr(classname, "turret_hole"))
    self.vehicleanimalias = "veh9_jltv_turret_hole";
  else if(issubstr(classname, "turret"))
    self.vehicleanimalias = "veh9_jltv_turret";
  else
    self.vehicleanimalias = "veh9_jltv";

  self._id_BE3314F77FEF5D6B = ::_id_60A4B3C7E1DE8CF7;
  waitframe();

  if(isDefined(self.mgturret) && isDefined(self.mgturret[0])) {
    turret = self.mgturret[0];
    _id_34EDB5BEEA39A217 = spawnStruct();
    _id_34EDB5BEEA39A217.startfuncs = [::turret_playerstartfunc];
    _id_34EDB5BEEA39A217.stopfuncs = [::turret_playerstopfunc];
    turret thread scripts\engine\utility::script_func("turret_watchPlayerUse", _id_34EDB5BEEA39A217);
    turret.weapon = makeweapon(turret.weaponinfo);
  }
}

_id_60A4B3C7E1DE8CF7() {
  if(isDefined(self.exiting)) {
    return;
  }
  self.exiting = 1;
  veh = self getlinkedparent();
  _id_DC8625458EE5ED14 = veh getboundshalfsize();
  _id_D3F98FC142B03DF7 = _id_DC8625458EE5ED14[1];
  _id_D3F98FC142B03DF7 = _id_D3F98FC142B03DF7 + 40;

  for(;;) {
    _id_31CDF773B9C212F9 = veh.origin + anglestoleft(veh.angles) * _id_D3F98FC142B03DF7;
    _id_31CDF773B9C212F9 = scripts\engine\utility::drop_to_ground(_id_31CDF773B9C212F9, 0, 0);
    _id_1F8CF6D541A2F062 = scripts\engine\trace::player_trace(_id_31CDF773B9C212F9 + (0, 0, 70), _id_31CDF773B9C212F9 + (0, 0, 5));

    if(_id_1F8CF6D541A2F062["fraction"] < 0.9) {
      _id_703DF9E7E2C5A07A = veh.origin + anglestoright(veh.angles) * _id_D3F98FC142B03DF7;
      _id_703DF9E7E2C5A07A = scripts\engine\utility::drop_to_ground(_id_703DF9E7E2C5A07A, 0, 0);
      _id_1F8CF6D541A2F062 = scripts\engine\trace::player_trace(_id_703DF9E7E2C5A07A + (0, 0, 70), _id_703DF9E7E2C5A07A + (0, 0, 5));

      if(_id_1F8CF6D541A2F062["fraction"] < 0.9) {
        waitframe();
        continue;
      } else
        _id_7E6EA515CDBB4A45 = _id_703DF9E7E2C5A07A;
    } else
      _id_7E6EA515CDBB4A45 = _id_31CDF773B9C212F9;

    if(isDefined(_id_7E6EA515CDBB4A45)) {
      break;
    }

    wait 0.25;
  }

  self.exiting = undefined;
  return _id_7E6EA515CDBB4A45;
}

turret_playerstartfunc() {
  self endon("stop_turret_monitoring");
  level.player _id_3B64EB40368C1450::set("player_using_jltv_turret", "reload", 0);
  self setotherent(level.player);
  self setentityowner(level.player);
  self.owner = level.player;
  level.player remotecontrolturret(self);
  self waittill("death");

  if(!level.player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("reload"))
    level.player _id_3B64EB40368C1450::set("player_using_jltv_turret", "reload", 1);
}

turret_playerstopfunc() {
  self notify("stop_turret_monitoring");
  level.player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("player_using_jltv_turret");
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  level.player remotecontrolturretoff(self);
  _id_3F452C5CE7BA273E = self gettagangles("tag_flash");
  _id_A00884ED3A6D8B4B = getclosestpointonnavmesh(self.origin + anglesToForward(_id_3F452C5CE7BA273E) * 32);
  _id_DEE6508B0BA437C5 = (0, _id_3F452C5CE7BA273E[1], 0);
  level.player setOrigin(_id_A00884ED3A6D8B4B);
  level.player setplayerangles(_id_DEE6508B0BA437C5);
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % iw9_mp_veh_jltv_seat_0_getin_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % iw9_mp_veh_jltv_seat_1_getin_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % iw9_mp_veh_jltv_seat_2_getin_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % iw9_mp_veh_jltv_seat_3_getin_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_0_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_1_exit_idle_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_2_exit_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % iw9_mp_veh_jltv_seat_3_exit_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_0_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_1_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_2_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat = % iw9_mp_veh_jltv_seat_3_exit_combat_idle_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_0_exit_combat_run_geo_door;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_1_exit_combat_run_geo_door;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_2_exit_combat_run_geo_door;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_combat_run = % iw9_mp_veh_jltv_seat_3_exit_combat_run_geo_door;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_SEAT_WM_0";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_SEAT_WM_1";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_SEAT_WM_2";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_SEAT_WM_3";
  _id_E4B7E99A96C8829F[0].vehicle_death_ragdoll = 0;
  _id_E4B7E99A96C8829F[1].vehicle_death_ragdoll = 0;
  _id_E4B7E99A96C8829F[2].vehicle_death_ragdoll = 0;
  _id_E4B7E99A96C8829F[3].vehicle_death_ragdoll = 0;
  _id_E4B7E99A96C8829F[0]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[1]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[2]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[3]._id_8C700F3D98B81267 = 0;
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  _id_E4B7E99A96C8829F[1].death_impulse = 0;
  _id_E4B7E99A96C8829F[2].death_impulse = 0;
  _id_E4B7E99A96C8829F[3].death_impulse = 0;
  _id_E4B7E99A96C8829F[0]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[1]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[2]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[3]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[0]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[1]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[2]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[3]._id_70AA9EAF339DDB20 = 0;
  return _id_E4B7E99A96C8829F;
}

_id_A532DEEAB635DA50() {
  _id_E4B7E99A96C8829F = setanims();
  _id_E4B7E99A96C8829F[4] = spawnStruct();
  _id_E4B7E99A96C8829F[5] = spawnStruct();
  _id_E4B7E99A96C8829F[4].sittag = "TAG_SEAT_WM_4";
  _id_E4B7E99A96C8829F[5].sittag = "TAG_SEAT_WM_5";
  _id_E4B7E99A96C8829F[4].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[4]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[5]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[4]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[5]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[4]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[5]._id_70AA9EAF339DDB20 = 1;
  return _id_E4B7E99A96C8829F;
}

_id_864A367053EAF622() {
  _id_32B3FA46A054CBF0 = _id_6A27ACD95F4C4C00();
  _id_E4B7E99A96C8829F = setanims();
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0] = spawnStruct();
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].sittag = "TAG_TURRET";
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].death_impulse = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].mgturret = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].do_not_unload = 1;
  return _id_E4B7E99A96C8829F;
}

_id_80EB2ED2F5952811() {
  _id_32B3FA46A054CBF0 = _id_6A27ACD95F4C4C00();
  _id_E4B7E99A96C8829F = setanims();
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0] = spawnStruct();
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].bhasgunwhileriding = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].sittag = "TAG_SEAT_WM_TURRET_HOLE";
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_8C700F3D98B81267 = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].death_impulse = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[_id_32B3FA46A054CBF0].do_not_unload = 1;
  return _id_E4B7E99A96C8829F;
}

_id_6A27ACD95F4C4C00() {
  return 4;
}

unload_groups() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5];
  unload_groups["passengers"] = [1, 2, 3, 4, 5];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}

_id_1B5BC97E17D1F72E() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5, 6];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}

_id_F397A06934ED627B() {
  if(istrue(self.script_nomg)) {
    return;
  }
  mapname = getDvar("g_mapname");

  switch (mapname) {
    case "cp_lone":
      scripts\common\vehicle_build::build_turret("iw9_mg_jltv_cp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      return;
    case "veh_sandbox":
      scripts\common\vehicle_build::build_turret("iw9_mg_jltv_sp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      return;
    default:
      scripts\common\vehicle_build::build_turret("iw9_mg_jltv_sp", "tag_turret", "veh9_mil_lnd_jltv_turret_gun", "auto_ai", 0, 0);
      break;
  }
}