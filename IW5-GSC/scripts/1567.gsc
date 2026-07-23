/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1567.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("ucav", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_ucav");
  level._effect["jettrail"] = loadfx("smoke/jet_contrail");
  maps\_vehicle::build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
}

init_local() {
  thread _id_3E5A();
  self._id_3E59[0] = "tag_missile_left";
  self._id_3E59[1] = "tag_missile_right";
  self.nextmissiletag = 0;
}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  return var_0;
}

_id_3E5A() {
  playFXOnTag(level._effect["jettrail"], self, "TAG_JET_TRAIL");
}

plane_sound_node() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread plane_sound_node();
  var_0 thread maps\_utility::play_sound_on_entity("veh_uav_flyby");
}

_id_3E82() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread _id_3E82();
  var_0 setvehweapon("ucav_sidewinder");
  var_1 = common_scripts\utility::get_linked_ent();
  var_0 fireweapon(var_0._id_3E59[var_0.nextmissiletag], var_1, (0, 0, 0));
  var_0.nextmissiletag++;

  if(var_0.nextmissiletag >= var_0._id_3E59.size) {
    var_0.nextmissiletag = 0;
  }
}