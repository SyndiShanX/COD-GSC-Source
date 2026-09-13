/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_646d60ff2fbd4ff2.gsc
***********************************************/

_id_6AA2E7131056A6A2(pos) {
  chopper = _id_784AA75D4A32FA24::_id_4C4DF9AEB773709A(pos, "veh9_mil_air_heli_medium", "veh9_mil_air_heli_medium_weapons", level._id_0D44040648E9624F, "dmz_patrol_heli");
  chopper._id_59BCC0EE54CDB593 = ::_id_2DA0E1059066956F;
  chopper.funcs["strafe"] = ::_id_F1400B978167AD73;
  chopper._id_902492553F7C3DAF = makeweapon("chopper_gunner_proj_dmz");
  _id_50B058536FB23943 = chopper _id_5BA2582CE376900C("tag_rocket_right");
  _id_50B056536FB234DD = chopper _id_5BA2582CE376900C("tag_rocket_left");
  chopper.turrets = [_id_50B058536FB23943, _id_50B056536FB234DD];
  chopper._id_C8CC9E14CBC6C616 = 5;
  chopper._id_ABEDA157C03DE022 = 40;
  return chopper;
}

_id_5BA2582CE376900C(tag) {
  turret = spawnturret("misc_turret", self gettagorigin(tag), "chopper_support_turret_mp");
  turret setModel("veh9_mil_air_heli_hind_turret_mp");
  turret.owner = self.owner;
  turret.team = self.team;
  turret.angles = self.angles + (90, 0, 0);
  turret.originalangles = turret.angles;
  turret.disabled = 0;
  turret._id_9E50CEF01527FF79 = undefined;
  turret linkTo(self, tag);
  turret setturretteam(self.team);
  turret setturretmodechangewait(0);
  turret setmode("manual");
  return turret;
}

_id_2DA0E1059066956F(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");
  _id_40130BD790669C04 = target.origin;

  for(;;) {
    self setlookatent(target);

    if(!_id_784AA75D4A32FA24::_id_9F656E924A854C1B(target, 5000, 8, randomint(360), 1000)) {
      _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -500);
      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
    }

    if(distance2dsquared(_id_40130BD790669C04, target.origin) > 100000000) {
      _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -800);
      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }
  }
}

_id_F1400B978167AD73(target) {
  wait 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_ABEDA157C03DE022; _id_AC0E594AC96AA3A8++) {
    self.turrets[_id_AC0E594AC96AA3A8 % 2].angles = self.turrets[_id_AC0E594AC96AA3A8 % 2].originalangles + (randomint(10) - 5, randomint(10) - 5, randomint(10) - 5);
    self.turrets[_id_AC0E594AC96AA3A8 % 2] shootturret();
    wait 0.02;
  }
}

_id_EB5FEC1420A757C2(target) {
  _id_46DA84E8CED274E2 = ["tag_rocket_right", "tag_rocket_left"];
  wait 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_C8CC9E14CBC6C616; _id_AC0E594AC96AA3A8++) {
    _id_0429AAE2E6E20F85 = self gettagorigin(_id_46DA84E8CED274E2[_id_AC0E594AC96AA3A8 % 2]) + anglesToForward(self.angles) * 200;
    _id_85FA3CDCB19D2A9C = self gettagorigin(_id_46DA84E8CED274E2[_id_AC0E594AC96AA3A8 % 2]) + anglesToForward(self.angles) * 1000;
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(self._id_902492553F7C3DAF, _id_0429AAE2E6E20F85, _id_85FA3CDCB19D2A9C, self.owner);
    wait 0.3;
  }
}