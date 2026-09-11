/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_mp.gsc
***********************************************/

function asm_init(var_0, var_1) {
  self.asm = spawnStruct();
  self.asm.animoverrides = [];
  self.asm.frantic = 0;
  self.asmname = var_0;
  self.asm.archetype = var_1;
  self setanimset(var_1);
  self.fnasm_init = &asm_init;

  if(self islegacyagent()) {
    self.fnasm_setorientmode = &asm_settransitionorientmode_legacy;
  } else {
    self.fnasm_setorientmode = &asm_settransitionorientmode_transition;
  }

  self.fnasm_handlenotetrack = &scripts\anim\notetracks_mp::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_mp;
  self.fnasm_playfacialanim = &carepackage_drop_from_heli;
  self.fndooropen = &dooropen;
  self.fndoorclose = &doorclose;
  self.fndoorneedstoclose = &doorneedstoclose;
  self.fngetdoorcenter = &getdoorcenter;
  self.fndooralreadyopen = &dooralreadyopen;
  level.playercanplaynotcriticalgesture = &bunker_waitforuse;
  level.playercanseedangercircleworld = &bunker_spawning;
  level.playercanbuyrespawn = &bunker_spawning;
  hack_setup_a_struct();
  var_2 = var_0;

  if(isDefined(self.asmasset)) {
    var_2 = self.asmasset;
  }

  asmregistergenerichandler(var_2, &scripts\asm\asm::asm_generichandler);
  self asminstantiate(var_2);
}

function hack_setup_a_struct() {
  if(isDefined(self.a)) {
    return;
  }

  self.a = spawnStruct();
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.suppressingenemy = 0;
  self.a.disablelongdeath = !self isbadguy();
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self.a.misstime = 0;
  self.a.nodeath = 0;
  self.a.misstime = 0;
  self.a.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.a.laseron = 0;
}

function bunker_waitforuse(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel(level.scr_model[var_0]);
  self.animated_prop = var_4;
}

function bunker_spawning(var_0, var_1) {
  var_2 = level.scr_anim[var_0][var_1];
  self.animated_prop scriptmodelplayanimdeltamotion(var_2);
}

function ref_12e1d() {
  if(isDefined(self.fnshouldplaypainanim)) {
    if(![[self.fnshouldplaypainanim]]()) {
      return;
    }
  } else if(!shouldplaypainanim()) {
    return;
  }

  if(isDefined(self.damageweapon)) {
    var_0 = getweaponbasename(self.damageweapon);

    if(var_0 == "molotov_mp") {
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
    return;
  }
}

function traversehandler() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("traverse_begin", var_0, var_1);

    if(!self asmhasstate(self.asmname, var_0)) {
      var_0 = "traverse_external";
    }

    self asmsetstate(self.asmname, var_0);
  }
}

function shouldplaypainanim() {
  var_0 = 64;

  if(self.a.disablepain) {
    return false;
  }

  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < var_0) {
    return false;
  }

  if(isDefined(self.damageweapon)) {
    var_1 = getweaponbasename(self.damageweapon);
    var_2 = issubstr(var_1, "thermite") || isDefined(self.damageweapon.magazine) && issubstr(self.damageweapon.magazine, "boltfire");

    if(var_2 && isDefined(self.a.lastpaintime) && gettime() - self.a.lastpaintime < 2000) {
      return false;
    }
  }

  return true;
}

function asm_handlenotetracks(var_0, var_1, var_2, var_3) {
  scripts\asm\asm::asm_fireevent(self.asmname, var_0);
}

function asm_playanimstateindex(var_0, var_1, var_2, var_3) {
  care_pkg(var_0, var_1, var_2, var_3, "end");
}

function care_pkg(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = scripts\asm\asm::asm_getnotehandler(var_0, var_1);

  if(isDefined(var_3)) {
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(var_1, var_2, var_3, var_1, var_4, var_5);
    return;
  }

  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var_1, var_2, var_1, var_4, var_5);
}

function asm_playanimstateuntilnotetrack(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getanimindex(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getnotehandler(var_0, var_1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var_1, var_3, var_1, var_2, var_4);
}

function asm_shoulddeathtransition(var_0, var_1) {}

function asm_settransitionorientmode_transition(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024;

      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
          var_2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);
        }

        self orientmode("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
          var_3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", var_3);
      }

      break;
    default:
      self orientmode(var_0);
      break;
  }
}

function asm_settransitionorientmode_legacy() {
  switch (var_0) {
    case "face goal":
      var_1 = self.pathgoalpos;

      if(isDefined(var_1)) {
        var_2 = var_1 - self.origin;
        var_3 = vectorNormalize(var_2);
        var_4 = vectortoangles(var_3);
        self orientmode("face angle", var_4[1]);
        break;
      }
    case "face current":
      self orientmode("face current");
      break;
    case "face motion":
    case "face enemy":
      self orientmode( < error > );
      break;
    case "face node":
      var_5 = self.angles[1];
      var_6 = 1024;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_6) {
        var_5 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
      }

      self orientmode("face angle", var_5);
      break;
    default:
      break;
  }
}

function asm_getanimindex(var_0, var_1, var_2) {
  return self asmgetanim(var_0, var_1, var_2);
}

function asm_playadditiveanimloopstate_mp(var_0, var_1, var_2) {}

function dooropen(var_0, var_1) {
  if(distance2dsquared(self.origin, var_0.origin) < 16) {}

  var_0 constraintoscriptgoalRadius("away", self.origin);

  if(var_0 scriptabledoorisdouble()) {
    var_2 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, 64);

    foreach(var_4 in var_2) {
      if(var_4 scriptabledoorisdouble()) {
        var_4 constraintoscriptgoalRadius("away", self.origin);
      }
    }

    return;
  }
}

function doorclose(var_0) {
  var_0 vehicle_getinputvalue();
}

function doorneedstoclose(var_0) {
  var_1 = var_0 getscriptablepartstate("door", 1);

  if(var_1 == "closed" || var_1 == "setup") {
    return false;
  }

  var_2 = self.origin - var_0.origin;
  var_3 = vectortoyaw(var_2);
  var_4 = angleclamp180(var_3 - var_0.heli_intro[1]);
  var_5 = angleclamp180(var_0.angles[1] - var_0.heli_intro[1]);
  return var_4 * var_5 > 0;
}

function getdoorcenter(var_0) {
  return self._blackboard.doorpos;
}

function dooralreadyopen(var_0) {
  return abs(var_0 scriptabledoorangle()) > 60;
}

function care_packages_unusable_think(var_0) {
  if(!animisleaf(var_0)) {
    return 0;
  }

  return animhasnotetrack(var_0, "facial_override");
}

function carepackage_drop_from_heli(var_0, var_1, var_2) {
  self playencryptedcinematicforplayer(var_0, var_1, var_2);
}

function carepackage_drops(var_0, var_1) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(var_0) && care_packages_unusable_think(var_0)) {
    return;
  }

  var_2 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(var_2)) {
    return;
  }

  if(!isDefined(self.asm.facial_state)) {
    self.asm.facial_state = "";
  }

  scripts\asm\shared\utility::setfacialstate("asm");

  if(isai(self)) {
    self setfacialindex(var_1);
    return;
  }
}

function carepackage_get_dropped_entities() {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_clearfacialanim();
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
}