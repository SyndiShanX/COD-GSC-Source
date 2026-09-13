/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e98854f9b382903.gsc
***********************************************/

_id_78B690F869D12A6B() {
  level.astar_node_radius_override = 4;
  level._id_9DEF439B33EAC09D = 0;
  level._id_0AC33444DF3B5F6B = 4;
  level._id_E769257BA0EA53F7 = -4;
  level._id_42F0B59A6CEC2E6A = 384;
  level._id_79078C13B4EC1A27 = 20;
  level._id_B3F7B3933168C3EF = 512;
  level.active_drones = [];
  level thread _id_021787630BBEE2A4::init();
}

_id_821C4C54FE8593F0() {
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("drone_spawn", "script_noteworthy");
  count = 0;

  while(count < 5 || level.active_drones.size < 5) {
    struct = scripts\engine\utility::random(_id_9E4E1482CB40C9C5);
    drone = _id_021787630BBEE2A4::_id_CB2C1DF00BD5E191(struct);
    level.active_drones[level.active_drones.size] = drone;
    drone thread _id_9BBD8D7CFD8F8502();
    drone setneargoalnotifydist(50);
    count++;
    wait 0.5;
  }
}

_id_9BBD8D7CFD8F8502() {
  self waittill("death");
  level.active_drones = scripts\engine\utility::array_remove(level.active_drones, self);
}

_id_D2A65B03426B7D2B(_id_B563ECCFC453F4C0) {
  self endon("death");
  self.goalradius = 16;
  self._id_8FFF9E977E206515 = 1;
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::getStruct("boss_attack_drone", "targetname");

  while(self._id_49C575DAEAE1E60B > 2)
    wait 0.1;

  self setgoalpos(_id_0C3EA9B1A20FF199.origin);

  while(distance(self.origin, self getclosestreachablepointonnavmesh(_id_0C3EA9B1A20FF199.origin)) > 32) {
    if(self._id_49C575DAEAE1E60B > 2)
      self setgoalpos(self.origin);
    else
      self setgoalpos(_id_0C3EA9B1A20FF199.origin);

    wait 0.1;
  }

  self.ignoreall = 1;
  wait 1;
  thread _id_821C4C54FE8593F0();
  wait 0.5;
  self.ignoreall = 0;
  self._id_8FFF9E977E206515 = undefined;
  self.goalradius = 2048;
  self.goalheight = 100;
}