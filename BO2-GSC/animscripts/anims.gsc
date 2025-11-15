/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims.gsc
**************************************/

#include animscripts\utility;
#include common_scripts\utility;
#include animscripts\shared;

animarray(animname, scriptoverride, errorifmissing) {
  return animarraygeneric(animname, scriptoverride, errorifmissing, self.anim_array, anim.anim_array, 1);
}

angledeltaarray(animname, scriptoverride, errorifmissing) {
  return animarraygeneric(animname, scriptoverride, errorifmissing, self.angle_delta_array, anim.angle_delta_array, 0);
}

movedeltaarray(animname, scriptoverride, errorifmissing) {
  return animarraygeneric(animname, scriptoverride, errorifmissing, self.move_delta_array, anim.move_delta_array, 0);
}

premovedeltaarray(animname, scriptoverride, errorifmissing) {
  return animarraygeneric(animname, scriptoverride, errorifmissing, self.pre_move_delta_array, anim.pre_move_delta_array, 0);
}

postmovedeltaarray(animname, scriptoverride, errorifmissing) {
  return animarraygeneric(animname, scriptoverride, errorifmissing, self.post_move_delta_array, anim.post_move_delta_array, 0);
}

longestexposedapproachdist() {
  if(isDefined(self.longestexposedapproachdist)) {
    assert(isDefined(self.longestexposedapproachdist[self.animtype]));
    return self.longestexposedapproachdist[self.animtype];
  }

  assert(isDefined(anim.longestexposedapproachdist));

  if(self.subclass != "regular" && isDefined(anim.longestexposedapproachdist[self.subclass]))
    return anim.longestexposedapproachdist[self.subclass];

  if(isDefined(anim.longestexposedapproachdist[self.animtype]))
    return anim.longestexposedapproachdist[self.animtype];

  return anim.longestexposedapproachdist["default"];
}

longestapproachdist(animname) {
  if(isDefined(self.longestapproachdist)) {
    if(isDefined(self.longestapproachdist[self.animtype][animname]))
      return self.longestapproachdist[self.animtype][animname];
  }

  assert(isDefined(anim.longestapproachdist));

  if(self.subclass != "regular" && isDefined(anim.longestapproachdist[self.subclass]) && isDefined(anim.longestapproachdist[self.subclass][animname]))
    return anim.longestapproachdist[self.subclass][animname];

  if(isDefined(anim.longestapproachdist[self.animtype]) && isDefined(anim.longestapproachdist[self.animtype][animname]))
    return anim.longestapproachdist[self.animtype][animname];

  return anim.longestapproachdist["default"][animname];
}

setidleanimoverride(overrideanim) {
  if(!isDefined(self.anim_array))
    self.anim_array = [];

  if(!isDefined(overrideanim)) {
    self.anim_array[self.animtype]["stop"]["stand"]["none"]["idle"] = undefined;
    self.anim_array[self.animtype]["stop"]["stand"][self weaponanims()]["idle"] = undefined;
  } else if(isarray(overrideanim)) {
    self.anim_array[self.animtype]["stop"]["stand"]["none"]["idle"] = array(overrideanim);
    self.anim_array[self.animtype]["stop"]["stand"][self weaponanims()]["idle"] = array(overrideanim);
  } else {
    self.anim_array[self.animtype]["stop"]["stand"]["none"]["idle"] = array(array(overrideanim));
    self.anim_array[self.animtype]["stop"]["stand"][self weaponanims()]["idle"] = array(array(overrideanim));
  }
}

#using_animtree("generic_human");

animarraygeneric(animname, scriptoverride, errorifmissing, my_anim_array, global_anim_array, usecache) {
  if(self.a.pose != self.a.prevpose) {
    clearanimcache();
    self.a.prevpose = self.a.pose;
  }

  if(usecache) {
    cacheentry = self.anim_array_cache[animname];

    if(isDefined(cacheentry))
      return cacheentry;
  }

  theanim = % void;
  animtype = self.animtype;
  animscript = self.a.script;
  animpose = self.a.pose;
  animweaponanims = self weaponanims();

  if(isai(self) && !self holdingweapon())
    animweaponanims = "none";

  errorifmissingoverride = errorifmissing;

  if(isDefined(scriptoverride))
    animscript = scriptoverride;
  else if(isDefined(self.a.script_suffix))
    animscript = animscript + self.a.script_suffix;

  if(isDefined(my_anim_array))
    theanim = self animarrayinternal(my_anim_array, animtype, animscript, animpose, animweaponanims, animname, 0, 0);

  assert(isDefined(global_anim_array));

  if(!isDefined(errorifmissing)) {
    if(animtype != "default" || self.subclass != "regular") {
      errorifmissing = 1;
      errorifmissingoverride = 0;
    } else {
      errorifmissing = 1;
      errorifmissingoverride = 1;
    }
  }

  if(isDefined(global_anim_array) && (!isDefined(theanim) || !isarray(theanim) && theanim == % void)) {
    if(self.subclass != "regular")
      theanim = self animarrayinternal(global_anim_array, self.subclass, animscript, animpose, animweaponanims, animname, errorifmissingoverride, 1);

    if(!isDefined(theanim) || !isarray(theanim) && theanim == % void)
      theanim = self animarrayinternal(global_anim_array, animtype, animscript, animpose, animweaponanims, animname, errorifmissingoverride, 1);

    if(animtype != "default" && (!isDefined(theanim) || !isarray(theanim) && theanim == % void))
      theanim = self animarrayinternal(global_anim_array, "default", animscript, animpose, animweaponanims, animname, errorifmissing, 1);
  }

  if(usecache && isDefined(theanim))
    self.anim_array_cache[animname] = theanim;

  return theanim;
}

animarrayexist(animname, scriptoverride) {
  theanim = animarray(animname, scriptoverride, 0);

  if(!isDefined(theanim) || theanim == % void)
    return false;

  return true;
}

animarrayanyexist(animname, scriptoverride) {
  animarray = animarray(animname, scriptoverride, 0);

  if(!isDefined(animarray) || !isarray(animarray) && animarray == % void)
    return false;
  else if(!isarray(animarray))
    return true;

  return animarray.size > 0;
}

animarraypickrandom(animname, scriptoverride, oncepercache) {
  animarray = animarray(animname, scriptoverride);

  if(!isarray(animarray))
    return animarray;

  assert(animarray.size > 0);

  if(animarray.size > 1)
    index = randomint(animarray.size);
  else
    index = 0;

  if(isDefined(oncepercache))
    self.anim_array_cache[animname] = animarray[index];

  return animarray[index];
}

animarrayinternal(anim_array, animtype, animscript, animpose, animweaponanims, animname, errorifmissing, globalarraylookup) {
  animtype_array = anim_array[animtype];

  if(!isDefined(animtype_array)) {
    if(errorifmissing) {
      errormsg = "Missing anim: " + animtype + "/" + animscript + "/" + animpose + "/" + animweaponanims + "/" + animname + ". AnimType '" + animtype + "' not part of anim array. ";
      assert(isDefined(animtype_array), errormsg);
    }

    return % void;
  }

  script_array = animtype_array[animscript];

  if(!isDefined(script_array)) {
    if(isDefined(self.covernode) && animscript != "combat" && animscripts\shared::isexposed())
      return animarrayinternal(anim_array, animtype, "combat", animpose, animweaponanims, animname, errorifmissing, globalarraylookup);

    if(errorifmissing) {
      errormsg = "Missing anim: " + animtype + "/" + animscript + "/" + animpose + "/" + animweaponanims + "/" + animname + ". Script '" + animscript + "' not part of anim array. ";
      assert(isDefined(script_array), errormsg);
    }

    return % void;
  }

  pose_array = script_array[animpose];

  if(!isDefined(pose_array)) {
    if(errorifmissing) {
      errormsg = "Missing anim: " + animtype + "/" + animscript + "/" + animpose + "/" + animweaponanims + "/" + animname + ". Pose '" + animpose + "' not part of anim array. ";
      assert(isDefined(pose_array), errormsg);
    }

    return % void;
  }

  weapon_array = pose_array[animweaponanims];

  if(!isDefined(weapon_array)) {
    if(animweaponanims != "rifle" && globalarraylookup)
      return animarrayinternal(anim_array, animtype, animscript, animpose, "rifle", animname, errorifmissing, globalarraylookup);

    if(errorifmissing) {
      errormsg = "Missing anim: " + animtype + "/" + animscript + "/" + animpose + "/" + animweaponanims + "/" + animname + ". WeaponType '" + animweaponanims + "' not part of anim array. ";
      assertmsg(errormsg);

    }

    return % void;
  }

  theanim = weapon_array[animname];

  if(!isDefined(theanim)) {
    if(animweaponanims != "rifle")
      theanim = animarrayinternal(anim_array, animtype, animscript, animpose, "rifle", animname, errorifmissing, globalarraylookup);
    else if(isDefined(self.covernode) && animscript != "combat" && globalarraylookup)
      theanim = animarrayinternal(anim_array, animtype, "combat", animpose, animweaponanims, animname, errorifmissing, globalarraylookup);

    if((!isDefined(theanim) || !isarray(theanim) && theanim == % void) && errorifmissing) {
      errormsg = "Missing anim: " + animtype + "/" + animscript + "/" + animpose + "/" + animweaponanims + "/" + animname + ". Anim '" + animname + "' not part of anim array. Cur: " + self.a.script + "Prev: " + self.a.prevscript;
      assert(isDefined(theanim) && theanim != % void, errormsg);

    }
  }

  return theanim;
}

dumpanimarray() {
  println("self.a.array:");
  keys = getarraykeys(self.a.array);

  for(i = 0; i < keys.size; i++) {
    if(isarray(self.a.array[keys[i]])) {
      println(" array[ \"" + keys[i] + "\" ] = {array of size " + self.a.array[keys[i]].size + "}");
      continue;
    }

    println(" array[ \"" + keys[i] + "\" ] = ", self.a.array[keys[i]]);
  }

}

clearanimcache() {
  self.anim_array_cache = [];
}