/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_transit_bus.csc
***********************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\_music;

bus_spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
  }
}

#using_animtree("zombie_bus_props");

init_props_animtree() {
  scriptmodelsuseanimtree(#animtree);
}

#using_animtree("zombie_bus");

init_animtree() {
  scriptmodelsuseanimtree(#animtree);
}

bus_interior_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
}

bus_flashing_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.flashinglights))
    self.flashinglights = [];

  if(newval) {
    if(isDefined(self.flashinglights[localclientnum]))
      stopfx(localclientnum, self.flashinglights[localclientnum]);

    self.flashinglights[localclientnum] = playfxontag(localclientnum, level._effect["fx_emergencylight"], self, "tag_flashing_lights");
  } else if(isDefined(self.flashinglights[localclientnum])) {
    stopfx(localclientnum, self.flashinglights[localclientnum]);
    self.flashinglights[localclientnum] = undefined;
  }
}

bus_head_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.headlights))
    self.headlights = [];

  if(!isDefined(self.headlights[localclientnum]))
    self.headlights[localclientnum] = spawnstruct();

  if(newval) {
    if(isDefined(self.headlights[localclientnum].headlight))
      stopfx(localclientnum, self.headlights[localclientnum].headlight);

    if(isDefined(self.headlights[localclientnum].headlightslensflare_l))
      stopfx(localclientnum, self.headlights[localclientnum].headlightslensflare_l);

    if(isDefined(self.headlights[localclientnum].headlightslensflare_r))
      stopfx(localclientnum, self.headlights[localclientnum].headlightslensflare_r);

    self.headlights[localclientnum].headlight = playfxontag(localclientnum, level._effect["fx_headlight"], self, "tag_headlights");
    self.headlights[localclientnum].headlightslensflare_l = playfxontag(localclientnum, level._effect["fx_headlight_lenflares"], self, "Tag_headlight_left");
    self.headlights[localclientnum].headlightslensflare_r = playfxontag(localclientnum, level._effect["fx_headlight_lenflares"], self, "Tag_headlight_right");
  } else {
    if(isDefined(self.headlights[localclientnum].headlight)) {
      stopfx(localclientnum, self.headlights[localclientnum].headlight);
      self.headlights[localclientnum].headlight = undefined;
    }

    if(isDefined(self.headlights[localclientnum].headlightslensflare_l)) {
      stopfx(localclientnum, self.headlights[localclientnum].headlightslensflare_l);
      self.headlights[localclientnum].headlightslensflare_l = undefined;
    }

    if(isDefined(self.headlights[localclientnum].headlightslensflare_r)) {
      stopfx(localclientnum, self.headlights[localclientnum].headlightslensflare_r);
      self.headlights[localclientnum].headlightslensflare_r = undefined;
    }
  }
}

bus_brake_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.brakelights))
    self.brakelights = [];

  if(newval) {
    if(isDefined(self.brakelights[localclientnum]))
      stopfx(localclientnum, self.brakelights[localclientnum]);

    self.brakelights[localclientnum] = playfxontag(localclientnum, level._effect["fx_brakelight"], self, "tag_brakelights");
  } else if(isDefined(self.brakelights[localclientnum])) {
    stopfx(localclientnum, self.brakelights[localclientnum]);
    self.brakelights[localclientnum] = undefined;
  }
}

bus_turnal_signal_right_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.rightlights))
    self.rightlights = [];

  if(newval) {
    if(isDefined(self.rightlights[localclientnum]))
      stopfx(localclientnum, self.rightlights[localclientnum]);

    self.rightlights[localclientnum] = playfxontag(localclientnum, level._effect["fx_turn_signal_right"], self, "tag_turnsignal_right");
  } else if(isDefined(self.rightlights[localclientnum])) {
    stopfx(localclientnum, self.rightlights[localclientnum]);
    self.rightlights[localclientnum] = undefined;
  }
}

bus_turnal_signal_left_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.leftlights))
    self.leftlights = [];

  if(newval) {
    if(isDefined(self.leftlights[localclientnum]))
      stopfx(localclientnum, self.leftlights[localclientnum]);

    self.leftlights[localclientnum] = playfxontag(localclientnum, level._effect["fx_turn_signal_left"], self, "tag_turnsignal_left");
  } else if(isDefined(self.leftlights[localclientnum])) {
    stopfx(localclientnum, self.leftlights[localclientnum]);
    self.leftlights[localclientnum] = undefined;
  }
}