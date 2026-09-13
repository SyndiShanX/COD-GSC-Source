/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_610f57bddd265be2.gsc
***********************************************/

main() {
  level thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  waitframe();

  if(!getdvarint("redeploy_ascenders_enabled", 0)) {
    return;
  }
  init();
}

init() {
  _id_C592E91FC6604AD0();
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_D01754FC00A031F4);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("redeploy_drone_interact", ::_id_F0567CDA220A6F7D);

  if(level._id_FC4BB27A820F54DD._id_1BB94B0F20FB3532) {
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("redeploy_drone", ::_id_FB714D8704F1953A);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("redeploy_drone", ::_id_9858FB14DDBABACF);
  }

  scripts\cp_mp\utility\script_utility::registersharedfunc("redeploy_drone", "precision_airstrike_death", ::_id_69D9C14BE9E002A3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("redeploy_drone", "get_closest_redeploy_drone", ::_id_5B25002784B94F0B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("redeploy_drone", "dropbag_collision_watcher", ::_id_056CB0FE5CC33EFE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "handleWorldCollision", ::_id_19E2FE45E130973F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_palfa", "handleWorldCollision", ::_id_19E2FE45E130973F);
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("eqp_redeploy_drone");
  level thread _id_023F7ACAAB482446();
}

#using_animtree("scriptables");

_id_C592E91FC6604AD0() {
  level._id_FC4BB27A820F54DD = spawnStruct();
  level._id_FC4BB27A820F54DD._id_5103BC8AADF9AF64 = getdvarint("dvar_27F51798E10E62A0", 4);
  level._id_FC4BB27A820F54DD._id_1131F855E49656BF = getdvarint("dvar_2AF4EFAAFAE6489B", 270);
  level._id_FC4BB27A820F54DD._id_43C609D0BF76CEDC = getdvarint("dvar_FC06CF8B2E6FF7C8", 100);
  level._id_FC4BB27A820F54DD._id_3BC74411A49EF743 = getdvarint("dvar_4D3F3DDCF9C9AE8F", 2000);
  level._id_FC4BB27A820F54DD._id_94CA860762F3C07B = getdvarint("dvar_2044315C6A32E0CF", 512);
  level._id_FC4BB27A820F54DD._id_F94808AF4ADDFA87 = getdvarint("dvar_3D4C3C323E772733", 50);
  level._id_FC4BB27A820F54DD._id_F96AF6AF4B041AA9 = getdvarint("dvar_3D7052323E9FD24D", 150);
  level._id_FC4BB27A820F54DD._id_4B39BA581F4E16EF = getdvarint("dvar_59AB4E81308F5BFB", 42);
  level._id_FC4BB27A820F54DD._id_73610DF6CB8260E6 = getdvarint("dvar_019BB495FC007952", 3);
  level._id_FC4BB27A820F54DD._id_4B2CDACF483DCCC4 = getdvarfloat("dvar_0590A91E3623C94D", 4.0);
  level._id_FC4BB27A820F54DD._id_AB77BCFBF6EC9587 = getdvarint("dvar_3CD8F7500C4CFFCB", 30);
  level._id_FC4BB27A820F54DD._id_7E1E2DEB54381DCE = getdvarint("dvar_07A6046AF43F645A", 10);
  level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04 = getdvarint("dvar_67144A280E505EB0", 10);
  level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5 = getdvarint("dvar_0E0052F554FB1D69", 50);
  level._id_FC4BB27A820F54DD._id_1BB94B0F20FB3532 = getdvarint("dvar_B81D9B0920A22A50", 0) && getdvarint("scr_ssc_enabled", 0);
  _id_E375F6BD7E1961C9 = getdvarint("dvar_9BD3724F70106775", 9000);
  level._id_FC4BB27A820F54DD._id_D1343ED4C5B69716 = squared(_id_E375F6BD7E1961C9);
  _id_D961317263B789A2 = getdvarint("dvar_59C137234DAD4AD6", 7000);
  level._id_FC4BB27A820F54DD._id_08A13BE89E30D617 = squared(_id_D961317263B789A2);
  level._id_FC4BB27A820F54DD._id_F06709293DD563E6 = getdvarint("dvar_898325E4EE88D57F", 2000);
  level._id_FC4BB27A820F54DD._id_9A279E924352BE3B = getdvarint("dvar_019F16B7BFEA9D46", 3000);
  level._id_FC4BB27A820F54DD._id_B24B7A96D6C8E3C8 = getdvarint("dvar_BA0B665C109648FD", 45000);
  level._id_FC4BB27A820F54DD._id_2EB08138D7D6EE45 = getanimlength(%veh9_mil_air_drone_redeploy_extend_hook_01);
  level._id_FC4BB27A820F54DD._id_8A066943BB13715F = getanimlength(%veh9_mil_air_drone_redeploy_retract_hook_01);
  level._id_FC4BB27A820F54DD._id_1C9F02381DCB3A4C = [];
  level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C = getentitylessscriptablearray("scriptable_scriptable_redeploy_drone", "classname");
  level._id_FC4BB27A820F54DD._id_F92270E010A8D104 = getentitylessscriptablearray("redeploy_drone_relocate", "script_noteworthy");
  level._id_FC4BB27A820F54DD._id_C6BE6BFBFAA2F523 = getentitylessscriptablearray("redeploy_drone_spawn", "script_noteworthy");
  level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E = level._id_FC4BB27A820F54DD._id_C6BE6BFBFAA2F523;
  level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3 = 1;

  if(isDefined(level.br_level) && isDefined(level.br_level.c130_speedoverride))
    level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3 = level.br_level.c130_speedoverride / 3044;

  level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B = [];
}

_id_FB714D8704F1953A() {
  return getentitylessscriptablearray("redeploy_drone_spawn", "script_noteworthy");
}

_id_023F7ACAAB482446() {
  waitframe();
  _id_22627CFD727F11C3();

  while(!isDefined(level.br_ac130))
    wait 0.05;

  level notify("respawn_redeploy_drones");
  level thread _id_4418403E6587197C();
  level thread _id_C4F705B1E3E908DE();
}

_id_22627CFD727F11C3() {
  if(!level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E.size) {
    return;
  }
  _id_AA6C956FA42C8DFD();

  if(!level._id_FC4BB27A820F54DD._id_1BB94B0F20FB3532) {
    _id_4255350C89E0FECB();

    foreach(scriptable in level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E)
    scriptable _id_5A9C3FCB3FDCC242();
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E.size; _id_AC0E594AC96AA3A8++) {
    if(level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E[_id_AC0E594AC96AA3A8] getscriptablepartstate("redeploy_drone") != "available") {
      level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E = scripts\engine\utility::array_remove(level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E, level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E[_id_AC0E594AC96AA3A8]);
      _id_AC0E594AC96AA3A8--;
    }
  }
}

_id_9858FB14DDBABACF(_id_BFBBCA1BB1C06680) {
  _id_BFBBCA1BB1C06680 _id_5A9C3FCB3FDCC242();
  _id_A61C75B156FC1EE0 = level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E.size;
  level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E[_id_A61C75B156FC1EE0] = _id_BFBBCA1BB1C06680;
  return _id_BFBBCA1BB1C06680;
}

_id_5A9C3FCB3FDCC242() {
  _id_CA6EA48C877CD367();
  self setscriptablepartstate("redeploy_drone_sfx", "engine_idle_sfx");
  self setscriptablepartstate("redeploy_drone_vfx", "enabled");
  _id_81ACD562E1D05436();
  scripts\mp\weapons::_id_E00B77A9CB4D8322(self);

  if(getdvarint("dvar_94CC2E00DC85444B", 1) && !isDefined(self.temp)) {
    drone = spawn("script_model", self.origin);
    drone setModel("veh9_mil_air_drone_redeploy_relocate_hack");
    drone.angles = self.angles;
    drone.speed = 0;
    drone forcenetfieldhighlod(1);
    drone._id_52BB96DB5D8EC81B = self;
    self.temp = drone;
  }
}

_id_4418403E6587197C() {
  level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B = scripts\engine\utility::array_removeundefined(level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B.size; _id_AC0E594AC96AA3A8++) {
    drone = level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B[_id_AC0E594AC96AA3A8];
    level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B = scripts\engine\utility::array_remove(level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B, drone);
    drone delete();
    _id_AC0E594AC96AA3A8--;
  }

  level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B = undefined;

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    scriptable _id_7FA5478ED150D979();

    if(getdvarint("dvar_94CC2E00DC85444B", 1) && isDefined(self.temp)) {
      if(isDefined(scriptable.temp))
        scriptable.temp delete();
    }
  }

  if(!level._id_FC4BB27A820F54DD._id_1BB94B0F20FB3532 && _id_362C58E8BB39BCDA::isfeatureenabled("circleEarlyStart"))
    _id_4255350C89E0FECB();

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E) {
    if(getdvarint("dvar_8CC1035EE7514C26", 1)) {
      scriptable thread _id_0105F0CAAA61E873();
      continue;
    }

    scriptable _id_5A9C3FCB3FDCC242();
  }
}

_id_4255350C89E0FECB() {
  _id_A26E1F7AE26E56DC = scripts\engine\utility::array_randomize(level._id_FC4BB27A820F54DD._id_C6BE6BFBFAA2F523);
  _id_767801E3C9D8E2D5 = scripts\mp\flags::gameflag("prematch_done");
  level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E = [];
  _id_E88FB483D3DA40E9 = 0;

  foreach(scriptable in _id_A26E1F7AE26E56DC) {
    if(_id_E88FB483D3DA40E9 >= level._id_FC4BB27A820F54DD._id_5103BC8AADF9AF64) {
      continue;
    }
    if(_id_767801E3C9D8E2D5 && scriptable _id_E745A94784401DFB()) {
      continue;
    }
    _id_7C6A1A7581E76AFC = 1;

    foreach(other in _id_A26E1F7AE26E56DC) {
      if(other getscriptablepartstate("redeploy_drone") != "available") {
        continue;
      }
      if(distance2dsquared(scriptable.origin, other.origin) > level._id_FC4BB27A820F54DD._id_D1343ED4C5B69716) {
        continue;
      }
      _id_7C6A1A7581E76AFC = 0;
      break;
    }

    if(_id_7C6A1A7581E76AFC) {
      level._id_FC4BB27A820F54DD._id_5715BE6CA445D02E[_id_E88FB483D3DA40E9] = scriptable;
      _id_E88FB483D3DA40E9++;
    }
  }
}

_id_CC4A3E17D7BEC89C() {
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_3C590C0EE220B1D6 = level.mapcorners[1].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[0].origin[1];
  _id_9F3D56FF7B8DE6BC = anglesToForward(level.br_ac130.angles) * -1;
  _id_14B0893F906B0201 = (_id_3C590D0EE220B409 - self.origin[0]) / _id_9F3D56FF7B8DE6BC[0];
  _id_C2BB2AB2A7F5A762 = (_id_C978C90E8E5AB1F7 - self.origin[0]) / _id_9F3D56FF7B8DE6BC[0];
  _id_2E632DCACA182CFB = (_id_3C590C0EE220B1D6 - self.origin[1]) / _id_9F3D56FF7B8DE6BC[1];
  _id_CE3DC05D719B04A3 = (_id_C978C80E8E5AAFC4 - self.origin[1]) / _id_9F3D56FF7B8DE6BC[1];
  t = -1;

  if(_id_14B0893F906B0201 > 0 && (t < 0 || _id_14B0893F906B0201 < t))
    t = _id_14B0893F906B0201;

  if(_id_C2BB2AB2A7F5A762 > 0 && (t < 0 || _id_C2BB2AB2A7F5A762 < t))
    t = _id_C2BB2AB2A7F5A762;

  if(_id_2E632DCACA182CFB > 0 && (t < 0 || _id_2E632DCACA182CFB < t))
    t = _id_2E632DCACA182CFB;

  if(_id_CE3DC05D719B04A3 > 0 && (t < 0 || _id_CE3DC05D719B04A3 < t))
    t = _id_CE3DC05D719B04A3;

  if(t >= 0) {
    t = t + distance2d(self.origin, level.br_ac130.origin);
    _id_29D9C7428185493C = self.origin[0] + t * _id_9F3D56FF7B8DE6BC[0];
    _id_29D9C84281854B6F = self.origin[1] + t * _id_9F3D56FF7B8DE6BC[1];
    _id_6300D0F047679B46 = level.br_ac130.origin[2];
    return (_id_29D9C7428185493C, _id_29D9C84281854B6F, _id_6300D0F047679B46);
  }

  return undefined;
}

_id_0105F0CAAA61E873() {
  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  _id_6C968331812BF02D = _id_CC4A3E17D7BEC89C();

  if(!isDefined(_id_6C968331812BF02D)) {
    _id_BCEF23E599E4CC3C = vectordot(anglestoright(level.br_ac130.angles), vectorNormalize(self.origin - level.br_ac130.origin));
    _id_6C968331812BF02D = level.br_ac130.origin + anglesToForward(level.br_ac130.angles) * -1 * (distance(level.br_ac130.origin, self.origin) - 40000) + anglestoright(level.br_ac130.angles) * 15000 * _id_BCEF23E599E4CC3C;
  }

  _id_57318A9F25CEE67D = 100;
  _id_570E949F25A8B4C3 = scripts\cp_mp\parachute::getc130height() - 4000;
  _id_5731809F25CED07F = _id_57318A9F25CEE67D + _id_570E949F25A8B4C3 / 2;
  _id_FE7278BC3929329E = (_id_570E949F25A8B4C3 - _id_57318A9F25CEE67D) / 2;
  _id_3B7468ECD13AD07B = vectordot(anglesToForward(level.br_ac130.angles), vectorNormalize(_id_6C968331812BF02D - level.br_ac130.origin));
  _id_BFFF077AEC6DC176 = _id_5731809F25CED07F + _id_FE7278BC3929329E * _id_3B7468ECD13AD07B;
  _id_6C968331812BF02D = _id_6C968331812BF02D + (0, 0, -1 * _id_BFFF077AEC6DC176);
  drone = spawn("script_model", _id_6C968331812BF02D);
  drone setModel("veh9_mil_air_drone_redeploy_relocate");
  drone.angles = vectortoangles(self.origin - drone.origin);
  drone.speed = level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5 * 5 * level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3;
  drone.health = level._id_FC4BB27A820F54DD._id_1131F855E49656BF;
  drone setCanDamage(1);
  drone forcenetfieldhighlod(1);
  drone thread _id_6D9358D777958A1B(self);
  drone thread _id_53A07930F4FC0E08(self);
  drone thread _id_0314CDFB5C5633B1();

  while(!isDefined(drone._id_3B4FEE20D214BD9B) || !isDefined(drone._id_F44262DAAB1A384A)) {
    if(drone.health <= 0) {
      return;
    }
    wait 0.05;
  }

  drone notify("relocation_complete");
  self.health = drone.health;
  drone delete();
  _id_CDC6AA9C291D7B94();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_CA6EA48C877CD367();
  thread _id_7F00C76550370A80();
}

_id_AA6C956FA42C8DFD() {
  _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_aiclip", "physicscontents_water"]);

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    trace = scripts\engine\trace::ray_trace(scriptable.origin, scriptable.origin + (0, 0, -3000), undefined, _id_1BFA180C6FDD09DD, 1, 1, 0);
    scriptable._id_E02F90C16D8AE6D5 = trace["surfacetype"];
    scriptable._id_7A6430BA88C4D983 = trace["position"];
  }
}

_id_CA6EA48C877CD367() {
  self setscriptablepartstate("redeploy_drone", "available");
  self._id_264EFAAD635372B2 = 1;
  self._id_E6E9CD1C8C90BF03 = 1;
  _id_0F252B4DE7806249 = spawnscriptable("scriptable_redeploy_drone_anchor_impact", self._id_7A6430BA88C4D983);
  waitframe();

  switch (self._id_E02F90C16D8AE6D5) {
    case "surftype_gravel":
    case "surftype_concrete_dry":
    case "surftype_brick":
    case "surftype_asphalt_dry":
    case "surftype_metal_thick":
      _id_0F252B4DE7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_concrete");
      break;
    case "surftype_sand":
    case "surftype_dirt":
    case "surftype_grass_short":
      _id_0F252B4DE7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_dirt");
      break;
    case "surftype_water_waist":
    case "surftype_water":
      _id_0F252B4DE7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_water");
      break;
  }

  waitframe();
  _id_0F252B4DE7806249 freescriptable();
}

_id_7FA5478ED150D979() {
  self setscriptablepartstate("redeploy_drone", "unavailable");
  self._id_264EFAAD635372B2 = 0;
  scripts\mp\weapons::_id_1A33BD42949CCBDA(self);

  if(getdvarint("dvar_94CC2E00DC85444B", 1) && isDefined(self.temp)) {
    if(isDefined(self.temp))
      self.temp delete();
  }
}

_id_5DFECA0161AFE5F7(usable) {
  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    if(usable) {
      scriptable enablescriptableplayeruse(self);
      continue;
    }

    scriptable disablescriptableplayeruse(self);
  }
}

_id_E745A94784401DFB() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 0;

  return _id_58F20490049AF6AC::_id_03E0A90B32E551AD(self.origin) <= 0;
}

_id_CDC6AA9C291D7B94() {
  scripts\mp\weapons::_id_E00B77A9CB4D8322(self);
  thread _id_B366B00D0743A5CE();

  if(getdvarint("dvar_94CC2E00DC85444B", 1) && !isDefined(self.temp)) {
    drone = spawn("script_model", self.origin);
    drone setModel("veh9_mil_air_drone_redeploy_relocate_hack");
    drone.angles = self.angles;
    drone.speed = 0;
    drone forcenetfieldhighlod(1);
    drone._id_52BB96DB5D8EC81B = self;
    self.temp = drone;
  }

  self setscriptablepartstate("redeploy_drone", "deploy");
  wait(level._id_FC4BB27A820F54DD._id_2EB08138D7D6EE45);
}

_id_B366B00D0743A5CE() {
  _id_B366B00D0743A5CE = spawnscriptable("scriptable_redeploy_drone_deploy", self.origin);
  wait 0.8;
  _id_B366B00D0743A5CE freescriptable();
}

_id_EA7450D7DC038C68() {
  self setscriptablepartstate("redeploy_drone", "retract");
  wait(level._id_FC4BB27A820F54DD._id_8A066943BB13715F - 0.7);
  self setscriptablepartstate("redeploy_drone_cable_sfx", "retract_stop");
  wait 0.7;
}

_id_81ACD562E1D05436() {
  self.health = level._id_FC4BB27A820F54DD._id_1131F855E49656BF;
  self.maxhealth = level._id_FC4BB27A820F54DD._id_1131F855E49656BF;
}

_id_D01754FC00A031F4(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isDefined(instance) || !isDefined(instance.classname) || instance.classname != "scriptable_scriptable_redeploy_drone") {
    return;
  }
  if(idamage < 2) {
    return;
  }
  if(shitloc[2] < instance.origin[2] - 100) {
    return;
  }
  if(isPlayer(eattacker))
    eattacker _id_5762AC2F22202BA2::updatehitmarker("standard", instance.health == 0, 0, 1, "hitequip");
  else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
    eattacker.owner _id_5762AC2F22202BA2::updatehitmarker("standard", instance.health == 0, 0, 1, "hitequip");

  vehicleowner = undefined;

  if(isDefined(eattacker.model) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" || eattacker.model == "veh9_mil_air_heli_medium_vehphys_mp") {
    vehicleowner = eattacker.owner;
    level thread _id_CF65FBC1C077FADB(eattacker, instance.origin);
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
    idamage = int(idamage * level._id_FC4BB27A820F54DD._id_4B2CDACF483DCCC4);

  if(isDefined(einflictor) && isDefined(einflictor.model) && einflictor.model == "ks_airstrike_target_br_ch3")
    idamage = level._id_FC4BB27A820F54DD._id_71BA1DDBE86CAB15;

  instance.health = instance.health - idamage;

  if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "toma_proj_mp")
    instance.health = 0;

  if(instance.health <= 0) {
    level thread _id_3BB995471AE6723A(instance);

    if(isDefined(vehicleowner))
      instance _id_492FA39D6A4DF6DE(vehicleowner, einflictor.model);
    else
      instance _id_492FA39D6A4DF6DE(eattacker, einflictor.model);
  }
}

_id_492FA39D6A4DF6DE(eattacker, modelname, _id_AAE73B7B727DB0C4) {
  self setscriptablepartstate("redeploy_drone", "unavailable");
  self setscriptablepartstate("redeploy_drone_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_cable_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_anchor_sfx", "disabled");
  scripts\mp\weapons::_id_1A33BD42949CCBDA(self);
  self._id_264EFAAD635372B2 = 0;
  self notify("redeploy_drone_destroyed");

  if(istrue(_id_AAE73B7B727DB0C4)) {
    if(getdvarint("dvar_94CC2E00DC85444B", 1) && isDefined(self) && isDefined(self.temp))
      self.temp delete();

    _id_6D23AA882F67A716(eattacker);
    return;
  }

  drone = spawn("script_model", self.origin);
  drone setModel("veh9_mil_air_drone_redeploy_relocate");
  drone.angles = self.angles;
  drone.speed = 0;
  scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);

  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3")
    eattacker._id_9A5AED1448C04687++;

  drone.owner = eattacker;
  drone _id_E47FAE0AB5C70A88(self);
}

_id_E47FAE0AB5C70A88(_id_5C5B88CE7AE1228E) {
  level endon("game_ended");
  waitframe();

  if(getdvarint("dvar_94CC2E00DC85444B", 1) && isDefined(_id_5C5B88CE7AE1228E) && isDefined(_id_5C5B88CE7AE1228E.temp))
    _id_5C5B88CE7AE1228E.temp delete();

  self setscriptablepartstate("redeploy_drone_relocation_smoke_vfx", "enabled");
  self physics_registerforcollisioncallback();
  thread _id_026AACBD66AB5C92();
  self waittill("collision");
  _id_6D23AA882F67A716();
  wait 0.2;
  scripts\mp\weapons::_id_1A33BD42949CCBDA(self);
  self delete();
}

_id_026AACBD66AB5C92() {
  level endon("game_ended");
  self endon("collision");
  self endon("entitydeleted");
  _id_94517BE0A50D041F = (0, 0, 0);

  if(isDefined(self._id_DDB39E78F356F112))
    _id_94517BE0A50D041F = vectorNormalize(self._id_DDB39E78F356F112 - self.origin);

  self physics_takecontrol(1, self.origin, _id_94517BE0A50D041F * self.speed * 1500);
  _id_AC0E594AC96AA3A8 = level._id_FC4BB27A820F54DD._id_43C609D0BF76CEDC;
  x = randomfloatrange(_id_AC0E594AC96AA3A8 / 2, _id_AC0E594AC96AA3A8);
  x = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), x, x * -1);
  y = randomfloatrange(_id_AC0E594AC96AA3A8 / 2, _id_AC0E594AC96AA3A8);
  y = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), y, y * -1);
  z = randomfloatrange(_id_AC0E594AC96AA3A8 / 10, _id_AC0E594AC96AA3A8 / 5);
  z = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), z, z * -1);
  self physics_applyimpulse(self.origin + (randomintrange(-50, 51), randomintrange(-50, 51), randomintrange(-50, 51)), (x, y, z));

  for(;;) {
    _id_D5CDF67A50A74A7A = anglesToForward(self.angles) * randomfloatrange(-1 * level._id_FC4BB27A820F54DD._id_3BC74411A49EF743, level._id_FC4BB27A820F54DD._id_3BC74411A49EF743);
    _id_983148E6D0C8D005 = anglestoright(self.angles) * randomfloatrange(-1 * level._id_FC4BB27A820F54DD._id_3BC74411A49EF743, level._id_FC4BB27A820F54DD._id_3BC74411A49EF743);
    _id_9A1F339B9A782980 = anglestoup(self.angles) * randomfloat(level._id_FC4BB27A820F54DD._id_3BC74411A49EF743);
    self physics_applyimpulse(self.origin + (randomintrange(-50, 51), randomintrange(-50, 51), randomintrange(-50, 51)), _id_D5CDF67A50A74A7A + _id_983148E6D0C8D005 + _id_9A1F339B9A782980);
    wait 0.05;
  }
}

_id_6D23AA882F67A716(eattacker) {
  vfx = spawnscriptable("scriptable_redeploy_drone_explosion", self.origin);
  waitframe();

  if(!isDefined(eattacker) && isDefined(self.owner))
    eattacker = self.owner;

  radiusdamage(self.origin, level._id_FC4BB27A820F54DD._id_94CA860762F3C07B, level._id_FC4BB27A820F54DD._id_F96AF6AF4B041AA9, level._id_FC4BB27A820F54DD._id_F94808AF4ADDFA87, eattacker, "MOD_EXPLOSIVE");
  vfx freescriptable();
}

_id_CF65FBC1C077FADB(attacker, _id_254F9C6C23AD6894) {
  wait 0.15;

  if(scripts\mp\utility\player::isreallyalive(attacker))
    attacker dodamage(9999, _id_254F9C6C23AD6894);
}

_id_F0567CDA220A6F7D(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player thread _id_EA7DDF2DEFB7947A(instance);
  player thread _id_1B9A6266F1942FAC(instance);
}

_id_EA7DDF2DEFB7947A(instance) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  instance endon("death");
  level thread _id_715028F54BAD19A1::_id_E77F36370162406C(self);
  _id_B3D3238C9BC3D1A5 = squared(19);

  while(distance2dsquared(self.origin, instance.origin) > _id_B3D3238C9BC3D1A5)
    waitframe();

  while(distance2dsquared(self.origin, instance.origin) < _id_B3D3238C9BC3D1A5)
    waitframe();

  self notify("redeploy_drone_launch");
  thread _id_B4D6206C99452CAC();
  thread _id_D52AE9FC3100CECF();
}

_id_B4D6206C99452CAC() {
  level endon("game_ended");
  self setclientomnvar("ui_br_altimeter_state", 2);

  while(isDefined(self)) {
    if(self isskydiving()) {
      self waittill("skydive_end");
      break;
    } else {
      _id_AA4F5EA34DFE428B = istrue(self.inlaststand);
      _id_D4BA664E8CDD1E0A = isDefined(self.ffsm_state) && (self.ffsm_state == 5 || self.ffsm_state == 6 || self.ffsm_state == 3);
      _id_31C5DAC60B438208 = self isonground() || self _meth_E40102956C887F7C() || self _meth_415FE9EECA7B2E2B();
      _id_A2B5F51A86D266AD = self isonladder();
      _id_D6442D18B46A7A10 = self _meth_9CC921A57FF4DEB5();
      _id_B48E997E59346E83 = !scripts\cp_mp\utility\player_utility::isreallyalive(self);
      binvehicle = self _meth_793F941D7DFF15ED();

      if(_id_AA4F5EA34DFE428B || _id_D4BA664E8CDD1E0A || _id_31C5DAC60B438208 || _id_A2B5F51A86D266AD || _id_D6442D18B46A7A10 || _id_B48E997E59346E83 || binvehicle) {
        break;
      } else
        waitframe();
    }
  }

  if(isDefined(self))
    self setclientomnvar("ui_br_altimeter_state", 0);
}

_id_D52AE9FC3100CECF() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(!self isonground()) {
    _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(self.origin, level._id_FC4BB27A820F54DD._id_F06709293DD563E6, undefined, level._id_FC4BB27A820F54DD._id_9A279E924352BE3B);
    _id_55B4FA124C5108FF = self.team;

    foreach(targetplayer in _id_78122E18403A8DC4) {
      _id_8B1B7044E27E6A56 = _id_55B4FA124C5108FF == targetplayer.team;

      if(_id_8B1B7044E27E6A56) {
        continue;
      }
      _id_CDA71AEC07AAB082 = !scripts\mp\utility\player::isreallyalive(targetplayer) || istrue(targetplayer.inlaststand);

      if(_id_CDA71AEC07AAB082) {
        continue;
      }
      _id_744496CCCBBFCB78 = targetplayer isparachuting() || targetplayer isinfreefall();

      if(_id_744496CCCBBFCB78) {
        continue;
      }
      time = gettime();
      _id_008EDFF54C680323 = isDefined(targetplayer.heardparachuteoverheadtime) && time - targetplayer.heardparachuteoverheadtime < level._id_FC4BB27A820F54DD._id_B24B7A96D6C8E3C8;

      if(_id_008EDFF54C680323) {
        continue;
      }
      targetplayer.heardparachuteoverheadtime = time;
      _id_95CE4F91D0F58568 = _id_2CEDCC356F1B9FC8::brgetoperatorteam(targetplayer);

      if(!isDefined(_id_95CE4F91D0F58568))
        _id_95CE4F91D0F58568 = "allies";

      _id_7570AFA45D86040F = game["voice"][_id_95CE4F91D0F58568];
      targetplayer queuedialogforplayer(level.activeparachutersfactionvo[_id_7570AFA45D86040F], "respawning_enemy_in_area", 2);
    }

    waitframe();
  }
}

_id_1B9A6266F1942FAC(instance) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("redeploy_drone_launch");
  instance waittill("redeploy_drone_destroyed");
  self _meth_61195B9EE307AD14();
}

_id_C4F705B1E3E908DE() {
  level endon("game_ended");
  level waittill("br_circle_set");

  while(level.br_circle.circleindex != level._id_FC4BB27A820F54DD._id_73610DF6CB8260E6)
    wait(level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04);

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    if(scriptable getscriptablepartstate("redeploy_drone") == "available" || scriptable getscriptablepartstate("redeploy_drone") == "deploy" || scriptable getscriptablepartstate("redeploy_drone") == "retract") {
      scriptable thread _id_BFA2960787851BA9();
      wait(randomintrange(5, 10));
    }
  }
}

_id_3BB995471AE6723A(_id_A97C8133FBA1E58A) {
  level endon("game_ended");
  level endon("respawn_redeploy_drones");
  _id_CCD641F9100F73F8 = _id_A97C8133FBA1E58A.origin;
  wait(level._id_FC4BB27A820F54DD._id_4B39BA581F4E16EF);
  _id_DAAD7D20D7A17C02 = undefined;
  _id_9225DFDB20269B5A = undefined;

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    if(isDefined(_id_A97C8133FBA1E58A) && scriptable == _id_A97C8133FBA1E58A) {
      continue;
    }
    if(istrue(scriptable._id_264EFAAD635372B2)) {
      continue;
    }
    if(istrue(scriptable._id_E6E9CD1C8C90BF03)) {
      continue;
    }
    if(scriptable getscriptablepartstate("redeploy_drone") == "available" || scriptable getscriptablepartstate("redeploy_drone") == "deploy" || scriptable getscriptablepartstate("redeploy_drone") == "retract") {
      continue;
    }
    if(scriptable _id_E745A94784401DFB()) {
      continue;
    }
    if(scriptable _id_77E61741CC59C806()) {
      continue;
    }
    _id_7319DF2BD443C913 = distance2dsquared(_id_CCD641F9100F73F8, scriptable.origin);

    if(!isDefined(_id_9225DFDB20269B5A) || _id_7319DF2BD443C913 < _id_9225DFDB20269B5A) {
      _id_9225DFDB20269B5A = _id_7319DF2BD443C913;
      _id_DAAD7D20D7A17C02 = scriptable;
    }
  }

  if(!isDefined(_id_DAAD7D20D7A17C02)) {
    return;
  }
  _id_DAAD7D20D7A17C02._id_264EFAAD635372B2 = 1;
  _id_DAAD7D20D7A17C02._id_E6E9CD1C8C90BF03 = 1;

  if(isDefined(_id_A97C8133FBA1E58A))
    _id_A97C8133FBA1E58A._id_264EFAAD635372B2 = 0;

  _id_9602B340166DCDD7 = _id_2695A20D4011076D::getsafecircleorigin();
  _id_A4233C478EBA62A0 = _id_CCD641F9100F73F8 + vectorNormalize(_id_CCD641F9100F73F8 - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], _id_CCD641F9100F73F8[2])) * 20000;
  _id_7C645B23074DCDDA = vectortoangles(_id_CCD641F9100F73F8 - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], _id_CCD641F9100F73F8[2]));
  drone = spawn("script_model", _id_A4233C478EBA62A0);
  drone setModel("veh9_mil_air_drone_redeploy_relocate");
  drone.angles = _id_7C645B23074DCDDA;
  drone.speed = 0;
  drone _id_81ACD562E1D05436();
  drone setCanDamage(1);
  drone forcenetfieldhighlod(1);
  scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);

  if(isDefined(level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B))
    level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B[level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B.size] = drone;

  drone thread _id_6D9358D777958A1B(_id_DAAD7D20D7A17C02);
  drone thread _id_53A07930F4FC0E08(_id_DAAD7D20D7A17C02);
  drone thread _id_0314CDFB5C5633B1(undefined, _id_DAAD7D20D7A17C02);
  drone thread _id_BB75B8CFBAA352CE(_id_DAAD7D20D7A17C02);

  while(!isDefined(drone._id_3B4FEE20D214BD9B) || !isDefined(drone._id_F44262DAAB1A384A)) {
    if(drone.health <= 0) {
      return;
    }
    wait 0.05;
  }

  drone notify("relocation_complete");
  _id_DAAD7D20D7A17C02.health = drone.health;

  if(isDefined(level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B))
    level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B = scripts\engine\utility::array_remove(level._id_FC4BB27A820F54DD._id_8DFC726E5B63525B, drone);

  scripts\mp\weapons::_id_1A33BD42949CCBDA(drone);
  drone delete();
  _id_DAAD7D20D7A17C02 _id_CDC6AA9C291D7B94();

  if(_id_DAAD7D20D7A17C02 getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_DAAD7D20D7A17C02 _id_CA6EA48C877CD367();
  _id_DAAD7D20D7A17C02 thread _id_7F00C76550370A80();
}

_id_5B25002784B94F0B(_id_254F9C6C23AD6894) {
  return sortbydistance(level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C, _id_254F9C6C23AD6894)[0];
}

_id_69D9C14BE9E002A3(owner) {
  wait 0.3;

  if(isDefined(self) && isDefined(self._id_52BB96DB5D8EC81B)) {
    if(self._id_52BB96DB5D8EC81B.health <= 0)
      owner._id_9A5AED1448C04687++;
  } else if(!isDefined(self) || self.health <= 0)
    owner._id_9A5AED1448C04687++;
}

_id_056CB0FE5CC33EFE() {
  self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  _id_320408384DD779EA = _id_5B25002784B94F0B(position);

  if(isDefined(_id_320408384DD779EA) && distancesquared(position, _id_320408384DD779EA.origin) < squared(150)) {
    level thread _id_3BB995471AE6723A(_id_320408384DD779EA);
    _id_320408384DD779EA _id_492FA39D6A4DF6DE(self.owner, undefined, 1);
  }
}

_id_19E2FE45E130973F(position) {
  _id_320408384DD779EA = _id_5B25002784B94F0B(position);

  if(isDefined(_id_320408384DD779EA) && distancesquared(position, _id_320408384DD779EA.origin) < squared(150)) {
    level thread _id_3BB995471AE6723A(_id_320408384DD779EA);
    _id_320408384DD779EA _id_492FA39D6A4DF6DE(self.owner, undefined, 1);
  }
}

_id_2AD170B9D70C7062() {}

_id_7F00C76550370A80() {
  level endon("game_ended");

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }
  _id_B88F8ECD6F2078C3 = _id_58F20490049AF6AC::_id_03E0A90B32E551AD(self.origin);

  if(_id_B88F8ECD6F2078C3 > 0) {
    wait(_id_B88F8ECD6F2078C3);

    if(self getscriptablepartstate("redeploy_drone") == "unavailable")
      return;
  }

  thread _id_B49EC1763C49A840();
}

_id_B49EC1763C49A840() {
  level endon("game_ended");
  _id_42DE8ECD1B474886 = scripts\engine\utility::ter_op(isDefined(level.br_circle.circleindex), level.br_circle.circleindex, 0);
  _id_85698BD598B163F0 = level._id_FC4BB27A820F54DD._id_AB77BCFBF6EC9587 - level._id_FC4BB27A820F54DD._id_7E1E2DEB54381DCE * _id_42DE8ECD1B474886;

  if(_id_85698BD598B163F0 < level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04)
    _id_85698BD598B163F0 = level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04;

  wait(_id_85698BD598B163F0);

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_DAAD7D20D7A17C02 = undefined;
  _id_9225DFDB20269B5A = undefined;

  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    if(istrue(scriptable._id_264EFAAD635372B2)) {
      continue;
    }
    if(scriptable getscriptablepartstate("redeploy_drone") == "available" || scriptable getscriptablepartstate("redeploy_drone") == "deploy" || scriptable getscriptablepartstate("redeploy_drone") == "retract") {
      continue;
    }
    if(scriptable _id_E745A94784401DFB()) {
      continue;
    }
    if(scriptable _id_77E61741CC59C806()) {
      continue;
    }
    _id_7319DF2BD443C913 = distance2dsquared(self.origin, scriptable.origin);

    if(!isDefined(_id_9225DFDB20269B5A) || _id_7319DF2BD443C913 < _id_9225DFDB20269B5A) {
      _id_9225DFDB20269B5A = _id_7319DF2BD443C913;
      _id_DAAD7D20D7A17C02 = scriptable;
    }
  }

  if(!isDefined(_id_DAAD7D20D7A17C02)) {
    thread _id_BFA2960787851BA9();
    return;
  }

  _id_DAAD7D20D7A17C02._id_264EFAAD635372B2 = 1;
  _id_DAAD7D20D7A17C02._id_E6E9CD1C8C90BF03 = 1;
  _id_EA7450D7DC038C68();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  self setscriptablepartstate("redeploy_drone_cable_sfx", "retract_stop");
  _id_7FA5478ED150D979();
  drone = spawn("script_model", self.origin);
  drone setModel("veh9_mil_air_drone_redeploy_relocate");
  drone.angles = self.angles;
  drone.speed = 0;
  drone.health = self.health;
  drone setCanDamage(1);
  drone forcenetfieldhighlod(1);
  scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);
  drone thread _id_6D9358D777958A1B(_id_DAAD7D20D7A17C02);
  drone thread _id_53A07930F4FC0E08(_id_DAAD7D20D7A17C02);
  drone thread _id_0314CDFB5C5633B1(self, _id_DAAD7D20D7A17C02);
  drone thread _id_BB75B8CFBAA352CE(_id_DAAD7D20D7A17C02);

  while(!isDefined(drone._id_3B4FEE20D214BD9B) || !isDefined(drone._id_F44262DAAB1A384A)) {
    if(drone.health <= 0) {
      return;
    }
    wait 0.05;
  }

  drone notify("relocation_complete");
  _id_DAAD7D20D7A17C02.health = drone.health;
  scripts\mp\weapons::_id_1A33BD42949CCBDA(drone);
  drone delete();
  _id_DAAD7D20D7A17C02 _id_CDC6AA9C291D7B94();

  if(_id_DAAD7D20D7A17C02 getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_DAAD7D20D7A17C02 _id_CA6EA48C877CD367();
  _id_DAAD7D20D7A17C02 thread _id_7F00C76550370A80();
}

_id_BFA2960787851BA9() {
  level endon("game_ended");
  _id_42DE8ECD1B474886 = scripts\engine\utility::ter_op(isDefined(level.br_circle.circleindex), level.br_circle.circleindex, 0);
  _id_85698BD598B163F0 = level._id_FC4BB27A820F54DD._id_AB77BCFBF6EC9587 - level._id_FC4BB27A820F54DD._id_7E1E2DEB54381DCE * _id_42DE8ECD1B474886;

  if(_id_85698BD598B163F0 < level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04)
    _id_85698BD598B163F0 = level._id_FC4BB27A820F54DD._id_B09E88FF96D15C04;

  wait(_id_85698BD598B163F0);

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_10B874AA4BB07A07 = spawnStruct();

  if(istrue(level._id_2DF69B8E552238B6))
    _id_9602B340166DCDD7 = level.br_level.br_circlecenters[level.br_circle.circleindex + 1];
  else
    _id_9602B340166DCDD7 = _id_2695A20D4011076D::getsafecircleorigin();

  _id_10B874AA4BB07A07.origin = self.origin + vectorNormalize(self.origin - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], self.origin[2])) * 20000;
  _id_10B874AA4BB07A07.angles = vectortoangles(self.origin - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], self.origin[2]));
  _id_EA7450D7DC038C68();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }
  _id_7FA5478ED150D979();
  drone = spawn("script_model", self.origin);
  drone setModel("veh9_mil_air_drone_redeploy_relocate");
  drone.angles = self.angles;
  drone.speed = 0;
  drone.health = self.health;
  drone forcenetfieldhighlod(1);
  drone thread _id_6D9358D777958A1B(_id_10B874AA4BB07A07);
  drone thread _id_53A07930F4FC0E08(_id_10B874AA4BB07A07);
  drone thread _id_0314CDFB5C5633B1(self);
  drone thread _id_BB75B8CFBAA352CE();

  while(!isDefined(drone._id_3B4FEE20D214BD9B) || !isDefined(drone._id_F44262DAAB1A384A)) {
    if(drone.health <= 0) {
      return;
    }
    wait 0.05;
  }

  drone notify("relocation_complete");
  drone delete();
}

_id_BB75B8CFBAA352CE(_id_DAAD7D20D7A17C02) {
  self endon("entitydeleted");
  self endon("relocation_complete");

  for(;;) {
    self waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isPlayer(eattacker))
      eattacker _id_5762AC2F22202BA2::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
    else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
      eattacker.owner _id_5762AC2F22202BA2::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");

    if(isDefined(eattacker.model) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" || eattacker.model == "veh9_mil_air_heli_medium_vehphys_mp")
      level thread _id_CF65FBC1C077FADB(eattacker, self.origin);

    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
      idamage = int(idamage * level._id_FC4BB27A820F54DD._id_4B2CDACF483DCCC4);

    if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3")
      idamage = level._id_FC4BB27A820F54DD._id_71BA1DDBE86CAB15;

    self.health = self.health - idamage;

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "toma_proj_mp")
      self.health = 0;

    if(self.health <= 0) {
      level thread _id_3BB995471AE6723A(self);
      _id_D0250169E6DFA8E4(eattacker, modelname);

      if(isDefined(_id_DAAD7D20D7A17C02))
        _id_DAAD7D20D7A17C02._id_264EFAAD635372B2 = 0;

      return;
    }
  }
}

_id_D0250169E6DFA8E4(eattacker, modelname) {
  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3")
    eattacker._id_9A5AED1448C04687++;

  self.owner = eattacker;
  _id_E47FAE0AB5C70A88();
}

_id_77E61741CC59C806() {
  foreach(scriptable in level._id_FC4BB27A820F54DD._id_CD2DE8814A52F22C) {
    if(scriptable == self) {
      continue;
    }
    if(istrue(scriptable._id_264EFAAD635372B2)) {
      if(distance2dsquared(self.origin, scriptable.origin) < level._id_FC4BB27A820F54DD._id_08A13BE89E30D617)
        return 1;
    }
  }

  return 0;
}

_id_6D9358D777958A1B(_id_DAAD7D20D7A17C02) {
  level endon("game_ended");
  self endon("entitydeleted");
  self._id_DDB39E78F356F112 = _id_DAAD7D20D7A17C02.origin;
  self._id_CFFC989CEC7D81FF = 0;

  while(self.speed < level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5) {
    self.speed = self.speed + 1;

    if(self.speed > level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5)
      self.speed = level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5;

    self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), 0.05, 0, 0);
    wait 0.05;
  }

  if(self.speed > level._id_FC4BB27A820F54DD._id_73E374CE21FB4FB5) {
    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > squared(self.speed * 20 * level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3)) {
      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");
    self._id_CFFC989CEC7D81FF = 1;

    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > 0.01) {
      self moveTo(self.origin + (self._id_DDB39E78F356F112 - self.origin) * 0.05 / level._id_FC4BB27A820F54DD._id_CCD62F7F63FB25B3, 0.05, 0, 0);
      self.speed = self.speed * 0.95;
      wait 0.05;
    }
  } else {
    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > 250000) {
      self moveTo(self.origin + self.speed * vectorNormalize(self._id_DDB39E78F356F112 - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");
    self._id_CFFC989CEC7D81FF = 1;

    while(distancesquared(self.origin, self._id_DDB39E78F356F112) > 0.01) {
      self moveTo(self.origin + (self._id_DDB39E78F356F112 - self.origin) * 0.1, 0.05, 0, 0);
      self.speed = self.speed * 0.9;
      wait 0.05;
    }
  }

  self moveTo(self._id_DDB39E78F356F112, 0.05, 0, 0);
  wait 0.05;
  self.speed = 0;
  self._id_DDB39E78F356F112 = undefined;
  self._id_3B4FEE20D214BD9B = 1;
}

_id_53A07930F4FC0E08(_id_DAAD7D20D7A17C02) {
  level endon("game_ended");
  self endon("entitydeleted");
  _id_B082D9FE8938E33D = vectorNormalize(_id_DAAD7D20D7A17C02.origin - self.origin);
  _id_0DA83F385E7E33E1 = vectortoangles(_id_B082D9FE8938E33D)[1] - self.angles[1];

  if(_id_0DA83F385E7E33E1 < -180)
    _id_0DA83F385E7E33E1 = _id_0DA83F385E7E33E1 + 360;

  if(_id_0DA83F385E7E33E1 > 180)
    _id_0DA83F385E7E33E1 = _id_0DA83F385E7E33E1 - 360;

  _id_3B7468ECD13AD07B = vectordot(_id_B082D9FE8938E33D, anglesToForward(self.angles));
  _id_BCEF23E599E4CC3C = vectordot(_id_B082D9FE8938E33D, anglestoright(self.angles));
  _id_4D03BEB0293B1B14 = abs(_id_0DA83F385E7E33E1);
  _id_0BE553A9CE54D449 = _id_4D03BEB0293B1B14 - 90;

  if(_id_0BE553A9CE54D449 > 0) {
    _id_039FB5D4CA8578C6 = _id_0BE553A9CE54D449 / _id_4D03BEB0293B1B14;
    self rotateby((30 * _id_3B7468ECD13AD07B + 15.0, _id_0DA83F385E7E33E1 * _id_039FB5D4CA8578C6, 30 * _id_BCEF23E599E4CC3C), _id_0BE553A9CE54D449 * 0.025, _id_0BE553A9CE54D449 / 2 * 0.025, 0);
    wait(_id_0BE553A9CE54D449 * 0.025);
    _id_452972B9D736DFD6 = _id_4D03BEB0293B1B14 - _id_0BE553A9CE54D449;
    self rotateTo((30, vectortoangles(_id_B082D9FE8938E33D)[1], 0), _id_452972B9D736DFD6 * 0.025, 0, _id_452972B9D736DFD6 / 2 * 0.025);
    wait(_id_452972B9D736DFD6 * 0.025);
  } else {
    _id_3B290CB32F6FC162 = _id_4D03BEB0293B1B14 / 2 * 0.025;

    if(_id_3B290CB32F6FC162 < 1)
      _id_3B290CB32F6FC162 = 1;

    self rotateby((15.0 * _id_3B7468ECD13AD07B, _id_0DA83F385E7E33E1 / 2, 15.0 * _id_BCEF23E599E4CC3C), _id_3B290CB32F6FC162, _id_3B290CB32F6FC162 / 2, 0);
    wait(_id_3B290CB32F6FC162);
    self rotateTo((30, vectortoangles(_id_B082D9FE8938E33D)[1], 0), _id_3B290CB32F6FC162, 0, _id_3B290CB32F6FC162 / 2);
    wait(_id_3B290CB32F6FC162);
  }

  if(!istrue(self._id_CFFC989CEC7D81FF))
    self waittill("redeploy_drone_arrive");

  _id_0DA83F385E7E33E1 = _id_DAAD7D20D7A17C02.angles[1] - self.angles[1];

  if(_id_0DA83F385E7E33E1 < -180)
    _id_0DA83F385E7E33E1 = _id_0DA83F385E7E33E1 + 360;

  if(_id_0DA83F385E7E33E1 > 180)
    _id_0DA83F385E7E33E1 = _id_0DA83F385E7E33E1 - 360;

  _id_3B7468ECD13AD07B = vectordot(anglesToForward(self.angles), anglesToForward(_id_DAAD7D20D7A17C02.angles));
  _id_BCEF23E599E4CC3C = vectordot(anglestoright(self.angles), anglesToForward(_id_DAAD7D20D7A17C02.angles));
  _id_3B290CB32F6FC162 = 1.0;
  self rotateby((-30 * _id_3B7468ECD13AD07B - 30, _id_0DA83F385E7E33E1 / 2, 30 * _id_BCEF23E599E4CC3C), _id_3B290CB32F6FC162, _id_3B290CB32F6FC162 / 2, 0);
  wait(_id_3B290CB32F6FC162);
  self rotateTo((0, _id_DAAD7D20D7A17C02.angles[1], 0), _id_3B290CB32F6FC162, 0, _id_3B290CB32F6FC162 / 2);
  wait(_id_3B290CB32F6FC162);
  self._id_F44262DAAB1A384A = 1;
}

_id_0314CDFB5C5633B1(_id_76BFD75CCAB42A13, _id_359E64E7A629DD94) {
  self endon("entitydeleted");
  wait 1;
  self setscriptablepartstate("redeploy_drone_relocation_sfx", "relocation_loop");

  if(isDefined(_id_76BFD75CCAB42A13))
    _id_76BFD75CCAB42A13 setscriptablepartstate("redeploy_drone_sfx", "disabled");

  self waittill("redeploy_drone_arrive");

  if(isDefined(_id_359E64E7A629DD94)) {
    _id_359E64E7A629DD94 setscriptablepartstate("redeploy_drone_sfx", "relocation_sfx_end");
    wait 0.5;
    _id_359E64E7A629DD94 setscriptablepartstate("redeploy_drone_sfx", "engine_idle_sfx");
  }

  self setscriptablepartstate("redeploy_drone_relocation_sfx", "relocation_end");
}