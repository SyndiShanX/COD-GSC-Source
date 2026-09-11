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

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  if(getdvarint("scr_buddyboost_force", 2) != 0) {
    if(isDefined(self.p1.wallscenenodepos)) {
      self.initialorg.origin = self.p1.wallscenenodepos;
      self.initialorg.angles = self.p1.wallscenenodeang;
    }

    var_0 setOrigin(self.initialorg.origin);
    var_0 setplayerangles(self.initialorg.angles);
  }

  var_0 predictstreampos(self.initialorg.origin);
  var_3 = spawn("script_arms", self.initialorg.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var_0, self);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function watch_remove_rig(var_0) {
  thread actioncancellation(var_0);
  thread playercancellation();
  self waittill("can_remove_rig");
}

function actioncancellation(var_0) {
  var_0 waittill("traverseassist_cancelled");
  self notify("can_remove_rig");
}

function playercancellation() {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
  self notify("can_remove_rig");
}

function add_traversalassist_array() {
  var_0 = getEntArray("traversalassist", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    add_traversalassist(var_3, var_2);
    thread setup_traversalassist();
    level.traversalassist[level.traversalassist.size] = var_3;
  }
}

function disable_traversalassists() {
  foreach(var_1 in level.traversalassist) {
    var_1.initialtrigger makeunusable();
    var_1.boosttrigger makeunusable();
    var_1.toptrigger makeunusable();
    var_1.pulluptrigger makeunusable();

    if(isDefined(var_1.topwatchtrigger)) {
      var_1.topwatchtrigger makeunusable();
    }
  }
}

function add_traversalassist(var_0, var_1) {
  if(!isDefined(var_0.ents)) {
    var_0.ents = [];
  }

  switch (var_1.classname) {
    case "trigger_use_touch":
      var_0.use_trigger = var_1;
      break;
  }

  if(isDefined(var_1.script_noteworthy)) {
    switch (var_1.script_noteworthy) {
      case "initialOrg":
        var_0.initialorg = var_1;
        break;
      case "finalOrg":
        var_0.finalorg = var_1;
        break;
    }
  }

  var_0.ents[var_0.ents.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        add_traversalassist(var_0, var_4);
      }

      return;
    }

    return;
  }
}

function setup_traversalassist(var_0) {
  spawnhintobjects(var_0);
  self.phase = 0;
  setphase(0);
  thread handlephasecancellation();
}

function assist_onbeginuse(var_0) {
  self.parent.p1 = var_0;
  thread setphase(self.parent);
}

function assist_onenduse(var_0, var_1, var_2) {
  if(!var_2 && (self.parent.phase == 1 || self.parent.phase == 2)) {
    self.parent notify("traverseassist_cancelled");
    return;
  }
}

function watchdeath(var_0) {
  self endon("traverseassist_cancelled");
  var_1 = var_0.name;
  var_0 waittill("death");
  self notify("traverseassist_cancelled");
}

function watchdisconnect(var_0) {
  self endon("traverseassist_cancelled");
  var_1 = var_0.name;
  var_0 waittill("disconnect");
  self notify("traverseassist_cancelled");
}

function setphase(var_0) {
  var_1 = self.phase;
  self.phase = var_0;

  switch (var_1) {
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

  switch (var_0) {
    case 0:
      self notify("traverseassist_cancelled");

      if(isDefined(self.p1)) {
        self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
        self.p1.blockupdatewalldata = 0;

        if(var_1 != 4) {
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
      if(var_1 == 0) {
        if(istrue(self.p1.hassolobuddyboost) || level.players.size == 1) {
          thread dosoloboost();
        } else {
          thread preparetohoist();
        }
      } else if(var_1 == 2) {
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

function usetriggerholdloop(var_0, var_1) {
  while(usetest(var_0, var_1)) {
    var_0.curprogress += 50 * var_0.userate;

    if(var_0.curprogress >= var_0.usetime) {
      return var_1 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

function usetest(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(!var_1 useButtonPressed()) {
    return false;
  }

  if(var_1 scripts\cp\cp_weapon::grenadeinpullback()) {
    return false;
  }

  if(var_1 meleeButtonPressed()) {
    return false;
  }

  if(var_0.curprogress >= var_0.usetime) {
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
  var_0 = thread playeranimsingle(self.p1, "hoist_ready");
  wait var_0;
  createboosttrigger();
  thread watchdeath(self.p1);
  thread watchdisconnect(self.p1);
  thread playeranimlooping(self.p1, "hoist_ready_idle", "SetPhase3");
}

function dosoloboost() {
  self endon("traverseassist_cancelled");
  thread create_player_rig(self.p1, "climber");
  var_0 = thread playeranimsingle(self.p1, "hoist");
  wait var_0;
  var_0 = playeranimsingle(self.p1, "hoist_n_go");
  wait var_0;

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
  var_0 = thread playeranimsingle(self.p2, "hoist");
  thread watchplayeruseButtonPressed(self.p2, 2);
  wait var_0;

  if(!level.pullbothup) {
    var_1 = thread playeranimsingle(self.p1, "hoist_n_go");
    var_2 = thread playeranimsingle(self.p2, "hoist_n_go");
    wait var_1;
    self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p1.blockupdatewalldata = 0;
    self.p2.blockupdatewalldata = 0;
    thread setphase(4);
  } else {
    var_1 = thread playeranimsingle(self.p1, "hoist_n_grab");
    var_2 = thread playeranimsingle(self.p2, "hoist_n_grab");
    wait var_1;
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
  var_0 = thread playeranimsingle(self.p2, "grab_ready");
  wait var_0;
  thread createpulluptrigger();
  thread playeranimlooping(self.p2, "grab_ready_idle", "SetPhase7");
}

function dograb() {
  self endon("traverseassist_cancelled");
  thread create_player_rig(self.p1, "hoister");
  thread playeranimsingle(self.p1, "grab");
  var_0 = thread playeranimsingle(self.p2, "grab");
  wait var_0;
  remove_player_rig(self.p1);
  remove_player_rig(self.p2);
  thread setphase(4);
}

function initialtriggerthink() {
  while(isDefined(self.initialtrigger)) {
    self.initialtrigger waittill("trigger", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }

    disabletrigger(self.initialtrigger);

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p1 = var_0;
      thread setphase(1);
      continue;
    }

    enabletrigger(self.initialtrigger);
  }
}

function cancelonuserelease(var_0, var_1) {
  self endon("traverseassist_cancelled");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  while(!var_0.releasedusebutton) {
    waitframe();
  }

  thread setphase(0);
}

function createboosttrigger() {
  enabletrigger(self.boosttrigger);
  var_0 = self.p1 gettagorigin("J_Wrist_RI");
  self.boosttrigger.origin = var_0;
  self.boosttrigger linkTo(self.p1, "J_Wrist_RI", (0, 0, 10), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self.p1) {
      self.boosttrigger disableplayeruse(var_2);
      continue;
    }

    self.boosttrigger enableplayeruse(var_2);
  }
}

function boosttriggerthink() {
  while(isDefined(self.boosttrigger)) {
    self.boosttrigger waittill("trigger", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }

    if(var_0 == self.p1) {
      continue;
    }

    disabletrigger(self.boosttrigger);

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p2 = var_0;
      thread setphase(3);
      continue;
    }

    enabletrigger(self.boosttrigger);
  }
}

function giveboostscore(var_0) {
  var_1 = "buddy_boost";
}

function createtoptrigger() {
  enabletrigger(self.toptrigger);
  var_0 = self.p2 gettagorigin("J_Wrist_RI");
  self.toptrigger.origin = var_0;
  self.toptrigger linkTo(self.p2, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 != self.p2) {
      self.toptrigger disableplayeruse(var_2);
      continue;
    }

    self.toptrigger enableplayeruse(var_2);
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
    self.toptrigger waittill("trigger", var_0);

    if(var_0 != self.p2) {
      continue;
    }

    thread setphase(5);
    self.toptrigger.curprogress = 0;
    self.toptrigger.inuse = 1;
    self.toptrigger.userate = 0;
    self.toptrigger.usetime = 9999;
    var_1 = usetriggerholdloop(self.toptrigger, var_0);
    self.toptrigger.inuse = 0;
    self.toptrigger.curprogress = 0;

    if(!var_1 || !isDefined(var_0)) {
      self notify("traverseassist_cancelled");
      break;
    }
  }
}

function createpulluptrigger() {
  enabletrigger(self.pulluptrigger);
  var_0 = self.p2 gettagorigin("J_Wrist_RI");
  self.pulluptrigger.origin = var_0;
  self.pulluptrigger linkTo(self.p2, "J_Wrist_RI", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self.p2) {
      self.pulluptrigger disableplayeruse(var_2);
      continue;
    }

    self.pulluptrigger enableplayeruse(var_2);
  }
}

function pulluptriggerthink() {
  while(isDefined(self.pulluptrigger)) {
    self.pulluptrigger waittill("trigger", var_0);

    if(var_0 == self.p2) {
      continue;
    }

    self.p1 = var_0;
    thread setphase(6);
    self.pulluptrigger.curprogress = 0;
    self.pulluptrigger.inuse = 1;
    self.pulluptrigger.userate = 1;
    self.pulluptrigger.usetime = 100;
    var_1 = usetriggerholdloop(self.pulluptrigger, var_0);
    self.pulluptrigger.inuse = 0;
    self.pulluptrigger.curprogress = 0;

    if(!var_1 || !isDefined(var_0)) {
      thread setphase(5);
      continue;
    }

    thread setphase(7);
    break;
  }
}

function playeranimsingle(var_0, var_1) {
  if(getdvarint("scr_buddyboost_force", 2) == 2) {
    var_0 setOrigin(self.initialorg.origin);
    var_0 setplayerangles(self.initialorg.angles);
  }

  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_1);
  var_2 = getanimlength(level.scr_anim[var_0.animname][var_1]);
  var_3 = getdvarfloat("scr_buddyboost_shave", 0.2);
  return var_2 - var_3;
}

function playeranimlooping(var_0, var_1, var_2) {
  self endon("traverseassist_cancelled");
  jumpiffalse(isDefined(var_2)) LOC_00000014;
  self endon(var_2);

  for(;;) {
    var_3 = playeranimsingle(var_0, var_1);
    wait var_3;
  }
}

function debug_loopbuddyboostanims() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(level.players.size < 5) {
    waitframe();
  }

  wait 5;
  var_3 = undefined;
  var_4 = level.players[0].origin;

  if(getdvarint("scr_buddyboost_school", 0) == 1) {
    var_4 = (700, -1600, 70);
  }

  for(var_5 = 0;; var_5++) {
    jumpiffalse(var_5 < level.traversalassist.size) LOC_00000096;
    var_6 = distance2d(var_4, level.traversalassist[var_5].initialorg.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_0 = level.traversalassist[var_5];
    }
  }

  for(;;) {
    debug_assignroles(var_0);
    thread create_player_rig(var_0, var_0.hoister);
    thread create_player_rig(var_0, var_0.climber);
    var_7 = gettime();
    iprintlnbold("Anim: hoist_ready");
    var_8 = thread playeranimsingle(var_0, var_0.hoister);
    wait var_8;
    iprintlnbold("Anim: hoist");
    var_8 = thread playeranimsingle(var_0, var_0.hoister);
    var_9 = thread playeranimsingle(var_0, var_0.climber);
    wait var_9;

    switch (getdvarint("scr_buddyboost_flow", 0)) {
      case 0:
        iprintlnbold("Anim: hoist_n_grab");
        var_8 = thread playeranimsingle(var_0, var_0.hoister);
        var_9 = thread playeranimsingle(var_0, var_0.climber);
        wait var_9;
        break;
      case 1:
        iprintlnbold("Anim: hoist_n_go");
        var_8 = thread playeranimsingle(var_0, var_0.hoister);
        var_9 = thread playeranimsingle(var_0, var_0.climber);
        wait var_9;
        iprintlnbold("Anim: grab_ready");
        var_9 = thread playeranimsingle(var_0, var_0.climber);
        wait var_9;
        iprintlnbold("Anim: Grab");
        var_8 = thread playeranimsingle(var_0, var_0.hoister);
        var_9 = thread playeranimsingle(var_0, var_0.climber);
        wait var_8;
        break;
    }

    var_10 = gettime();
    remove_player_rig(var_0.hoister);
    remove_player_rig(var_0.climber);
    iprintlnbold("Anim Duration: " + (var_10 - var_7) / 1000);
    wait 3;
  }
}

function debug_assignroles(var_0) {
  var_0.hoister = undefined;
  var_0.climber = undefined;

  for(var_1 = 1; var_1 < level.players.size; var_1++) {
    if(level.players[var_1].team == level.players[0].team) {
      if(!isDefined(var_0.hoister)) {
        var_0.hoister = level.players[var_1];
        continue;
      }

      if(!isDefined(var_0.climber)) {
        var_0.climber = level.players[var_1];
        break;
      }
    }
  }

  if(getdvarint("scr_buddyboost_hoister", 0) != 0) {
    var_0.hoister = level.players[0];
  }

  if(getdvarint("scr_buddyboost_climber", 0) != 0) {
    var_0.climber = level.players[0];
    return;
  }
}

function watchplayeruseButtonPressed(var_0, var_1) {
  var_0 notify("watchPlayerUseButtonPressed");
  var_0 endon("watchPlayerUseButtonPressed");
  var_0.releasedusebutton = 0;
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_3 = undefined;
  } else {
    var_3 += var_2 * 1000;
  }

  while(!isDefined(var_3) || gettime() < var_3) {
    if(!var_1 useButtonPressed()) {
      var_1.releasedusebutton = 1;
      break;
    }

    waitframe();
  }
}

function quicktriggerthink() {
  disabletrigger(self.quicktrigger);

  while(isDefined(self.quicktrigger)) {
    self.quicktrigger waittill("trigger", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }

    disabletrigger(self.quicktrigger);

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      thread create_player_rig(var_0, "hoister");
      var_1 = thread playeranimsingle(var_0, "grab");
      wait var_1;
      var_0 thread scripts\cp\cp_infilexfil::takegunlesscp();
      remove_player_rig(var_0);
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

function spawnhintobjects(var_0) {
  if(isDefined(var_0)) {
    self.initialorg = spawnStruct();
    self.initialorg.origin = var_0.wallscenenodepos;
    self.initialorg.angles = var_0.wallscenenodeang;
  }

  var_1 = anglesToForward(self.initialorg.angles);
  var_2 = anglestoright(self.initialorg.angles);
  var_3 = anglestoup(self.initialorg.angles);

  if(isDefined(var_0)) {
    self.initialtrigger = var_0.wallprompt;
  } else {
    var_4 = self.initialorg.origin + var_1 * -22 + var_3 * 48;
    self.initialtrigger = scripts\cp\utility::createhintobject(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  thread initialtriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * -50 + var_3 * 120;
  self.boosttrigger = scripts\cp\utility::createhintobject(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  thread boosttriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * 50 + var_3 * 120;
  self.toptrigger = scripts\cp\utility::createhintobject(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread toptriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * -50 + var_3 * 150;
  self.pulluptrigger = scripts\cp\utility::createhintobject(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
  thread pulluptriggerthink();
  var_4 = self.initialorg.origin + var_1 * -3 + var_3 * 70;
  self.quicktrigger = scripts\cp\utility::createhintobject(var_4, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PULL_UP", -10000, undefined, undefined, 400, 160, 100, 120);
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
  var_0 = scripts\engine\utility::getStructArray("contextualwalltraversal", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    var_3.point0 = var_2.origin;
    var_3.angles = var_2.angles;

    if(isDefined(var_2.target)) {
      var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");

      if(isDefined(var_4)) {
        var_3.point1 = var_4.origin;
        var_3.linesegment = var_3.point1 - var_3.point0;
        var_3.linelengthsq = vectordot(var_3.linesegment, var_3.linesegment);
      }
    }

    var_3.normal = vectorNormalize(anglesToForward(var_2.angles) * -1);
    var_5 = var_3.point0 + var_3.normal * 23.5;
    var_6 = scripts\engine\utility::drop_to_ground(var_5, 50, -200);
    var_3.usehigh = var_5[2] - var_6[2] > 150;
    var_3.index = level.contextualwalltraversals.size;
    level.contextualwalltraversals[level.contextualwalltraversals.size] = var_3;
  }

  thread updatecontextuawalltraversals();
}

function updatecontextuawalltraversals() {
  var_0 = level.framedurationseconds;

  for(;;) {
    foreach(var_2 in level.players) {
      if(istrue(var_2.blockupdatewalldata)) {
        continue;
      }

      var_3 = undefined;

      foreach(var_5 in level.contextualwalltraversals) {
        if(isDefined(var_2.laddertracking) && istrue(var_2.laddertracking[var_5.index])) {
          continue;
        }

        var_6 = closestpointtowall(var_2, var_5);

        if(!isDefined(var_3) || var_6.distsq < var_3.distsq) {
          var_3 = var_6;
        }
      }

      var_8 = var_2 scripts\cp\utility::_hasperk("specialty_breacher");

      if(!isDefined(var_3) || var_3.distsq > 490000) {
        if(isDefined(var_2.wallprompt)) {
          var_2.wallprompt hidefromplayer(var_2);
        }

        if(var_8 && isDefined(var_2.ladderpreviewmodel)) {
          var_2.ladderpreviewmodel hidefromplayer(var_2);
        }

        continue;
      }

      var_9 = var_3.closestpoint + var_3.wall.normal * 23.5;
      var_10 = scripts\engine\utility::drop_to_ground(var_9, 50, -200);
      var_11 = var_9[2] - var_10[2] > 150;
      var_9 = var_10 + (0, 0, 48);

      if(!var_8) {
        var_10 += var_3.wall.normal * -23.5;
      }

      var_2.wallscenenodepos = var_10;
      var_2.wallscenenodeang = var_3.wall.angles;
      var_2.bestwall = var_3;
    }

    waitframe();
  }
}

function closestpointtowall(var_0, var_1) {
  jumpiftrue(isDefined(var_1.point1)) LOC_0000001d;
  var_2 = var_1.point0;
  goto LOC_00000069;
}

function spawnwallprompt(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = scripts\cp\utility::createhintobject(var_1, "HINT_BUDDY_BOOST", undefined, &"MP/PLACE_LADDER", -10000, "duration_none", undefined, 400, 160, 100, 120);
  } else {
    var_3 = scripts\cp\utility::createhintobject(var_2, "HINT_BUDDY_BOOST", undefined, &"MP/TRAVERSAL_ASSIST_PRE_BOOST", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  var_3 dontinterpolate();
  var_3.owner = var_1;
  var_3 hide();
  return var_3;
}

function createactivecontextualwalltraversal(var_0, var_1) {
  if(!isDefined(level.activecontextualwalltraversals)) {
    level.activecontextualwalltraversals = [];
  }

  var_2 = spawnStruct();
  var_2.type = var_1;
  var_2.player = var_0;

  if(var_1 == "buddyBoost") {
    setup_traversalassist(var_2, var_0);
  } else if(var_1 == "ladder") {
    var_2 scripts\cp\cp_ladder::setupdynamicladders();
  }

  level.activecontextualwalltraversals[level.activecontextualwalltraversals.size] = var_2;
}

function updatecontextualwallpromptforplayer(var_0) {
  if(!isDefined(var_0.wallprompt)) {
    return;
  }

  var_0.wallprompt delete();
  var_0.wallprompt = undefined;

  foreach(var_2 in level.activecontextualwalltraversals) {
    if(var_2.player == var_0) {
      var_2 = undefined;
      break;
    }
  }

  var_4 = var_0 scripts\cp\utility::_hasperk("specialty_breacher");
  createactivecontextualwalltraversal(level, var_0, scripts\engine\utility::ter_op(var_4, "ladder", "buddyBoost"));
}