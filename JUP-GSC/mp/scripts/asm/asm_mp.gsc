/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_mp.gsc
***********************************************/

#using scripts\anim\notetracks_mp;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace asm_mp;

function asm_init(baseasmname, archetypename) {
  self.asmname = baseasmname;
  first_init = 0;

  if(!isDefined(self.asm)) {
    first_init = 1;
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  if(isDefined(archetypename)) {
    if(first_init) {
      self function_e855b69f84cb6ce3(archetypename);
    } else {
      self setanimset(archetypename);
    }
  }

  self.fnasm_init = &asm_init;
  self.fnasm_setorientmode = &asm_settransitionorientmode_transition;
  self.fnasm_handlenotetrack = &scripts\anim\notetracks_mp::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_mp;
  self.fnasm_playfacialanim = &asm_playfacialanim_mp;
  self.fnplaceweaponon = &scripts\anim\shared::placeweaponon;
  self.fndooropen = &dooropen;
  self.fndoorclose = &doorclose;
  self.fndoorneedstoclose = &doorneedstoclose;
  self.fngetdoorcenter = &getdoorcenter;
  self.fndooralreadyopen = &dooralreadyopen;
  self function_131f6fb305015d0(&scripts\asm\shared\utility::tryopendoor);
  hack_setup_a_struct();
  function_c051a94f99bd65f1(self.asmname);
}

function hack_setup_a_struct() {
  if(isDefined(self.a)) {
    return;
  }

  self.a = spawnStruct();
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.a.lastenemytime = gettime();
  self.allowlongdeath = self isbadguy();
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.reacttobulletchance = 0.8;
  self.misstime = 0;
  self.a.nodeath = 0;
  self.misstime = 0;
  self.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.laserenabled = 0;
}

function function_a2b8f8b0891ee7fe() {
  level.fnanimatedprop_setup = &animatedprop_setup;
  level.fnanimatedprop_startanim = &animatedprop_setanim;
  level.fnanimatedprop_setanim = &animatedprop_setanim;
}

function animatedprop_setup(modelname, var, origin, angles) {
  assert(isDefined(level.scr_model));
  assert(isDefined(level.scr_model[modelname]));
  prop = spawn("script_model", origin);
  prop.angles = angles;
  prop setModel(level.scr_model[modelname]);
  self.animated_prop = prop;
}

function animatedprop_setanim(propname, param) {
  assert(isDefined(self.animated_prop));
  assert(isDefined(level.scr_anim) && isDefined(level.scr_anim[propname]));
  propanim = level.scr_anim[propname][param];
  self.animated_prop scriptmodelplayanimdeltamotion(propanim);
}

function runpain() {
  if(isDefined(self.fnshouldplaypainanim)) {
    if(![[self.fnshouldplaypainanim]]()) {
      return;
    }
  } else if(!shouldplaypainanim()) {
    return;
  }

  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);

    if(basename == "molotov_mp") {
      self._blackboard.isburning = 1;

      if(self.damageyaw > 0) {
        self.burningdirection = "right";
      } else {
        self.burningdirection = "left";
      }
    }
  }

  if(self asmhaspainstate(self.asmname)) {
    self asmevalpaintransition(self.asmname);
  }
}

function shouldplaypainanim() {
  var_392782e59863c89f = 64;

  if(istrue(self.a.disablepain)) {
    return false;
  }

  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return false;
  }

  if(istrue(self.var_a1db58c75f381a55)) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < var_392782e59863c89f) {
    return false;
  }

  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);
    isthermite = issubstr(basename, "thermite") || isDefined(self.damageweapon.magazine) && issubstr(self.damageweapon.magazine, "boltfire");

    if(isthermite && isDefined(self.a.lastpaintime) && gettime() - self.a.lastpaintime < 2000) {
      return false;
    }
  }

  return true;
}

function asm_handlenotetracks(note, animstate, animindex, animtime) {
  asm_fireevent(self.asmname, note);
}

function asm_shoulddeathtransition(asmname, currentstate) {
  assertmsg("<dev string:x1c>" + asmname + "<dev string:x32>");
}

function asm_settransitionorientmode_transition(orient_mode) {
  switch (orient_mode) {
    case #"hash_96a6a25bd7beed30":
      var_8e1451b5845405b1 = 1024;

      if(actor_is3d()) {
        orient_angles = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_8e1451b5845405b1) {
          orient_angles = self function_f134f30c17faeaf(self.node);
        }

        self orientmode("face angle 3d", orient_angles);
      } else {
        yaw = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_8e1451b5845405b1) {
          yaw = getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", yaw);
      }

      break;
    default:
      self orientmode(orient_mode);
      break;
  }
}

function asm_settransitionorientmode_legacy(orient_mode) {
  switch (orient_mode) {
    case #"hash_a6238b3102248f7f":
      pathgoal = self.pathgoalpos;

      if(isDefined(pathgoal)) {
        delta = pathgoal - self.origin;
        dir = vectorNormalize(delta);
        face_angles = vectortoangles(dir);
        self orientmode("face angle", face_angles[1]);
        break;
      }
    case #"hash_579a1f64b8b40d31":
      self orientmode("face current");
      break;
    case #"hash_87fdfc09c0f3853e":
    case #"hash_f51882822bb936c8":
      self orientmode(orient_mode);
      break;
    case #"hash_96a6a25bd7beed30":
      yaw = self.angles[1];
      var_8e1451b5845405b1 = 1024;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_8e1451b5845405b1) {
        yaw = getnodeforwardyaw(self.node);
      }

      self orientmode("face angle", yaw);
      break;
    default:
      assertex(0, "<dev string:x65>");
      break;
  }
}

function asm_getanimindex(asmname, statename, params) {
  return self asmgetanim(asmname, statename, params);
}

function asm_playadditiveanimloopstate_mp(asmname, statename, params) {}

function dooropen(door, t) {
  if(distance2dsquared(self.origin, door.origin) < 16) {}

  door scriptabledooropen("away", self.origin);

  if(door scriptabledoorisdouble()) {
    doorlist = getentitylessscriptablearray(undefined, undefined, door.origin, 64);

    foreach(otherdoor in doorlist) {
      if(otherdoor scriptabledoorisdouble()) {
        otherdoor scriptabledooropen("away", self.origin);
      }
    }

    return;
  }

  var_82b30cecb236888f = getdvarint(@ "hash_fddf57e578106aab", 0);

  if(var_82b30cecb236888f) {
    doorclosedangles = door function_bacd2d0acdf8559e();
    doorforward = anglesToForward(doorclosedangles);
    originshift = doorforward * 108;

    thread draw_circle(door.origin + originshift, 12, (1, 0, 0), 1, 0, 120000);

    doorlist = getentitylessscriptablearray(undefined, undefined, door.origin + originshift, 12);

    foreach(otherdoor in doorlist) {
      var_77e1c749cc698109 = otherdoor function_bacd2d0acdf8559e();
      var_c91c580eaa68cf32 = anglesToForward(var_77e1c749cc698109);

      if(vectordot(doorforward, var_c91c580eaa68cf32) < 0) {
        otherdoor scriptabledooropen("away", self.origin);
      }
    }
  }
}

function doorclose(door) {
  door scriptabledoorclose();
}

function doorneedstoclose(door) {
  if(istrue(door scriptableisdoor()) && door scriptabledoorisclosed()) {
    return false;
  }

  curstate = door getscriptablepartstate("door", 1);
  assert(isDefined(curstate));

  if(curstate == "closed" || curstate == "setup") {
    return false;
  }

  doortome = self.origin - door.origin;
  var_aba22f9f83213675 = vectortoyaw(doortome);
  doorclosedangles = door function_bacd2d0acdf8559e();
  anglediff = angleclamp180(var_aba22f9f83213675 - doorclosedangles[1]);
  openangle = angleclamp180(door.angles[1] - doorclosedangles[1]);
  return anglediff * openangle > 0;
}

function getdoorcenter(door) {
  assert(isDefined(self._blackboard.doorpos));
  return self._blackboard.doorpos;
}

function dooralreadyopen(door) {
  return abs(door scriptabledoorangle()) > 60;
}

function asm_animhasfacialoverridemp(a_anim) {
  if(!animisleaf(a_anim)) {
    return 0;
  }

  return animhasnotetrack(a_anim, "facial_override");
}

function asm_playfacialanim_mp(asmname, statename, animname) {
  self setfacialindexfromasm(asmname, statename, animname);
}

function asm_playfacialaniminternalmp(a_anim, a_state) {
  if(!isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(a_anim) && asm_animhasfacialoverridemp(a_anim)) {
    return;
  }

  headknob = asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(headknob)) {
    return;
  }

  if(!isDefined(self.asm.facial_state)) {
    self.asm.facial_state = "";
  }

  setfacialstate("asm");

  if(isai(self)) {
    self setfacialindex(a_state);
  }
}

function asm_setanimScripted() {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  asm_clearfacialanim();
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  self scriptedanimstarted();
}