/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\nvg_ai.gsc
***********************************************/

_id_928EDE0FF50C28B9() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(is_using_flashlight())
    kill_flashlight_fx(0);
}

enable_flashlight(enable) {
  if(enable)
    self.flashlightoverride = 1;
  else
    self.flashlightoverride = 0;
}

flashlight_on(_id_B5214D24F3968B4C) {
  if(!can_use_flashlight()) {
    return;
  }
  if(is_using_flashlight()) {
    return;
  }
  self.flashlight = 1;
  play_flashlight_fx();

  if(isDefined(self.flashlightlaserweapon))
    flashlight_laser_on();
}

flashlight_off(_id_B5214D24F3968B4C) {
  if(!is_using_flashlight()) {
    return;
  }
  self.flashlight = 0;
  kill_flashlight_fx();

  if(isDefined(self.flashlightlaserweapon))
    flashlight_laser_off();
}

flashlight_laser_on() {
  if(isDefined(self.flashlightlaser)) {
    return;
  }
  laser = spawn("script_model", (0, 0, 0));
  laser linkTo(self, self.flashlightfxtag, (0, 0, 0), (0, 0, 0));
  laser setModel("tag_laser");
  laser setmoverlaserweapon(self.flashlightlaserweapon);
  self.flashlightlaser = laser;
  thread flashlight_laser_cleanup();
}

flashlight_laser_cleanup() {
  self endon("flashlight_laser_off");
  self waittill("death");
  self.flashlightlaser delete();
}

flashlight_laser_off() {
  if(!isDefined(self.flashlightlaser)) {
    return;
  }
  self notify("flashlight_laser_off");
  self.flashlightlaser delete();
  self.flashlightlaser = undefined;
}

play_flashlight_fx() {
  tag = "tag_flash";

  if(isDefined(self.flashlightfxoverridetag))
    tag = self.flashlightfxoverridetag;

  fx = "3rd_person_flashlight";

  if(isDefined(self.flashlightfxoverride))
    fx = self.flashlightfxoverride;

  self.flashlightfx = fx;
  self.flashlightfxtag = tag;
  playFXOnTag(scripts\engine\utility::getfx(self.flashlightfx), self, self.flashlightfxtag);
}

kill_flashlight_fx() {
  if(scripts\engine\utility::is_equal(self.flashlightfxtag, "tag_flash") || !isDefined(self.flashlightfxtag)) {
    if(isnullweapon(self.weapon))
      return;
  }

  if(isDefined(self.flashlightfx)) {
    tag = "tag_flash";

    if(isDefined(self.flashlightfxtag))
      tag = self.flashlightfxtag;

    killfxontag(scripts\engine\utility::getfx(self.flashlightfx), self, tag);
  }

  self.flashlightfx = undefined;
  self.flashlightfxtag = undefined;
}

is_using_flashlight() {
  if(istrue(self.flashlight))
    return 1;
  else
    return 0;
}

is_using_nvg() {
  if(istrue(self.nvg))
    return 1;
  else
    return 0;
}

can_use_flashlight() {
  if(getdvarint("dvar_2D59DEB63C029EA8", 1) == 1)
    return 0;

  if(isDefined(self.noflashlight) && self.noflashlight)
    return 0;

  if(!isDefined(self.a) || !isDefined(self.a.weaponpos) || isundefinedweapon(self.a.weaponpos["right"]))
    return 0;

  return 1;
}

_id_54C942E3C8DD0485() {
  for(;;) {
    enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");

    foreach(enemy in enemies) {
      if(!enemy istouching(self)) {
        continue;
      }
      if(enemy is_using_flashlight()) {
        continue;
      }
      if(enemy can_use_flashlight()) {
        enemy enable_flashlight(1);
        enemy thread _id_1C2287F78A78B0E5(self);
        enemy thread _id_928EDE0FF50C28B9();
      }
    }

    wait 1;
  }
}

_id_1C2287F78A78B0E5(area) {
  self endon("death");

  for(;;) {
    if(self istouching(area)) {
      wait 1;
      continue;
    }

    break;
  }

  enable_flashlight(0);
}

_id_F697DFEFFEC8B3C1() {
  self.fnstealthflashlighton = ::flashlight_on;
  self.fnstealthflashlightoff = ::flashlight_off;
  enable_flashlight(1);
}

update_vfx_shadow_limit() {
  if(!scripts\engine\utility::flag_exist("infil_complete"))
    scripts\engine\utility::flag_init("infil_complete");

  scripts\engine\utility::flag_wait("infil_complete");
  _id_DFB0AEFD1187603E = 2;

  for(;;) {
    _id_B4F1CF3FBE1A7E76 = getdvarint("sm_spotDistCull");
    ai_array = getaiarray("axis");
    _id_A2EA3D917E7026B7 = 0;

    foreach(player in level.players) {
      foreach(ai in sortbydistance(ai_array, player.origin)) {
        if(distancesquared(ai.origin, player.origin) > _id_B4F1CF3FBE1A7E76 * _id_B4F1CF3FBE1A7E76) {
          break;
        }

        if(istrue(ai.flashlight)) {
          _id_A2EA3D917E7026B7++;

          if(_id_A2EA3D917E7026B7 >= 4) {
            break;
          }
        }
      }
    }

    _id_A2EA3D917E7026B7 = clamp(_id_A2EA3D917E7026B7, 2, 4);

    if(_id_A2EA3D917E7026B7 != _id_DFB0AEFD1187603E) {
      _id_DFB0AEFD1187603E = _id_A2EA3D917E7026B7;
      setDvar("sm_spotUpdateLimitDynLight", _id_DFB0AEFD1187603E);
    }

    waitframe();
  }

  if(_id_DFB0AEFD1187603E != 2)
    setDvar("sm_spotUpdateLimitDynLight", 2);
}