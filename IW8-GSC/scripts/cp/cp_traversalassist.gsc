/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_traversalassist.gsc
***********************************************/

function traversal_assist_init() {
  if(!istrue(level.teambased)) {
    return;
  }

  level.usequickrope = getdvarint("scr_buddyboost_rope", 1) == 1;
  level.pullbothup = getdvarint("scr_buddyboost_both", 1) == 1;
  level.traversalassist = [];
  level.traversalassistmode = 3;

  if(getdvarint("scr_buddyboost_enabled", 1) == 0) {
    return;
  }

  add_traversalassist_array();
  add_contextualwalltraversal_array();

  if(getdvarint("scr_buddyboost_debug", 0) == 1) {
    thread debug_loopbuddyboostanims();
    return;
  }
}

#using_animtree("script_model");

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  if(getdvarint("scr_buddyboost_force", 2) != 0) {
    if(isDefined(self.p1.wallscenenodepos)) {
      self.initialorg.origin = self.p1.wallscenenodepos;
      self.initialorg.angles = self.p1.wallscenenodeang;
    }

    var0 setOrigin(self.initialorg.origin);
    var0 setplayerangles(self.initialorg.angles);
  }

  var0 predictstreampos(self.initialorg.origin);
  var3 = spawn("script_arms", self.initialorg.origin, 0, 0, var0);
  var3.player = var0;
  var0.player_rig = var3;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var0, self);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var0.player_rig delete();
  var0.player_rig = undefined;
}

function watch_remove_rig(var0) {
  thread actioncancellation(var0);
  thread playercancellation();
  self waittill("can_remove_rig");
}

function actioncancellation(var0) {
  var0 waittill("traverseassist_cancelled");
  self notify("can_remove_rig");
}

function playercancellation() {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
  self notify("can_remove_rig");
}

function add_traversalassist_array() {
  var0 = getEntArray("traversalassist", "targetname");

  foreach(var2 in var0) {
    var3 = spawnStruct();
    add_traversalassist(var3, var2);
    thread setup_traversalassist();
    level.traversalassist[level.traversalassist.size] = var3;
  }
}

function disable_traversalassists() {
  foreach(var1 in level.traversalassist) {
    var1.initialtrigger makeunusable();
    var1.boosttrigger makeunusable();
    var1.toptrigger makeunusable();
    var1.pulluptrigger makeunusable();

    if(isDefined(var1.topwatchtrigger)) {
      var1.topwatchtrigger makeunusable();
    }
  }
}

function add_traversalassist(var0, var1) {
  if(!isDefined(var0.ents)) {
    var0.ents = [];
  }

  switch (var1.classname) {
    case "trigger_use_touch":
      var0.use_trigger = var1;
      break;
  }

  if(isDefined(var1.script_noteworthy)) {
    switch (var1.script_noteworthy) {
      case "initialOrg":
        var0.initialorg = var1;
        break;
      case "finalOrg":
        var0.finalorg = var1;
        break;
    }
  }

  var0.ents[var0.ents.size] = var1;

  if(isDefined(var1.target)) {
    var2 = getEntArray(var1.target, "targetname");

    if(isDefined(var2) && var2.size > 0) {
      foreach(var4 in var2) {
        add_traversalassist(var0, var4);
      }

      return;
    }

    return;
  }
}

function setup_traversalassist(var0) {
  spawnhintobjects(var0);
  self.phase = 0;
  setphase(0);
  thread handlephasecancellation();
}

function assist_onbeginuse(var0) {
  self.parent.p1 = var0;
  thread setphase(self.parent);
}

function assist_onenduse(var0, var1, var2) {
  if(!var2 && (self.parent.phase == 1 || self.parent.phase == 2)) {
    self.parent notify("traverseassist_cancelled");
    return;
  }
}

function watchdeath(var0) {
  self endon("traverseassist_cancelled");
  var1 = var0.name;
  var0 waittill("death");
  self notify("traverseassist_cancelled");
}

function watchdisconnect(var0) {
  self endon("traverseassist_cancelled");
  var1 = var0.name;
  var0 waittill("disconnect");
  self notify("traverseassist_cancelled");
}

function setphase(var0) {
  var1 = self.phase;
  self.phase = var0;

  switch (var1) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
  }

  switch (var0) {
    case 0:
      self notify("traverseassist_cancelled");

      if(isDefined(self.p1)) {
        self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
        self.p1.blockupdatewalldata = 0;

        if(var1 != 4) {
          self.p1 setOrigin(self.p1 getdroptofloorposition(self.p1.origin));
        }
      }

      if(isDefined(self.p2)) {
        self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
        self.p2.blockupdatewalldata = 0;
      }

      remove_player_rig(self.p1);
      remove_player_rig(self.p2);

      if(!istrue(self.quickavailable)) {
        enabletrigger(self.initialtrigger);
      }

      disabletrigger(self.boosttrigger);
      disabletrigger(self.toptrigger);
      disabletrigger(self.pulluptrigger);

      if(isDefined(self.topwatchtrigger)) {
        self.topwatchtrigger delete();
        self.topwatchtrigger = undefined;
      }

      break;
    case 1:
      if(var1 == 0) {
        if(istrue(self.p1.hassolobuddyboost) || level.players.size == 1) {
          thread dosoloboost();
        } else {
          thread preparetohoist();
        }
      } else if(var1 == 2) {
        remove_player_rig(self.p2);
      }

      break;
    case 2:
      break;
    case 3:
      disabletrigger(self.boosttrigger);
      giveboostscore(self.p1);
      self notify("SetPhase3");
      thread dohoist();
      break;
    case 4:
      disabletrigger(self.toptrigger);
      disabletrigger(self.pulluptrigger);

      if(isDefined(self.topwatchtrigger)) {
        self.topwatchtrigger delete();
        self.topwatchtrigger = undefined;
      }

      remove_player_rig(self.p1);
      remove_player_rig(self.p2);
      thread createtoptrigger();
      thread toptriggertrackplayer();
      break;
    case 5:
      thread preparetograb();
      break;
    case 6:
      break;
    case 7:
      self notify("SetPhase7");
      giveboostscore(self.p2);
      dograb();
      break;
  }
}

function handlephasecancellation() {
  for(;;) {
    self waittill("traverseassist_cancelled");

    switch (self.phase) {
      case 0:
        break;
      case 1:
        thread setphase(0);
        break;
      case 2:
        if(isDefined(self.p1) && self.p1 scripts\cp_mp\utility\player_utility::_isalive()) {
          thread setphase(1);
        } else {
          thread setphase(0);
        }

        break;
      case 3:
        if(isDefined(self.p1) && self.p1 scripts\cp_mp\utility\player_utility::_isalive()) {
          thread setphase(1);
        } else {
          thread setphase(0);
        }

        break;
      case 4:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger)) {
          thread setphase(4);
        } else {
          thread setphase(0);
        }

        break;
      case 5:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger)) {
          thread setphase(4);
        } else {
          thread setphase(0);
        }

        break;
      case 6:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger)) {
          thread setphase(4);
        } else {
          thread setphase(0);
        }

        break;
      case 7:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger)) {
          thread setphase(4);
        } else {
          thread setphase(0);
        }

        break;
    }
  }
}

function usetriggerholdloop(var0, var1) {
  while(usetest(var0, var1)) {
    var0.curprogress += 50 * var0.userate;

    if(var0.curprogress >= var0.usetime) {
      return var1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function usetest(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!var1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var1 useButtonPressed()) {
    return false;
  }

  if(var1 scripts\cp\cp_weapon::grenadeinpullback()) {
    return false;
  }

  if(var1 meleeButtonPressed()) {
    return false;
  }

  if(var0.curprogress >= var0.usetime) {
    return false;
  }

  return true;
}

function preparetohoist() {
  disabletrigger(self.initialtrigger);
  self endon("traverseassist_cancelled");
  thread watchplayeruseButtonPressed(self.p1);
  thread cancelonuserelease(self.p1, "SetPhase3");
  thread create_player_rig(self.p1, "hoister");
  var0 = thread playeranimsingle(self.p1, "hoist_ready");
  wait var0;
  createboosttrigger();
  thread watchdeath(self.p1);
  thread watchdisconnect(self.p1);
  thread playeranimlooping(self.p1, "hoist_ready_idle", "SetPhase3");
}

function dosoloboost() {
  self endon("traverseassist_cancelled");
  thread create_player_rig(self.p1, "climber");
  var0 = thread playeranimsingle(self.p1, "hoist");
  wait var0;
  var0 = playeranimsingle(self.p1, "hoist_n_go");
  wait var0;

  if(level.usequickrope == 1) {
    thread quicktriggertimeout();
  }

  thread setphase(0);
}

function dohoist() {
  self.p2.blockupdatewalldata = 1;
  self endon("traverseassist_cancelled");
  thread playeranimsingle(self.p1, "hoist");
  thread watchplayeruseButtonPressed(self.p1, 2);
  thread create_player_rig(self.p2, "climber");
  var0 = thread playeranimsingle(self.p2, "hoist");
  thread watchplayeruseButtonPressed(self.p2, 2);
  wait var0;

  if(!level.pullbothup) {
    var1 = thread playeranimsingle(self.p1, "hoist_n_go");
    var2 = thread playeranimsingle(self.p2, "hoist_n_go");
    wait var1;
    self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p1.blockupdatewalldata = 0;
    self.p2.blockupdatewalldata = 0;
    thread setphase(4);
  } else {
    var1 = thread playeranimsingle(self.p1, "hoist_n_grab");
    var2 = thread playeranimsingle(self.p2, "hoist_n_grab");
    wait var1;
    self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p1.blockupdatewalldata = 0;
    self.p2.blockupdatewalldata = 0;
    thread setphase(4);
  }

  if(level.usequickrope == 1) {
    thread quicktriggertimeout();
    return;
  }
}

function preparetograb() {
  thread create_player_rig(self.p2, "climber");
  var0 = thread playeranimsingle(self.p2, "grab_ready");
  wait var0;
  thread createpulluptrigger();
  thread playeranimlooping(self.p2, "grab_ready_idle", "SetPhase7");
}

function dograb() {
  self endon("traverseassist_cancelled");
  thread create_player_rig(self.p1, "hoister");
  thread playeranimsingle(self.p1, "grab");
  var0 = thread playeranimsingle(self.p2, "grab");
  wait var0;
  remove_player_rig(self.p1);
  remove_player_rig(self.p2);
  thread setphase(4);
}

function initialtriggerthink() {
  while(isDefined(self.initialtrigger)) {
    self.initialtrigger waittill("trigger", var0);

    if(istrue(var0.takinggunless)) {
      continue;
    }

    disabletrigger(self.initialtrigger);

    if(var0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p1 = var0;
      thread setphase(1);
      continue;
    }

    enabletrigger(self.initialtrigger);
  }
}

function cancelonuserelease(var0, var1) {
  self endon("traverseassist_cancelled");

  if(isDefined(var1)) {
    self endon(var1);
  }

  while(!var0.releasedusebutton) {
    waitframe();
  }

  thread setphase(0);
}

function createboosttrigger() {
  enabletrigger(self.boosttrigger);
  var0 = self.p1 gettagorigin("J_Wrist_RI");
  self.boosttrigger.origin = var0;
  self.boosttrigger linkTo(self.p1, "J_Wrist_RI", (0, 0, 10), (0, 0, 0));

  foreach(var2 in level.players) {
    if(var2 == self.p1) {
      self.boosttrigger disableplayeruse(var2);
      continue;
    }

    self.boosttrigger enableplayeruse(var2);
  }
}

function boosttriggerthink() {
  while(isDefined(self.boosttrigger)) {
    self.boosttrigger waittill("trigger", var0);

    if(istrue(var0.takinggunless)) {
      continue;
    }

    if(var0 == self.p1) {
      continue;
    }

    disabletrigger(self.boosttrigger);

    if(var0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p2 = var0;
      thread setphase(3);
      continue;
    }

    enabletrigger(self.boosttrigger);
  }
}

function giveboostscore(var0) {
  var1 = "buddy_boost";
}

function createtoptrigger() {
  enabletrigger(self.toptrigger);
  var0 = self.p2 gettagorigin("J_Wrist_RI");
  self.toptrigger.origin = var0;
  self.toptrigger linkTo(self.p2, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var2 in level.players) {
    if(var2 != self.p2) {
      self.toptrigger disableplayeruse(var2);
      continue;
    }

    self.toptrigger enableplayeruse(var2);
  }

  thread watchdeath(self.p2);
  thread watchdisconnect(self.p2);
}

function toptriggertrackplayer() {
  if(isDefined(self.topwatchtrigger)) {
    return;
  }

  self endon("traverseassist_cancelled");
  self.topwatchtrigger = spawn("trigger_radius", self.p2.origin, 0, 48, 72);

  for(;;) {
    if(!self.p2 istouching(self.topwatchtrigger)) {
      break;
    }

    waitframe();
  }

  self notify("traverseassist_cancelled");
}

function toptriggerthink() {
  while(isDefined(self.toptrigger)) {
    self.toptrigger waittill("trigger", var0);

    if(var0 != self.p2) {
      continue;
    }

    thread setphase(5);
    self.toptrigger.curprogress = 0;
    self.toptrigger.inuse = 1;
    self.toptrigger.userate = 0;
    self.toptrigger.usetime = 9999;
    var1 = usetriggerholdloop(self.toptrigger, var0);
    self.toptrigger.inuse = 0;
    self.toptrigger.curprogress = 0;

    if(!var1 || !isDefined(var0)) {
      self notify("traverseassist_cancelled");
      break;
    }
  }
}

function createpulluptrigger() {
  enabletrigger(self.pulluptrigger);
  var0 = self.p2 gettagorigin("J_Wrist_RI");
  self.pulluptrigger.origin = var0;
  self.pulluptrigger linkTo(self.p2, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var2 in level.players) {
    if(var2 == self.p2) {
      self.pulluptrigger disableplayeruse(var2);
      continue;
    }

    self.pulluptrigger enableplayeruse(var2);
  }
}

function pulluptriggerthink() {
  while(isDefined(self.pulluptrigger)) {
    self.pulluptrigger waittill("trigger", var0);

    if(var0 == self.p2) {
      continue;
    }

    self.p1 = var0;
    thread setphase(6);
    self.pulluptrigger.curprogress = 0;
    self.pulluptrigger.inuse = 1;
    self.pulluptrigger.userate = 1;
    self.pulluptrigger.usetime = 100;
    var1 = usetriggerholdloop(self.pulluptrigger, var0);
    self.pulluptrigger.inuse = 0;
    self.pulluptrigger.curprogress = 0;

    if(!var1 || !isDefined(var0)) {
      thread setphase(5);
      continue;
    }

    thread setphase(7);
    break;
  }
}

function playeranimsingle(var0, var1) {
  if(getdvarint("scr_buddyboost_force", 2) == 2) {
    var0 setOrigin(self.initialorg.origin);
    var0 setplayerangles(self.initialorg.angles);
  }

  var0 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, var1);
  var2 = getanimlength(level.scr_anim[var0.animname][var1]);
  var3 = getdvarfloat("scr_buddyboost_shave", 0.2);
  return var2 - var3;
}

function playeranimlooping(var0, var1, var2) {
  self endon("traverseassist_cancelled");
  jumpiffalse(isDefined(var2)) LOC_00000014;
  self endon(var2);

  for(;;) {
    var3 = playeranimsingle(var0, var1);
    wait var3;
  }
}

function debug_loopbuddyboostanims() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;

  while(level.players.size < 5) {
    waitframe();
  }

  wait 5;
  var3 = undefined;
  var4 = level.players[0].origin;

  if(getdvarint("scr_buddyboost_school", 0) == 1) {
    var4 = (700, -1600, 70);
  }

  for(var5 = 0;; var5++) {
    jumpiffalse(var5 < level.traversalassist.size) LOC_00000096;
    var6 = distance2d(var4, level.traversalassist[var5].initialorg.origin);

    if(!isDefined(var3) || var6 < var3) {
      var3 = var6;
      var0 = level.traversalassist[var5];
    }
  }

  for(;;) {
    debug_assignroles(var0);
    thread create_player_rig(var0, var0.hoister);
    thread create_player_rig(var0, var0.climber);
    var7 = gettime();
    iprintlnbold("Anim: hoist_ready");
    var8 = thread playeranimsingle(var0, var0.hoister);
    wait var8;
    iprintlnbold("Anim: hoist");
    var8 = thread playeranimsingle(var0, var0.hoister);
    var9 = thread playeranimsingle(var0, var0.climber);
    wait var9;

    switch (getdvarint("scr_buddyboost_flow", 0)) {
      case 0:
        iprintlnbold("Anim: hoist_n_grab");
        var8 = thread playeranimsingle(var0, var0.hoister);
        var9 = thread playeranimsingle(var0, var0.climber);
        wait var9;
        break;
      case 1:
        iprintlnbold("Anim: hoist_n_go");
        var8 = thread playeranimsingle(var0, var0.hoister);
        var9 = thread playeranimsingle(var0, var0.climber);
        wait var9;
        iprintlnbold("Anim: grab_ready");
        var9 = thread playeranimsingle(var0, var0.climber);
        wait var9;
        iprintlnbold("Anim: Grab");
        var8 = thread playeranimsingle(var0, var0.hoister);
        var9 = thread playeranimsingle(var0, var0.climber);
        wait var8;
        break;
    }

    var10 = gettime();
    remove_player_rig(var0.hoister);
    remove_player_rig(var0.climber);
    iprintlnbold("Anim Duration: " + (var10 - var7) / 1000);
    wait 3;
  }
}

function debug_assignroles(var0) {
  var0.hoister = undefined;
  var0.climber = undefined;

  for(var1 = 1; var1 < level.players.size; var1++) {
    if(level.players[var1].team == level.players[0].team) {
      if(!isDefined(var0.hoister)) {
        var0.hoister = level.players[var1];
        continue;
      }

      if(!isDefined(var0.climber)) {
        var0.climber = level.players[var1];
        break;
      }
    }
  }

  if(getdvarint("scr_buddyboost_hoister", 0) != 0) {
    var0.hoister = level.players[0];
  }

  if(getdvarint("scr_buddyboost_climber", 0) != 0) {
    var0.climber = level.players[0];
    return;
  }
}

function watchplayeruseButtonPressed(var0, var1) {
  var0 notify("watchPlayerUseButtonPressed");
  var0 endon("watchPlayerUseButtonPressed");
  var0.releasedusebutton = 0;
  var2 = gettime();

  if(!isDefined(var1)) {
    var3 = undefined;
  } else {
    var3 += var2 * 1000;
  }

  while(!isDefined(var3) || gettime() < var3) {
    if(!var1 useButtonPressed()) {
      var1.releasedusebutton = 1;
      break;
    }

    waitframe();
  }
}

function quicktriggerthink() {
  disabletrigger(self.quicktrigger);

  while(isDefined(self.quicktrigger)) {
    self.quicktrigger waittill("trigger", var0);

    if(istrue(var0.takinggunless)) {
      continue;
    }

    disabletrigger(self.quicktrigger);

    if(var0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      thread create_player_rig(var0, "hoister");
      var1 = thread playeranimsingle(var0, "grab");
      wait var1;
      var0 thread scripts\cp\cp_infilexfil::takegunlesscp();
      remove_player_rig(var0);
    }

    thread quicktriggertimeout();
  }
}

function quicktriggertimeout() {
  enabletrigger(self.quicktrigger);
  disabletrigger(self.initialtrigger);
  self.quickavailable = 1;
  self notify("quickTriggerTimeout");
  self endon("quickTriggerTimeout");
  self.quicktrigger setscriptablepartstate("marker", "contested");
  self.quicktrigger playLoopSound("mp_flare_burn_lp");
  wait 20;
  disabletrigger(self.quicktrigger);
  enabletrigger(self.initialtrigger);
  self.quickavailable = 0;
  self.quicktrigger setscriptablepartstate("marker", "off");
  self.quicktrigger stoploopsound();
}

function spawnhintobjects(var0) {
  if(isDefined(var0)) {
    self.initialorg = spawnStruct();
    self.initialorg.origin = var0.wallscenenodepos;
    self.initialorg.angles = var0.wallscenenodeang;
  }

  var1 = anglesToForward(self.initialorg.angles);
  var2 = anglestoright(self.initialorg.angles);
  var3 = anglestoup(self.initialorg.angles);

  if(isDefined(var0)) {
    self.initialtrigger = var0.wallprompt;
  } else {
    var4 = self.initialorg.origin + var1 * -22 + var3 * 48;
    self.initialtrigger = scripts\cp\utility::createhintobject(var4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  thread initialtriggerthink();
  var4 = self.initialorg.origin + var1 * -10 + var2 * -50 + var3 * 120;
  self.boosttrigger = scripts\cp\utility::createhintobject(var4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  thread boosttriggerthink();
  var4 = self.initialorg.origin + var1 * -10 + var2 * 50 + var3 * 120;
  self.toptrigger = scripts\cp\utility::createhintobject(var4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread toptriggerthink();
  var4 = self.initialorg.origin + var1 * -10 + var2 * -50 + var3 * 150;
  self.pulluptrigger = scripts\cp\utility::createhintobject(var4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread pulluptriggerthink();
  var4 = self.initialorg.origin + var1 * -3 + var3 * 70;
  self.quicktrigger = scripts\cp\utility::createhintobject(var4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  self.quicktrigger setModel("cop_marker_scriptable");
  thread quicktriggerthink();
}

function enabletrigger() {
  self show();
  self makeusable();
}

function disabletrigger() {
  self hide();
  self makeunusable();

  if(self islinked()) {
    self unlink();
    return;
  }
}

function add_contextualwalltraversal_array() {
  level.contextualwalltraversals = [];
  var0 = scripts\engine\utility::getStructArray("contextualwalltraversal", "targetname");

  foreach(var2 in var0) {
    var3 = spawnStruct();
    var3.point0 = var2.origin;
    var3.angles = var2.angles;

    if(isDefined(var2.target)) {
      var4 = scripts\engine\utility::getStruct(var2.target, "targetname");

      if(isDefined(var4)) {
        var3.point1 = var4.origin;
        var3.linesegment = var3.point1 - var3.point0;
        var3.linelengthsq = vectordot(var3.linesegment, var3.linesegment);
      }
    }

    var3.normal = vectorNormalize(anglesToForward(var2.angles) * -1);
    var5 = var3.point0 + var3.normal * 23.5;
    var6 = scripts\engine\utility::drop_to_ground(var5, 50, -200);
    var3.usehigh = var5[2] - var6[2] > 150;
    var3.index = level.contextualwalltraversals.size;
    level.contextualwalltraversals[level.contextualwalltraversals.size] = var3;
  }

  thread updatecontextuawalltraversals();
}

function updatecontextuawalltraversals() {
  var0 = level.framedurationseconds;

  for(;;) {
    foreach(var2 in level.players) {
      if(istrue(var2.blockupdatewalldata)) {
        continue;
      }

      var3 = undefined;

      foreach(var5 in level.contextualwalltraversals) {
        if(isDefined(var2.laddertracking) && istrue(var2.laddertracking[var5.index])) {
          continue;
        }

        var6 = closestpointtowall(var2, var5);

        if(!isDefined(var3) || var6.distsq < var3.distsq) {
          var3 = var6;
        }
      }

      var8 = var2 scripts\cp\utility::_hasperk("specialty_breacher");

      if(!isDefined(var3) || var3.distsq > 490000) {
        if(isDefined(var2.wallprompt)) {
          var2.wallprompt hidefromplayer(var2);
        }

        if(var8 && isDefined(var2.ladderpreviewmodel)) {
          var2.ladderpreviewmodel hidefromplayer(var2);
        }

        continue;
      }

      var9 = var3.closestpoint + var3.wall.normal * 23.5;
      var10 = scripts\engine\utility::drop_to_ground(var9, 50, -200);
      var11 = var9[2] - var10[2] > 150;
      var9 = var10 + (0, 0, 48);

      if(!var8) {
        var10 += var3.wall.normal * -23.5;
      }

      var2.wallscenenodepos = var10;
      var2.wallscenenodeang = var3.wall.angles;
      var2.bestwall = var3;
    }

    waitframe();
  }
}

function closestpointtowall(var0, var1) {
  jumpiftrue(isDefined(var1.point1)) LOC_0000001d;
  var2 = var1.point0;
  goto LOC_00000069;
}

function spawnwallprompt(var0, var1, var2) {
  if(var2) {
    var3 = scripts\cp\utility::createhintobject(var1, "HINT_BUDDY_BOOST", undefined, &"MP/PLACE_LADDER", -10000, "duration_none", undefined, 400, 160, 100, 120);
  } else {
    var3 = scripts\cp\utility::createhintobject(var2, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  var3 dontinterpolate();
  var3.owner = var1;
  var3 hide();
  return var3;
}

function createactivecontextualwalltraversal(var0, var1) {
  if(!isDefined(level.activecontextualwalltraversals)) {
    level.activecontextualwalltraversals = [];
  }

  var2 = spawnStruct();
  var2.type = var1;
  var2.player = var0;

  if(var1 == "buddyBoost") {
    setup_traversalassist(var2, var0);
  } else if(var1 == "ladder") {
    var2 scripts\cp\cp_ladder::setupdynamicladders();
  }

  level.activecontextualwalltraversals[level.activecontextualwalltraversals.size] = var2;
}

function updatecontextualwallpromptforplayer(var0) {
  if(!isDefined(var0.wallprompt)) {
    return;
  }

  var0.wallprompt delete();
  var0.wallprompt = undefined;

  foreach(var2 in level.activecontextualwalltraversals) {
    if(var2.player == var0) {
      var2 = undefined;
      break;
    }
  }

  var4 = var0 scripts\cp\utility::_hasperk("specialty_breacher");
  createactivecontextualwalltraversal(level, var0, scripts\engine\utility::ter_op(var4, "ladder", "buddyBoost"));
}