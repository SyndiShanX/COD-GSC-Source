/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims.gsc
**************************************/

#include animscripts\utility;
#include common_scripts\Utility;
#using_animtree("generic_human");

animArray(animname, scriptOverride, errorIfMissing) {
  return animArrayGeneric(animname, scriptOverride, errorIfMissing, self.anim_array, anim.anim_array, true);
}
angleDeltaArray(animname, scriptOverride, errorIfMissing) {
  return animArrayGeneric(animname, scriptOverride, errorIfMissing, self.angle_delta_array, anim.angle_delta_array, false);
}
moveDeltaArray(animname, scriptOverride, errorIfMissing) {
  return animArrayGeneric(animname, scriptOverride, errorIfMissing, self.move_delta_array, anim.move_delta_array, false);
}
preMoveDeltaArray(animname, scriptOverride, errorIfMissing) {
  return animArrayGeneric(animname, scriptOverride, errorIfMissing, self.pre_move_delta_array, anim.pre_move_delta_array, false);
}
postMoveDeltaArray(animname, scriptOverride, errorIfMissing) {
  return animArrayGeneric(animname, scriptOverride, errorIfMissing, self.post_move_delta_array, anim.post_move_delta_array, false);
}
longestExposedApproachDist() {
  if(isDefined(self.longestExposedApproachDist)) {
    assert(isDefined(self.longestExposedApproachDist[self.animType]));
    return self.longestExposedApproachDist[self.animType];
  }
  assert(isDefined(anim.longestExposedApproachDist));
  if(isDefined(anim.longestExposedApproachDist[self.animType])) {
    return anim.longestExposedApproachDist[self.animType];
  }
  return anim.longestExposedApproachDist["default"];
}
setIdleAnimOverride(overrideAnim) {
  if(!isDefined(self.anim_array)) {
    self.anim_array = [];
  }
  if(!isDefined(overrideAnim)) {
    self.anim_array[self.animType]["stop"]["stand"]["none"]["idle"] = undefined;
    self.anim_array[self.animType]["stop"]["stand"][self WeaponAnims()]["idle"] = undefined;
  } else if(IsArray(overrideAnim)) {
    self.anim_array[self.animType]["stop"]["stand"]["none"]["idle"] = array(overrideAnim);
    self.anim_array[self.animType]["stop"]["stand"][self WeaponAnims()]["idle"] = array(overrideAnim);
  } else {
    self.anim_array[self.animType]["stop"]["stand"]["none"]["idle"] = array(array(overrideAnim));
    self.anim_array[self.animType]["stop"]["stand"][self WeaponAnims()]["idle"] = array(array(overrideAnim));
  }
}
animArrayGeneric(animname, scriptOverride, errorIfMissing, my_anim_array, global_anim_array, useCache) {
  if(self.a.pose != self.a.prevPose) {
    clearAnimCache();
    self.a.prevPose = self.a.pose;
  }
  if(useCache) {
    cacheEntry = self.anim_array_cache[animname];
    if(isDefined(cacheEntry)) {
      return cacheEntry;
    }
  }
  theAnim = % void;
  animType = self.animType;
  animScript = self.a.script;
  animPose = self.a.pose;
  animWeaponAnims = self WeaponAnims();
  if(IsAi(self) && !self holdingWeapon()) {
    animWeaponAnims = "none";
  }
  errorIfMissingOverride = errorIfMissing;
  if(isDefined(scriptOverride)) {
    animScript = scriptOverride;
  } else if(isDefined(self.a.script_suffix)) {
    animScript += self.a.script_suffix;
  }
  if(isDefined(my_anim_array)) {
    theAnim = self animArrayInternal(my_anim_array, animType, animScript, animPose, animWeaponAnims, animName, false, false);
  }
  assert(isDefined(global_anim_array));
  if(!isDefined(errorIfMissing)) {
    if(animType != "default") {
      errorIfMissing = true;
      errorIfMissingOverride = false;
    } else {
      errorIfMissing = true;
      errorIfMissingOverride = true;
    }
  }
  if(isDefined(global_anim_array) && (!isDefined(theAnim) || (!IsArray(theAnim) && theAnim == % void))) {
    theAnim = self animArrayInternal(global_anim_array, animType, animScript, animPose, animWeaponAnims, animName, errorIfMissingOverride, true);
    if(animType != "default" && (!isDefined(theAnim) || (!IsArray(theAnim) && theAnim == % void))) {
      theAnim = self animArrayInternal(global_anim_array, "default", animScript, animPose, animWeaponAnims, animName, errorIfMissing, true);
    }
  }
  if(useCache && isDefined(theAnim)) {
    self.anim_array_cache[animname] = theAnim;
  }
  return theAnim;
}
animArrayExist(animname, scriptOverride) {
  theAnim = animArray(animname, scriptOverride, false);
  if(!isDefined(theAnim) || theAnim == % void) {
    return false;
  }
  return true;
}
animArrayAnyExist(animname, scriptOverride) {
  animArray = animArray(animname, scriptOverride, false);
  if(!isDefined(animArray) || (!IsArray(animArray) && animArray == % void)) {
    return false;
  } else if(!IsArray(animArray)) {
    return true;
  }
  return animArray.size > 0;
}
animArrayPickRandom(animname, scriptOverride, oncePerCache) {
  animArray = animArray(animname, scriptOverride);
  if(!IsArray(animArray)) {
    return animArray;
  }
  assert(animArray.size > 0);
  if(animArray.size > 1) {
    index = RandomInt(animArray.size);
  } else {
    index = 0;
  }
  if(isDefined(oncePerCache)) {
    self.anim_array_cache[animname] = animArray[index];
  }
  return animArray[index];
}
animArrayInternal(anim_array, animType, animScript, animPose, animWeaponAnims, animName, errorIfMissing, globalArrayLookup) {
  theAnim = undefined;
  animType_array = anim_array[animType];
  if(!isDefined(animType_array)) {
    return % void;
  }
  script_array = animType_array[animScript];
  if(!isDefined(script_array)) {
    if(isDefined(self.coverNode) && animScript != "combat" && animscripts\shared::isExposed()) {
      return animArrayInternal(anim_array, animType, "combat", animPose, animWeaponAnims, animName, errorIfMissing, globalArrayLookup);
    }
    return % void;
  }
  pose_array = script_array[animPose];
  if(!isDefined(pose_array)) {
    return % void;
  }
  weapon_array = pose_array[animWeaponAnims];
  if(!isDefined(weapon_array)) {
    if(animWeaponAnims != "rifle" && globalArrayLookup) {
      return animArrayInternal(anim_array, animType, animScript, animPose, "rifle", animName, errorIfMissing, globalArrayLookup);
    }
    if((!isDefined(theAnim) || (!IsArray(theAnim) && theAnim == % void)) && errorIfMissing) {}
    return % void;
  }
  theAnim = weapon_array[animName];
  if(!isDefined(theAnim)) {
    if(animWeaponAnims != "rifle") {
      theAnim = animArrayInternal(anim_array, animType, animScript, animPose, "rifle", animName, errorIfMissing, globalArrayLookup);
    } else if(isDefined(self.coverNode) && animScript != "combat") {
      theAnim = animArrayInternal(anim_array, animType, "combat", animPose, animWeaponAnims, animName, errorIfMissing, globalArrayLookup);
    }
    if((!isDefined(theAnim) || (!IsArray(theAnim) && theAnim == % void)) && errorIfMissing) {}
  }
  return theAnim;
}
clearAnimCache() {
  self.anim_array_cache = [];
}