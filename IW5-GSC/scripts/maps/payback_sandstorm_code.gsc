/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_sandstorm_code.gsc
***************************************************/

debug_no_heroes() {
  if(!isDefined(level.debug_no_heroes)) {
    level.debug_no_heroes = 0;
  }
  return level.debug_no_heroes;
}

sandstorm_skybox_hide() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

sandstorm_skybox_show() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

set_sandstorm_level(var_0, var_1, var_2) {
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
      maps\payback_util::sandstorm_fx(3);
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
      maps\payback_util::sandstorm_fx(0);
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

handle_vehicle_lights() {
  self endon("sandstorm_vehicle_delete");
  maps\_vehicle::vehicle_lights_on();
  self waittill("death");
  maps\_vehicle::vehicle_lights_off("all");
}

attachflashlight(var_0) {
  var_1 = "TAG_INHAND";
  self.flashlight = spawn("script_model", self.origin);
  var_2 = self.flashlight;
  var_2.owner = self;
  var_2.origin = self gettagorigin(var_1);
  var_2.angles = self gettagangles(var_1);
  var_2 setModel("com_flashlight_on");
  var_2 linkTo(self, var_1);
  var_3 = "tag_light";
  var_4 = level._effect["lights_flashlight_sandstorm"];
  playFXOnTag(var_4, var_2, var_3);
  thread remove_flashlight_on_alert(var_0, var_4, var_2, var_3);
  common_scripts\utility::waittill_any("death", "remove_flashlight");
  wait 0.1;
  var_2 delete();
}

remove_flashlight_on_alert(var_0, var_1, var_2, var_3) {
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

flashlight_on_guy() {
  if(isDefined(self)) {
    self.flashlight_tag = "tag_weapon_right";
    self.flashlight_effect = level._effect["lights_flashlight_sandstorm_offset"];
    playFXOnTag(self.flashlight_effect, self, self.flashlight_tag);
    thread flashlight_off_on_death();
  }
}

flashlight_off_guy() {
  if(isDefined(self) && isDefined(self.flashlight_tag) && isDefined(self.flashlight_effect)) {
    stopFXOnTag(self.flashlight_effect, self, self.flashlight_tag);
    self.flashlight_effect = undefined;
    self.flashlight_tag = undefined;
  }
}

flashlight_off_on_death() {
  self notify("flashlight_off_on_death");
  self endon("flashlight_off_on_death");
  common_scripts\utility::waittill_any("death", "flashlight_off_delayed");

  if(isDefined(self._id_648F)) {
    wait(self._id_648F);
  } else {
    wait 0.75;
  }
  flashlight_off_guy();
}