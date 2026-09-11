/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_mp.gsc
***********************************************/

function asm_init(var0, var1) {
  self.asm = spawnStruct();
  self.asm.animoverrides = [];
  self.asm.frantic = 0;
  self.asmname = var0;
  self.asm.archetype = var1;
  self setanimset(var1);
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
  var2 = var0;

  if(isDefined(self.asmasset)) {
    var2 = self.asmasset;
  }

  asmregistergenerichandler(var2, &scripts\asm\asm::asm_generichandler);
  self asminstantiate(var2);
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

function bunker_waitforuse(var0, var1, var2, var3) {
  var4 = spawn("script_model", var2);
  var4.angles = var3;
  var4 setModel(level.scr_model[var0]);
  self.animated_prop = var4;
}

function bunker_spawning(var0, var1) {
  var2 = level.scr_anim[var0][var1];
  self.animated_prop scriptmodelplayanimdeltamotion(var2);
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
    var0 = getweaponbasename(self.damageweapon);

    if(var0 == "molotov_mp") {
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
    self waittill("traverse_begin", var0, var1);

    if(!self asmhasstate(self.asmname, var0)) {
      var0 = "traverse_external";
    }

    self asmsetstate(self.asmname, var0);
  }
}

function shouldplaypainanim() {
  var0 = 64;

  if(self.a.disablepain) {
    return false;
  }

  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < var0) {
    return false;
  }

  if(isDefined(self.damageweapon)) {
    var1 = getweaponbasename(self.damageweapon);
    var2 = issubstr(var1, "thermite") || isDefined(self.damageweapon.magazine) && issubstr(self.damageweapon.magazine, "boltfire");

    if(var2 && isDefined(self.a.lastpaintime) && gettime() - self.a.lastpaintime < 2000) {
      return false;
    }
  }

  return true;
}

function asm_handlenotetracks(var0, var1, var2, var3) {
  scripts\asm\asm::asm_fireevent(self.asmname, var0);
}

function asm_playanimstateindex(var0, var1, var2, var3) {
  care_pkg(var0, var1, var2, var3, "end");
}

function care_pkg(var0, var1, var2, var3, var4) {
  self endon(var1 + "_finished");
  var5 = scripts\asm\asm::asm_getnotehandler(var0, var1);

  if(isDefined(var3)) {
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(var1, var2, var3, var1, var4, var5);
    return;
  }

  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var1, var2, var1, var4, var5);
}

function asm_playanimstateuntilnotetrack(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = asm_getanimindex(var0, var1);
  var4 = scripts\asm\asm::asm_getnotehandler(var0, var1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var1, var3, var1, var2, var4);
}

function asm_shoulddeathtransition(var0, var1) {}

function asm_settransitionorientmode_transition(var0) {
  switch (var0) {
    case "face node":
      var1 = 1024;

      if(scripts\engine\utility::actor_is3d()) {
        var2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var1) {
          var2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);
        }

        self orientmode("face angle 3d", var2);
      } else {
        var3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var1) {
          var3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", var3);
      }

      break;
    default:
      self orientmode(var0);
      break;
  }
}

function asm_settransitionorientmode_legacy() {
  switch (var0) {
    case "face goal":
      var1 = self.pathgoalpos;

      if(isDefined(var1)) {
        var2 = var1 - self.origin;
        var3 = vectorNormalize(var2);
        var4 = vectortoangles(var3);
        self orientmode("face angle", var4[1]);
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
      var5 = self.angles[1];
      var6 = 1024;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var6) {
        var5 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
      }

      self orientmode("face angle", var5);
      break;
    default:
      break;
  }
}

function asm_getanimindex(var0, var1, var2) {
  return self asmgetanim(var0, var1, var2);
}

function asm_playadditiveanimloopstate_mp(var0, var1, var2) {}

function dooropen(var0, var1) {
  if(distance2dsquared(self.origin, var0.origin) < 16) {}

  var0 constraintoscriptgoalRadius("away", self.origin);

  if(var0 scriptabledoorisdouble()) {
    var2 = getentitylessscriptablearrayinradius(undefined, undefined, var0.origin, 64);

    foreach(var4 in var2) {
      if(var4 scriptabledoorisdouble()) {
        var4 constraintoscriptgoalRadius("away", self.origin);
      }
    }

    return;
  }
}

function doorclose(var0) {
  var0 vehicle_getinputvalue();
}

function doorneedstoclose(var0) {
  var1 = var0 getscriptablepartstate("door", 1);

  if(var1 == "closed" || var1 == "setup") {
    return false;
  }

  var2 = self.origin - var0.origin;
  var3 = vectortoyaw(var2);
  var4 = angleclamp180(var3 - var0.heli_intro[1]);
  var5 = angleclamp180(var0.angles[1] - var0.heli_intro[1]);
  return var4 * var5 > 0;
}

function getdoorcenter(var0) {
  return self._blackboard.doorpos;
}

function dooralreadyopen(var0) {
  return abs(var0 scriptabledoorangle()) > 60;
}

function care_packages_unusable_think(var0) {
  if(!animisleaf(var0)) {
    return 0;
  }

  return animhasnotetrack(var0, "facial_override");
}

function carepackage_drop_from_heli(var0, var1, var2) {
  self playencryptedcinematicforplayer(var0, var1, var2);
}

function carepackage_drops(var0, var1) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("asm")) {
    return;
  }

  if(isDefined(var0) && care_packages_unusable_think(var0)) {
    return;
  }

  var2 = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(var2)) {
    return;
  }

  if(!isDefined(self.asm.facial_state)) {
    self.asm.facial_state = "";
  }

  scripts\asm\shared\utility::setfacialstate("asm");

  if(isai(self)) {
    self setfacialindex(var1);
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