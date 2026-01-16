/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zm_tomb_teleporter.csc
***************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\_filter;
#using_animtree("fxanim_props_dlc4");

init_animtree() {
  scriptmodelsuseanimtree(#animtree);
}

teleporter_fx_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("disconnect");

  if(newval == 1) {
    if(!isDefined(self.fx_teleport))
      self.fx_teleport = playfxontag(localclientnum, level._effect["teleport_1p"], self, "tag_origin");
  } else if(isDefined(self.fx_teleport)) {
    stopfx(localclientnum, self.fx_teleport);
    self.fx_teleport = undefined;
  }
}

teleporter_door_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  first_time_run = !is_true(self.has_anim_tree);

  if(!is_true(self.has_anim_tree)) {
    self useanimtree(#animtree);
    self.has_anim_tree = 1;
  }

  if(newval) {
    if(!first_time_run)
      self clearanim( % fxanim_zom_tomb_portal_collapse_anim, 0);

    self setanim( % fxanim_zom_tomb_portal_open_anim, 1.0, 0.1, 1);
  } else {
    self clearanim( % fxanim_zom_tomb_portal_open_anim, 0);
    self setanim( % fxanim_zom_tomb_portal_collapse_anim, 1.0, 0.1, 1);
  }
}