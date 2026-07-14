/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\utility\backpack.gsc
*******************************************/

#namespace backpack;

function attachbag(bagmodel) {
  assert(isPlayer(self), "<dev string:x24>");

  if(!level.gametypebundle.showbackpack) {
    return;
  }

  if(isDefined(self.attached_bag)) {
    detachbag();
  }

  self attach(bagmodel, "tag_stowed_back3", 1, 1);

  if(!isDefined(self.operatorcustomization.body)) {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
      self hidepart("TAG_STOWED_BACKPACK_HIDE");
    }
  }

  self.attached_bag = bagmodel;
  self notify("backpack_attachbag");
}

function detachbag() {
  assert(isPlayer(self), "<dev string:x62>");

  if(!level.gametypebundle.showbackpack || !isDefined(self.attached_bag)) {
    return;
  }

  self detach(self.attached_bag, "tag_stowed_back3");
  self.attached_bag = undefined;
  self notify("backpack_detachbag");
}