/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_sandstorm_code.gsc
***************************************************/

_id_6485() {
  if(!isDefined(level._id_6485)) {
    level._id_6485 = 0;
  }
  return level._id_6485;
}

_id_5C02() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

_id_5C03() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

_id_6486(var_0, var_1, var_2) {
  if(isDefined(level._id_6487) && level._id_6487) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 10;
  }
  maps\_audio::aud_send_msg("sandstorm_" + var_0);

  switch (var_0) {
    case "light":
      _id_5698::_id_567C(var_1);
      break;
    case "medium":
      _id_5698::_id_567D(var_1);
      wait 5;
      maps\payback_util::_id_6488(3);
      break;
    case "hard":
      _id_5698::_id_567E(var_1);
      break;
    case "blackout":
      _id_5698::_id_5684(var_1);
      break;
    case "extreme":
      if(isDefined(var_2)) {
        _id_5698::_id_567F(var_1, var_2);
      } else {
        _id_5698::_id_567F(var_1);
      }
      maps\payback_util::_id_6488(0);
      setsaveddvar("r_fog_depthhack_scale", 0.5);
      break;
    case "aftermath":
      _id_5698::_id_5685(var_1);
      break;
    case "none":
      _id_5698::_id_567A(var_1);
      break;
  }
}

_id_6489() {
  self endon("sandstorm_vehicle_delete");
  maps\_vehicle::_id_2B17();
  self waittill("death");
  maps\_vehicle::_id_2B18("all");
}

_id_5387(var_0) {
  var_1 = "TAG_INHAND";
  self._id_5386 = spawn("script_model", self.origin);
  var_2 = self._id_5386;
  var_2.owner = self;
  var_2.origin = self gettagorigin(var_1);
  var_2.angles = self gettagangles(var_1);
  var_2 setModel("com_flashlight_on");
  var_2 linkto(self, var_1);
  var_3 = "tag_light";
  var_4 = level._effect["lights_flashlight_sandstorm"];
  playFXOnTag(var_4, var_2, var_3);
  thread _id_538A(var_0, var_4, var_2, var_3);
  common_scripts\utility::waittill_any("death", "remove_flashlight");
  wait 0.1;
  var_2 delete();
}

_id_538A(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("remove_flashlight");

  for(;;) {
    level waittill(var_0);
    self notify("remove_flashlight");
    var_2 setModel("com_flashlight_off");
    stopFXOnTag(var_1, var_2, var_3);
    wait 0.1;
  }
}

_id_648A() {
  if(isDefined(self)) {
    self._id_648B = "tag_weapon_right";
    self._id_648C = level._effect["lights_flashlight_sandstorm_offset"];
    playFXOnTag(self._id_648C, self, self._id_648B);
    thread _id_648E();
  }
}

_id_648D() {
  if(isDefined(self) && isDefined(self._id_648B) && isDefined(self._id_648C)) {
    stopFXOnTag(self._id_648C, self, self._id_648B);
    self._id_648C = undefined;
    self._id_648B = undefined;
  }
}

_id_648E() {
  self notify("flashlight_off_on_death");
  self endon("flashlight_off_on_death");
  common_scripts\utility::waittill_any("death", "flashlight_off_delayed");

  if(isDefined(self._id_648F)) {
    wait(self._id_648F);
  } else {
    wait 0.75;
  }
  _id_648D();
}