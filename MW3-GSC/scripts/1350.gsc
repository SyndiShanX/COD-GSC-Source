/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1350.gsc
**************************************/

_id_4068() {
  _id_4069();
}

#using_animtree("generic_human");

_id_4069() {
  level._id_0C59["generic"]["wounded_idle"][0] = % wounded_carry_closet_idle_wounded;
  level._id_0C59["generic"]["pickup_wounded"] = % wounded_carry_pickup_closet_wounded_straight;
  level._id_0C59["generic"]["pickup_carrier"] = % wounded_carry_pickup_closet_carrier_straight;
  level._id_0C59["generic"]["wounded_walk_loop"][0] = % wounded_carry_fastwalk_wounded_relative;
  level._id_0C59["generic"]["carrier_walk_loop"] = % wounded_carry_fastwalk_carrier;
  level._id_0C59["generic"]["putdown_wounded"] = % wounded_carry_putdown_closet_wounded;
  level._id_0C59["generic"]["putdown_carrier"] = % wounded_carry_putdown_closet_carrier;
}

_id_406A(var_0) {
  animscripts\shared::_id_23C8();
  self._id_406B = var_0;
  self._id_406B thread maps\_anim::_id_11C8(self, "wounded_idle", "stop_wounded_idle");
  self.allowdeath = 1;
}

_id_406C(var_0, var_1) {
  level notify("end_carry_ai_logic");
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  var_0.allowpain = 1;
  var_0._id_0EEE = 0;
  var_0.ignoreall = 0;
  var_0.grenadeawareness = 1;
  var_0 maps\_utility::_id_1058(0);
  var_0._id_100A = undefined;
  var_0._id_1099 = undefined;
  var_0._id_117F = undefined;
  var_0._id_1199 = undefined;
  var_0.nododgemove = 0;
  var_0 pushplayer(0);
  var_1 notify("stop_carried_loop");
  var_1 unlink();
  var_0 maps\_utility::_id_26FD();
  var_1._id_406B notify("stop_wounded_idle");
  var_1._id_406B = undefined;
}

_id_406D(var_0, var_1) {
  level endon("end_carry_ai_logic");
  _id_406F(var_0, var_1);
  _id_4071(var_0, var_1);
}

_id_406E(var_0, var_1) {
  var_0 forceteleport(self.origin, self.angles);
  _id_4071(var_0, var_1);
}

_id_406F(var_0, var_1) {
  level endon("end_carry_ai_logic");
  self endon("end_carry_ai");
  var_0._id_406B maps\_anim::_id_11C4(self, "pickup_carrier");
  var_0 notify("stop_wounded_idle");
  var_0._id_406B notify("stop_wounded_idle");
  var_0.allowdeath = 1;
  var_0._id_406B thread maps\_anim::_id_11C1(var_0, "pickup_wounded");
  var_0._id_406B maps\_anim::_id_11C1(self, "pickup_carrier");
  self._id_100A = 1;
  var_0 invisiblenotsolid();
}

_id_4070(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 linkto(self, "tag_origin");
  wait 0.05;
  var_0 thread maps\_anim::_id_11C8(var_0, "wounded_walk_loop", "stop_carried_loop");
}

_id_4071(var_0, var_1) {
  level endon("end_carry_ai_logic");
  self endon("end_carry_ai");
  var_0._id_4072 = 1;
  thread maps\_utility::_id_140B("carrier_walk_loop", 1);
  var_0 notify("stop_wounded_idle");
  var_0._id_406B notify("stop_wounded_idle");
  wait 0.05;
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  self animmode("none");
  self.allowpain = 0;
  self._id_0EEE = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  maps\_utility::_id_1058(1);
  self._id_1099 = 1;
  self._id_117F = 1;
  self._id_1199 = 1;
  self.nododgemove = 1;
  maps\_utility::_id_109E();
  self._id_4073 = self.goalradius;
  thread _id_4070(var_0);

  while(isDefined(var_1.target)) {
    self.ignoresuppression = 1;
    self._id_117F = 1;
    var_2 = getent(var_1.target, "targetname");
    var_2 = common_scripts\utility::ter_op(isDefined(var_2), var_2, getnode(var_1.target, "targetname"));

    if(!isDefined(var_2.target)) {
      var_1 = var_2;
      break;
    }

    self.goalradius = 64;
    self setgoalpos(var_2.origin);
    self waittill("goal");
    var_1 = var_2;
  }

  var_1 maps\_anim::_id_11C4(self, "putdown_carrier");
  var_0._id_406B = var_1;
  var_0 notify("stop_carried_loop");
  var_1 notify("stop_wounded_idle");
  var_0 unlink();
  self.ignoresuppression = 0;
  self._id_117F = 0;
  self.goalradius = self._id_4073;
  thread maps\_utility::_id_140C();
  var_0._id_406B thread maps\_anim::_id_11C1(self, "putdown_carrier");
  var_0._id_406B maps\_anim::_id_11C1(var_0, "putdown_wounded");
  setsaveddvar("ai_friendlyFireBlockDuration", 2000);
  self.allowpain = 1;
  self._id_0EEE = 0;
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  maps\_utility::_id_1058(0);
  self._id_100A = undefined;
  self._id_1099 = undefined;
  self._id_117F = undefined;
  self._id_1199 = undefined;
  self.nododgemove = 0;
  self pushplayer(0);
  var_0 visiblesolid();
  var_0._id_406B thread maps\_anim::_id_11C8(var_0, "wounded_idle", "stop_wounded_idle");
  var_0.allowdeath = 1;
  var_0 notify("stop_putdown");
  var_0._id_4072 = undefined;
}