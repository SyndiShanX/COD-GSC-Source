/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3880.gsc
**************************************/

_id_31C5(var_0, var_1) {
  if(!isDefined(level._id_864B)) {
    level._id_864B = [];
    level._id_86AC = 30000;
  }

  level._id_86AB = var_1;
  level._id_86AE = var_0;
  level._id_864B[level._id_86AB] = spawnStruct();
  precacheturret(level._id_86AE);
}

_id_31A6(var_0) {
  level._id_864B[level._id_86AB].init = var_0;
}

_id_3195(var_0) {
  if(!isDefined(var_0._id_6D86) || var_0._id_6D86.size == 0) {}

  level._id_864B[level._id_86AB]._id_6D6E = var_0._id_6D6E;
  level._id_864B[level._id_86AB]._id_32B1 = var_0._id_32B1;
  level._id_864B[level._id_86AB]._id_32B0 = var_0._id_32B0;
  level._id_864B[level._id_86AB]._id_32B4 = var_0._id_32B4;
  level._id_864B[level._id_86AB]._id_32B3 = var_0._id_32B3;
  level._id_864B[level._id_86AB]._id_E31C = var_0._id_E31C;
  level._id_864B[level._id_86AB]._id_E31B = var_0._id_E31B;
  level._id_864B[level._id_86AB]._id_C4BA = var_0._id_C4BA;
  level._id_864B[level._id_86AB]._id_B744 = var_0._id_B744;
  level._id_864B[level._id_86AB]._id_B436 = var_0._id_B436;
  level._id_864B[level._id_86AB]._id_10AA2 = var_0._id_10AA2;
  level._id_864B[level._id_86AB]._id_6D7E = var_0._id_6D7E;
  level._id_864B[level._id_86AB]._id_6D86 = var_0._id_6D86;
}

_id_3180(var_0) {
  level._id_864B[level._id_86AB].maxhealth = var_0.maxhealth;
  level._id_864B[level._id_86AB]._id_4E48 = loadfx(var_0._id_4E48);
  level._id_864B[level._id_86AB]._id_4E63 = var_0._id_4E63;
  level._id_864B[level._id_86AB]._id_4E66 = loadfx(var_0._id_4E66);

  if(isDefined(var_0._id_4E56))
    level._id_864B[level._id_86AB]._id_4E56 = var_0._id_4E56;

  if(isDefined(var_0._id_4E57))
    level._id_864B[level._id_86AB]._id_4E57 = var_0._id_4E57;
}

_id_3199(var_0) {
  if(isDefined(var_0._id_BDFE))
    level._id_864B[level._id_86AB]._id_BDFE = loadfx(var_0._id_BDFE);

  if(isDefined(var_0._id_11A8B))
    level._id_864B[level._id_86AB]._id_11A8B = loadfx(var_0._id_11A8B);

  if(isDefined(var_0._id_6D80))
    level._id_864B[level._id_86AB]._id_6D80 = var_0._id_6D80;

  if(isDefined(var_0._id_3D52))
    level._id_864B[level._id_86AB]._id_3D52 = loadfx(var_0._id_3D52);
}

_id_96F9() {
  var_0 = getEntArray(level._id_86AB, "classname");
  level._id_864B[level._id_86AB].turrets = [];

  foreach(var_2 in var_0)
  var_2 _id_960F();
}

_id_960F() {
  self[[level._id_864B[self.classname].init]]();
  level._id_864B[self.classname].turrets = scripts\engine\utility::array_add(level._id_864B[self.classname].turrets, self);
  self.health = level._id_864B[self.classname].maxhealth + level._id_86AC;
  self setCanDamage(1);
  self.team = self.script_team;
  self._id_1151C = 0.2;
  self.cleanup = [];
  self.targets = [];
  thread _id_0F29::_id_863C();
  thread _id_0F29::_id_863F();
  thread _id_0F29::_id_863E();
  thread _id_0F29::_id_8649();
  self._id_6D85 = 0;
  self._id_9BE2 = 0;
  thread _id_7D26();
}

_id_3184(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "tag_origin";

  level._id_864B[level._id_86AB]._id_4E48 = var_0;
  level._id_864B[level._id_86AB]._id_4E71 = var_0;
}

_id_7D26() {
  wait 1.0;
  var_0 = getEntArray("moon_turret_tower", "targetname");
  var_1 = var_0[0];
  var_2 = -1;

  foreach(var_4 in var_0) {
    var_5 = distance(self.origin, var_4.origin);

    if(var_5 < var_2 || var_2 == -1) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  self._id_11A56 = var_1;
  self._id_102A9 = [];

  if(isDefined(var_1)) {
    var_7 = self._id_11A56 scripts\sp\utility::_id_7A8F();
    self._id_102A9 = var_7;
  }
}

_id_7C9C(var_0) {
  return randomfloatrange(-1 * var_0, var_0);
}