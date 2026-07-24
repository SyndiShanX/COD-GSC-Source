/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3081.gsc
**************************************/

_id_97F9() {
  self._id_71A1 = ::_id_5673;
  self._id_719D = ::_id_4D6D;
  _id_0A15::setupdestructibledoors();
}

_id_4D6D(var_0) {
  var_1 = 0;

  switch (var_0.partname) {
    case "hip_pack_left":
    case "hip_pack_right":
    case "torso":
    case "head":
      return;
    case "right_arm":
    case "left_arm":
      var_1 = 1;
      break;
  }

  _id_0A0B::_id_98C9(var_0.partname);

  if(self._blackboard.scriptableparts[var_0.partname].state == "dismember") {
    return;
  }
  var_2 = "dmg_" + var_0.subpartname;
  var_3 = 0;

  if(var_1) {
    if(self._blackboard.scriptableparts[var_0.partname].state == "dmg_upper" || self._blackboard.scriptableparts[var_0.partname].state == "dmg_lower")
      var_3 = 1;
  }

  if(var_3)
    self _meth_847D(var_0.partname);
  else {
    _id_0A0B::_id_F592(var_0.partname, var_2);

    if(var_1 && var_0.subpartname == "upper" && self._id_13CC3[strtok(var_0.partname, "_")[0]] == "rocket")
      _id_0C47::_id_10907();
  }
}

_id_5673(var_0) {
  var_1 = 1;

  switch (var_0.partname) {
    case "left_arm":
      _id_5668();
      break;
    case "right_arm":
      _id_5675();
      break;
    case "left_leg":
      _id_566A();
      break;
    case "right_leg":
      _id_5677();
      break;
    case "hip_pack_left":
      _id_5669();
      var_1 = 0;
      break;
    case "hip_pack_right":
      _id_5676();
      var_1 = 0;
      break;
    case "head":
      _id_5666();
      break;
    case "torso":
      return;
    default:
      return;
  }

  if(isDefined(self._id_C925) && isDefined(self._id_C925[var_0.partname])) {
    self._id_C925[var_0.partname] delete();
    self._id_C925 = scripts\sp\utility::_id_22B2(self._id_C925, var_0.partname);
  }

  self notify(var_0.partname + "_dismembered");

  if(self getthreatbiasgroup() != "c12" && (issubstr(var_0.partname, "arm") || issubstr(var_0.partname, "leg")))
    thread _id_6620();

  _id_5674(var_0.partname, var_1);
}

_id_5674(var_0, var_1) {
  _id_0A0B::_id_98C9(var_0);

  if(_id_0A0B::_id_7C35(var_0) == "dismember") {
    return;
  }
  if(isDefined(self.bt._id_55CF)) {
    return;
  }
  var_2 = 0.25;

  if(var_0 == "head")
    var_2 = 0;

  thread _id_0A0B::_id_F592(var_0, "dismember", var_2);
  _id_0A0B::_id_F6C9(var_0);
  thread _id_3544(var_0);

  if(isDefined(self.bt._id_55CE)) {
    return;
  }
  if(var_1)
    scripts\asm\asm::asm_setstate("dismember");
}

_id_5666() {
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  playrumbleonposition("light_1s", self gettagorigin("j_neck"));
}

_id_5668() {
  var_0 = "left";

  if(self._id_13CC3[var_0] == "rocket" && isDefined(self._id_E601))
    self._id_E601 delete();

  _id_0A05::_id_3555(var_0, 0);
  scripts\asm\asm_bb::bb_setcanrodeo(var_0);

  if(getdvarint("c12_slowturn"))
    _id_0A05::_id_3609(0.05);

  if(_id_9D45("left_arm"))
    _id_5678();

  playrumbleonposition("light_1s", self gettagorigin("j_clavicle_le"));
}

_id_5675() {
  var_0 = "right";

  if(self._id_13CC3[var_0] == "rocket" && isDefined(self._id_E601))
    self._id_E601 delete();

  _id_0A05::_id_3555(var_0, 0);
  scripts\asm\asm_bb::bb_setcanrodeo(var_0);

  if(getdvarint("c12_slowturn"))
    _id_0A05::_id_3609(0.05);

  if(_id_9D45("right_arm"))
    _id_5678();

  playrumbleonposition("light_1s", self gettagorigin("j_clavicle_ri"));
}

_id_566A() {
  if(_id_9D45("left_leg"))
    _id_5678();

  playrumbleonposition("light_1s", self gettagorigin("j_mainroot2"));
}

_id_5677() {
  if(_id_9D45("right_leg"))
    _id_5678();

  playrumbleonposition("light_1s", self gettagorigin("j_mainroot2"));
}

_id_5669() {}

_id_5676() {}

_id_9E23(var_0) {
  return 0;
}

_id_9D45(var_0) {
  var_1 = ["left_arm", "right_arm", "left_leg", "right_leg"];
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);

  foreach(var_3 in var_1) {
    if(scripts\asm\asm_bb::ispartdismembered(var_3))
      return 1;
  }

  return 0;
}

_id_5678() {
  scripts\asm\asm_bb::bb_setselfdestruct(1);

  if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "enemy_hill_intro_c12")
    _id_0A05::_id_3634("c12AchievementSelfdestruct");
}

_id_6620() {
  var_0 = level.player getthreatbiasgroup();

  if(!threatbiasgroupexists("c12"))
    createthreatbiasgroup("c12");

  if(!threatbiasgroupexists("player"))
    createthreatbiasgroup("player");

  self setthreatbiasgroup("c12");
  level.player setthreatbiasgroup("player");
  setthreatbias("player", "c12", 99999);
  self waittill("death");

  if(var_0 != "")
    level.player setthreatbiasgroup(var_0);
  else
    level.player setthreatbiasgroup();
}

_id_3544(var_0) {
  if(var_0 == "right_arm" || var_0 == "left_arm")
    self playSound("c12_dismember_arm");

  if(var_0 == "right_leg" || var_0 == "left_leg")
    self playSound("c12_dismember_leg");
}