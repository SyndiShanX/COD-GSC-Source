/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\riotshield.gsc
***********************************************/

#using scripts\cp_mp\utility\weapon_utility;
#namespace riotshield;

function function_3f6d1c80aac1b91() {
  weaponlist = self getweaponslistprimaries();
  shieldweapon = undefined;
  assert(!riotshield_hastwo(), "<dev string:x1c>");

  foreach(weapon in weaponlist) {
    if(isriotshield(weapon)) {
      shieldweapon = weapon;
      break;
    }
  }

  return shieldweapon;
}

function riotshield_hasweapon() {
  result = 0;
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(isriotshield(weapon)) {
      result = 1;
      break;
    }
  }

  return result;
}

function riotshield_hastwo() {
  count = 0;
  weapons = self getweaponslistprimaries();

  foreach(weapon in weapons) {
    if(isriotshield(weapon)) {
      count++;
    }

    if(count == 2) {
      break;
    }
  }

  return count == 2;
}

function riotshield_attach(onarm, modelshield) {
  tagattach = undefined;

  if(onarm) {
    assertex(!isDefined(self.riotshieldmodel), "<dev string:x85>");
    self.riotshieldmodel = modelshield;
    tagattach = "j_shield_ri";
  } else {
    assertex(!isDefined(self.riotshieldmodelstowed), "<dev string:xd2>");
    self.riotshieldmodelstowed = modelshield;
    tagattach = "tag_shield_back";
  }

  self attachshieldmodel(modelshield, tagattach, 0, !onarm);
  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_detach(onarm) {
  modelshield = undefined;
  tagdetach = undefined;

  if(onarm) {
    assertex(isDefined(self.riotshieldmodel), "<dev string:x11b>");
    modelshield = self.riotshieldmodel;
    tagdetach = "j_shield_ri";
  } else {
    assertex(isDefined(self.riotshieldmodelstowed), "<dev string:x164>");
    modelshield = self.riotshieldmodelstowed;
    tagdetach = "tag_shield_back";
  }

  self detachshieldmodel(modelshield, tagdetach);

  if(onarm) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_move(var_9a9844b3a758c1c9) {
  tagstart = undefined;
  tagend = undefined;
  modelshield = undefined;

  if(var_9a9844b3a758c1c9) {
    assertex(isDefined(self.riotshieldmodel), "<dev string:x1ad>");
    modelshield = self.riotshieldmodel;
    tagstart = "j_shield_ri";
    tagend = "tag_shield_back";
  } else {
    assertex(isDefined(self.riotshieldmodelstowed), "<dev string:x1f4>");
    modelshield = self.riotshieldmodelstowed;
    tagstart = "tag_shield_back";
    tagend = "j_shield_ri";
  }

  self moveshieldmodel(modelshield, tagstart, tagend, var_9a9844b3a758c1c9);

  if(var_9a9844b3a758c1c9) {
    self.riotshieldmodelstowed = modelshield;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = modelshield;
  self.riotshieldmodelstowed = undefined;
}

function riotshield_clear() {
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

function riotshield_getmodel() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(isriotshield(weapon)) {
      attachmentmodels = getweaponattachmentworldmodels(weapon);
      assert(attachmentmodels.size == 1, "<dev string:x23b>");
      return attachmentmodels[0];
    }
  }

  assertmsg("<dev string:x284>");
  return "empty_model";
}

function setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

function clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}