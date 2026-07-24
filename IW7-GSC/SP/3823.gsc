/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3823.gsc
**************************************/

_id_E3AD() {
  level._id_74B1 = _id_95EF();
  level._id_74B0 = _id_95EE();
  _id_95F1();
}

_id_95F1() {
  level._id_74B2 = _id_8172();
  _id_95F0();
}

_id_95F0() {
  switch (level.script) {
    case "shipcrib_moon":
      _id_F9DF();
      break;
    case "shipcrib_europa":
      _id_F964();
      break;
    case "shipcrib_titan":
      _id_FA64();
      break;
    case "shipcrib_gravity":
      _id_F991();
      break;
    case "shipcrib_rogue":
      _id_FA2B();
      break;
    case "shipcrib_prisoner":
      _id_FA21();
      break;
    default:
      break;
  }
}

_id_F9DF() {
  _id_F933();
}

_id_F964() {
  _id_F933();
}

_id_FA64() {
  _id_F933();
}

_id_F991() {
  _id_15B0(["jackal_bay_2", "jackal_bay_3"], "nitrogen");
  _id_15B0(["jackal_bay_2"], "air");
  _id_15B0(["dropship_bay_2"], "nitrogen");
  _id_15B0(["dropship_bay_1"], "air");
  _id_15B0(["dropship_bay_1"], "gasoline");
}

_id_FA2B() {
  _id_F933();
}

_id_FA21() {
  _id_F933();
}

_id_F933() {}

_id_95EE() {
  var_0 = [];
  var_0["activate_gasoline"] = ::_id_CD21;
  var_0["activate_nitrogen"] = ::_id_CDAF;
  var_0["activate_air"] = ::_id_CC75;
  var_0["deactivate_gasoline"] = ::_id_CD20;
  var_0["deactivate_nitrogen"] = ::_id_CDAE;
  var_0["deactivate_air"] = ::_id_CC74;
  return var_0;
}

_id_CDAF() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_attach"), self._id_65F7, "tag_origin");
  self._id_65F7 moveTo(self._id_65F7.origin + (0, 0, 64), 5, 0.5, 0.5);
  scripts\engine\utility::noself_delaycall(5, ::stopfxontag, scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_attach"), self._id_65F7, "tag_origin");
}

_id_CDAE() {
  self._id_65F7 moveTo(self._id_65F7.origin + (0, 0, -64), 5, 0.5, 0.5);
}

_id_CD21() {
  self._id_65F7 rotatepitch(-180, 2.5, 0.5, 0);
}

_id_CD20() {
  self._id_65F7 rotatepitch(180, 2.5, 0.5, 0);
}

_id_CC75() {
  self._id_65F7 rotatepitch(-90, 2.5, 0.5, 0);
}

_id_CC74() {
  self._id_65F7 rotatepitch(90, 2.5, 0.5, 0);
}

_id_95EF() {
  level._effect["vfx_sc_liquid_nitrogen_ground_closed"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_liquid_nitrogen_ground_closed.vfx");
  level._effect["vfx_sc_liquid_nitrogen_ground_creep"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_liquid_nitrogen_ground_creep.vfx");
  level._effect["vfx_sc_liquid_nitrogen_attach"] = loadfx("vfx/iw7/levels/ship_crib/global/vfx_sc_liquid_nitrogen_attach.vfx");
  var_0 = [];
  var_0["gasoline"] = ::_id_CD22;
  var_0["nitrogen"] = ::_id_CDB0;
  var_0["air"] = ::_id_CC76;
  return var_0;
}

_id_CD22() {}

_id_CDB0() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_ground_closed"), self._id_8625, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_ground_creep"), self._id_8625, "tag_origin");
  self waittill("stopfx");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_ground_creep"), self._id_8625, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_ground_closed"), self._id_8625, "tag_origin");
}

_id_CC76() {}

_id_8172() {
  var_0 = getEntArray("fuelstation", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      if(!isDefined(var_1[var_3.script_noteworthy]))
        var_1[var_3.script_noteworthy] = [];

      var_4 = _id_9853(var_3);
      var_1[var_3.script_noteworthy] = scripts\engine\utility::array_add(var_1[var_3.script_noteworthy], var_4);
    }
  }

  return var_1;
}

_id_9853(var_0) {
  var_1 = spawnStruct();
  var_1.isactive = 0;
  var_1.location = var_0.script_noteworthy;
  var_1.ent = var_0;
  var_1._id_CBFB = scripts\engine\utility::getStruct(var_0.target, "targetname");

  if(var_0.script_parameters == "gasoline" || var_0.script_parameters == "nitrogen" || var_0.script_parameters == "air")
    var_1._id_E8F5 = var_0.script_parameters;
  else {}

  if(isDefined(var_0.script_index))
    var_1.number = var_0.script_index;
  else
    var_1.number = 0;

  if(var_0.script_parameters == "nitrogen") {
    var_1._id_8625 = scripts\engine\utility::spawn_tag_origin(var_1._id_CBFB.origin, var_1._id_CBFB.angles);
    playFXOnTag(scripts\engine\utility::getfx("vfx_sc_liquid_nitrogen_ground_closed"), var_1._id_8625, "tag_origin");
  }

  var_1._id_65F7 = scripts\engine\utility::spawn_tag_origin(var_1._id_CBFB.origin, var_1._id_CBFB.angles);
  var_1.ent linkTo(var_1._id_65F7, "tag_origin");
  var_1._id_4389 = getEnt(var_1._id_CBFB.target, "targetname");
  var_1._id_4389 linkTo(var_1._id_65F7, "tag_origin");
  return var_1;
}

_id_5156(var_0) {
  var_0.ent unlink();
  var_0._id_4389 unlink();
  var_0._id_65F7 delete();
}

_id_15B0(var_0, var_1, var_2) {
  _id_3C42(::_id_1587, var_0, var_1, var_2);
}

_id_4DB6(var_0, var_1, var_2) {
  _id_3C42(::deactivate, var_0, var_1, var_2);
}

_id_3C42(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = getarraykeys(level._id_74B2);

  if(!isDefined(var_2))
    var_2 = "all";

  if(!isDefined(var_3))
    var_3 = -1;

  foreach(var_5 in var_1) {
    foreach(var_7 in level._id_74B2[var_5]) {
      if(var_7._id_E8F5 == var_2 || var_2 == "all") {
        if(var_7.number == var_3 || var_3 == -1)
          var_7[[var_0]]();
      }
    }
  }
}

_id_1587() {
  var_0 = "activate_";

  if(self.isactive != 1) {
    self thread[[level._id_74B1[self._id_E8F5]]]();
    self thread[[level._id_74B0[var_0 + self._id_E8F5]]]();
  }

  self.isactive = 1;
}

deactivate() {
  var_0 = "deactivate_";

  if(self.isactive != 0) {
    self thread[[level._id_74B0[var_0 + self._id_E8F5]]]();
    self notify("stopfx");
  }

  self.isactive = 0;
}

_id_1589() {
  _id_3C42(::_id_1587);
}

_id_4DA7() {
  _id_3C42(::deactivate);
}

_id_15BF(var_0, var_1) {
  _id_3C43(::_id_1587, var_0, var_1);
}

_id_4DBC(var_0, var_1) {
  _id_3C43(::deactivate, var_0, var_1);
}

_id_3C43(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = "jackal_bay_1";
  var_3[var_3.size] = "jackal_bay_2";
  var_3[var_3.size] = "jackal_bay_3";
  var_3[var_3.size] = "jackal_bay_4";
  _id_3C42(var_0, var_3, var_1, var_2);
}

_id_15A9(var_0, var_1) {
  _id_3C40(::_id_1587, var_0, var_1);
}

_id_4DB2(var_0, var_1) {
  _id_3C40(::deactivate, var_0, var_1);
}

_id_3C40(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = "dropship_bay_1";
  var_3[var_3.size] = "dropship_bay_2";
  _id_3C42(var_0, var_3, var_1, var_2);
}

_id_D905(var_0) {
  foreach(var_2 in var_0) {}
}