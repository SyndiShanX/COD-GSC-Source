/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3af63beeaab2e0a7.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("truckbig", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::_id_26ADACDEDD87D439(classname, 2);
  _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_vehphys_hsk_sp";

  switch (model) {
    case "veh9_civ_lnd_techo_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_techo_vehphys_sp_dirty_tan":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_vehphys_hsk_sp_dirty_tan";
      break;
    case "veh9_civ_lnd_techo_vehphys_sp_dirty_black":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_vehphys_hsk_sp_dirty_black";
      break;
    case "veh9_civ_lnd_techo_rebel_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_rebel_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_techo_rebel_armor_vehphys_sp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_rebel_armor_vehphys_hsk_sp";
      break;
    case "veh9_civ_lnd_techo_rebel_armor_vehphys_cp":
      _id_12A4C0B2EEB1DB9D = "veh9_civ_lnd_techo_rebel_armor_vehphys_hsk_cp";
      break;
  }

  scripts\common\vehicle_build::_id_98128821320ABA35(model, _id_12A4C0B2EEB1DB9D, "veh9_techo_physics_sp");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "techo");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_light(classname, "rack_lights", "tag_origin", "vfx/iw9/level/nightwar_ps/vfx_veh_nw_racklight_techo_01", "racklights");
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_left", "tag_light_front_left", "vfx/iw9/level/nightwar_ps/vfx_veh_nw_headlight_techo_left", "headlights");
  scripts\common\vehicle_build::build_light(classname, "headlight_truck_right", "tag_light_front_right", "vfx/iw9/level/nightwar_ps/vfx_veh_nw_headlight_techo_right", "headlights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_right", "tag_light_back_right", "vfx/iw9/level/nightwar_ps/vfx_veh_nw_taillight_techo_right", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "taillight_truck_left", "tag_light_back_left", "vfx/iw9/level/nightwar_ps/vfx_veh_nw_taillight_techo_left", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_right", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "brakelights");
  scripts\common\vehicle_build::build_light(classname, "brakelight_truck_left", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "brakelights");
  level._effect["techo_armor_off"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_armor_break.vfx");

  if(scripts\common\utility::issp())
    _id_F411A3B55798DE07();
}

_id_F411A3B55798DE07() {
  precachemodel("veh8_civ_lnd_techo_rebel_armor_01");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_02");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_03");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_04");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_05");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_06");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_07");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_08");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_09");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_10");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_11");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_12");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_13");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_14");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_15");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_16");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_17");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_18");
  precachemodel("veh8_civ_lnd_techo_rebel_armor_19");
}

#using_animtree("vehicles");

init_local() {
  if(scripts\common\utility::issp())
    self useanimtree(#animtree);

  self.script_badplace = 1;
  self.vehicleanimalias = "techo";

  if(scripts\common\utility::iscp())
    self.vehicleanimalias = self.vehicleanimalias + "_cp";

  if(isstartstr(self.model, "veh9_civ_lnd_techo_rebel_armor"))
    thread _id_7ADD34C7140D88BE();
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % reb_com_veh8_techo_fl_door_open;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % reb_com_veh8_techo_fr_door_open;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_SEAT_0";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_SEAT_1";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_SEAT_2";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_SEAT_3";
  _id_E4B7E99A96C8829F[4].sittag = "TAG_SEAT_4";
  _id_E4B7E99A96C8829F[5].sittag = "TAG_SEAT_5";
  _id_E4B7E99A96C8829F[6].sittag = "TAG_SEAT_6";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[4].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  _id_E4B7E99A96C8829F[0]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[1]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[2]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[3]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[4]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[5]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[6]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[0]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[1]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[2]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[3]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[4]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[5]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[6]._id_70AA9EAF339DDB20 = 1;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  unload_groups["driver"] = [0];
  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  return unload_groups;
}

_id_7ADD34C7140D88BE() {
  self notify("armor_init");
  self endon("armor_init");
  _id_9D21E843B2A359CE = 125;
  self._id_2713FD656D03D0CE = 1;
  self._id_9D21E843B2A359CE = _id_9D21E843B2A359CE;
  self._id_C543F8E941150B0B = ::_id_C543F8E941150B0B;
  self._id_2352359EF3EEFCD3 = ::_id_2352359EF3EEFCD3;

  if(scripts\common\utility::issp()) {
    self._id_C939463D099534D4 = 0;
    self._id_F21375AF7E927B7F = 0;
    self._id_45148BB6235DA900 = 0;

    if(!isDefined(self.damage_functions))
      self.damage_functions = [];

    self.damage_functions[self.damage_functions.size] = ::_id_CCB8C9DF533B4C57;
  }
}

_id_2352359EF3EEFCD3(attacker, amount, partname, direction_vec, damagelocation) {
  if(!isDefined(partname) || !isstartstr(partname, "tag_armor")) {
    return;
  }
  _id_9D21E843B2A359CE = 120;

  if(scripts\common\utility::issp())
    _id_9D21E843B2A359CE = 65;

  if(!isDefined(self._id_63739B0CC782E9E0))
    self._id_63739B0CC782E9E0 = [];

  if(!isDefined(self._id_63739B0CC782E9E0[partname]))
    self._id_63739B0CC782E9E0[partname] = 0;

  self._id_63739B0CC782E9E0[partname] = self._id_63739B0CC782E9E0[partname] + amount;

  if(self._id_63739B0CC782E9E0[partname] >= _id_9D21E843B2A359CE) {
    scripts\common\utility::_id_3677F2BE30FDD581(partname, "death");
    thread _id_7E2E5EC8C0F429AC(partname, direction_vec, damagelocation);

    if(isDefined(self._id_9ACFC0BD86B2E2C1))
      attacker[[self._id_9ACFC0BD86B2E2C1]]("hitveharmorbreak");
  } else if(isDefined(self._id_9ACFC0BD86B2E2C1))
    attacker[[self._id_9ACFC0BD86B2E2C1]]("hitveharmor");
}

_id_7E2E5EC8C0F429AC(partname, direction_vec, damagelocation) {
  plate = spawn("script_model", self gettagorigin(partname));
  plate.angles = self gettagangles(partname);
  _id_94D5A0B9B2544337 = strtok(partname, "_");
  _id_5F29F5B939C96795 = _id_94D5A0B9B2544337[1] + "_" + _id_94D5A0B9B2544337[2];
  plate setModel("veh8_civ_lnd_techo_rebel_" + _id_5F29F5B939C96795);
  _id_16290C9DDA466BCE = self vehicle_getvelocity();

  if(_id_16290C9DDA466BCE[2] < 5)
    plate physicslaunchclient(damagelocation, direction_vec * -2000);
  else
    plate physicslaunchclient(damagelocation, _id_16290C9DDA466BCE * 3);

  wait 8;
  plate delete();
}

_id_C543F8E941150B0B(partname, meansofdeath, damagelocation, objweapon) {
  if(!istrue(self._id_2713FD656D03D0CE))
    return undefined;

  if(isDefined(partname) && partname != "tag_origin" && partname != "" && partname != "none")
    return partname;
  else if(isexplosivedamagemod(meansofdeath)) {
    dir = vectorNormalize((damagelocation - self.origin) * (1, 1, 0));
    fwd = anglestoright(self.angles);
    dot = vectordot(dir, fwd);
    pos = [];

    if(dot > 0) {
      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_15");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_12");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_07");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_14");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_08");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_17");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;
    } else if(dot < 0) {
      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_05");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_11");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_19");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_18");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_13");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_16");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;
    }

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_01");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_02");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_06");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_F60270B9450BE387 = scripts\engine\utility::get_array_of_closest(damagelocation, pos, undefined, undefined, 250, 0);

    if(_id_F60270B9450BE387.size) {
      if(distancesquared(damagelocation, _id_F60270B9450BE387[0].origin) < squared(100)) {
        if(isDefined(self._id_63739B0CC782E9E0) && isDefined(self._id_63739B0CC782E9E0[_id_F60270B9450BE387[0].tagname]) && self._id_63739B0CC782E9E0[_id_F60270B9450BE387[0].tagname] >= self._id_9D21E843B2A359CE)
          return undefined;

        return _id_F60270B9450BE387[0].tagname;
      }
    }
  }

  return undefined;
}

_id_8A52A8AAB7E2B441(tagname) {
  if(self tagexists(tagname)) {
    info = spawnStruct();
    info.origin = self gettagorigin(tagname);
    info.tagname = tagname;
    return info;
  }

  return undefined;
}

_id_CCB8C9DF533B4C57(amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon) {
  if(isexplosivedamagemod(meansofdeath)) {
    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      if(issubstr(objweapon.basename, "gromeo"))
        self._id_C939463D099534D4 = self._id_C939463D099534D4 + 1;
      else if(issubstr(objweapon.basename, "papa7"))
        self._id_F21375AF7E927B7F = self._id_F21375AF7E927B7F + 1;
      else if(issubstr(objweapon.basename, "mike32"))
        self._id_45148BB6235DA900 = self._id_45148BB6235DA900 + 1;

      if(self._id_C939463D099534D4 >= 2 || self._id_F21375AF7E927B7F >= 3 || self._id_45148BB6235DA900 >= 5) {
        if(!istrue(self.godmode))
          self.health = 0;
      }
    }
  }
}