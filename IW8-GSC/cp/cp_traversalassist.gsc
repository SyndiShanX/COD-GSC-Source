/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_traversalassist.gsc
***********************************************/

traversal_assist_init() {
  if(!istrue(level.teambased)) {
    return;
  }
  level.usequickrope = getdvarint("_encstr_B42414173E8231E5B30D09033DC78552A3CF889A93D1", 1) == 1;
  level.pullbothup = getdvarint("_encstr_93A01457E07260FE7BBCA9436155BFFF642FC1783308", 1) == 1;
  level.traversalassist = [];
  level.traversalassistmode = 3;

  if(getdvarint("_encstr_B24717A3F9AEE7060861D4C105B00D2FD5165AFA010EE33F58", 1) == 0) {
    return;
  }
  add_traversalassist_array();
  add_contextualwalltraversal_array();

  if(getdvarint("_encstr_858C15D7DE83CFABB8D8F169466AAA63716001B9EE3524", 0) == 1)
    thread debug_loopbuddyboostanims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  if(getdvarint("_encstr_AA17156E36C9AF13AB19235E31F67BDCD1BE99B7C9B1AC", 2) != 0) {
    if(isDefined(self.p1.wallscenenodepos)) {
      self.initialorg.origin = self.p1.wallscenenodepos;
      self.initialorg.angles = self.p1.wallscenenodeang;
    }

    var_0 setOrigin(self.initialorg.origin);
    var_0 setplayerangles(self.initialorg.angles);
  }

  var_0 predictstreampos(self.initialorg.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", self.initialorg.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 0);
  var_0 watch_remove_rig(self);
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

watch_remove_rig(var_0) {
  thread actioncancellation(var_0);
  thread playercancellation();
  self waittill("_encstr_8AA60F91A66EF93E5AA7C7CDBFC1064B3F");
}

actioncancellation(var_0) {
  var_0 waittill("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  self notify("_encstr_8AA60F91A66EF93E5AA7C7CDBFC1064B3F");
}

playercancellation() {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8AA60F91A66EF93E5AA7C7CDBFC1064B3F");
}

add_traversalassist_array() {
  var_0 = getEntArray("_encstr_86D610CBDA29F8FD7397A3B1F74B3ED8D3B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    add_traversalassist(var_3, var_2);
    var_3 thread setup_traversalassist();
    level.traversalassist[level.traversalassist.size] = var_3;
  }
}

disable_traversalassists() {
  foreach(var_1 in level.traversalassist) {
    var_1.initialtrigger makeunusable();
    var_1.boosttrigger makeunusable();
    var_1.toptrigger makeunusable();
    var_1.pulluptrigger makeunusable();

    if(isDefined(var_1.topwatchtrigger))
      var_1.topwatchtrigger makeunusable();
  }
}

add_traversalassist(var_0, var_1) {
  if(!isDefined(var_0.ents))
    var_0.ents = [];

  switch (var_1.classname) {
    case "_encstr_A38E124303C0477207C357B07F1D8725F85596B3":
      var_0.use_trigger = var_1;
      break;
  }

  if(isDefined(var_1.script_noteworthy)) {
    switch (var_1.script_noteworthy) {
      case "_encstr_B4EB0B077D2BDBF1988D55E299":
        var_0.initialorg = var_1;
        break;
      case "_encstr_969B09B027EE51A180F2D4":
        var_0.finalorg = var_1;
        break;
    }
  }

  var_0.ents[var_0.ents.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2)
      add_traversalassist(var_0, var_4);
    }
  }
}

setup_traversalassist(var_0) {
  spawnhintobjects(var_0);
  self.phase = 0;
  setphase(0);
  thread handlephasecancellation();
}

assist_onbeginuse(var_0) {
  self.parent.p1 = var_0;
  self.parent thread setphase(1);
}

assist_onenduse(var_0, var_1, var_2) {
  if(!var_2 && (self.parent.phase == 1 || self.parent.phase == 2))
    self.parent notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
}

watchdeath(var_0) {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  var_1 = var_0.name;
  var_0 waittill("_encstr_AD75063D571AE108");
  self notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
}

watchdisconnect(var_0) {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  var_1 = var_0.name;
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
}

setphase(var_0) {
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
      self notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");

      if(isDefined(self.p1)) {
        self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
        self.p1.blockupdatewalldata = 0;

        if(var_1 != 4)
          self.p1 setOrigin(self.p1 getdroptofloorposition(self.p1.origin));
      }

      if(isDefined(self.p2)) {
        self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
        self.p2.blockupdatewalldata = 0;
      }

      remove_player_rig(self.p1);
      remove_player_rig(self.p2);

      if(!istrue(self.quickavailable))
        self.initialtrigger enabletrigger();

      self.boosttrigger disabletrigger();
      self.toptrigger disabletrigger();
      self.pulluptrigger disabletrigger();

      if(isDefined(self.topwatchtrigger)) {
        self.topwatchtrigger delete();
        self.topwatchtrigger = undefined;
      }

      break;
    case 1:
      if(var_1 == 0) {
        if(istrue(self.p1.hassolobuddyboost) || level.players.size == 1)
          thread dosoloboost();
        else
          thread preparetohoist();
      } else if(var_1 == 2)
        remove_player_rig(self.p2);

      break;
    case 2:
      break;
    case 3:
      self.boosttrigger disabletrigger();
      giveboostscore(self.p1);
      self notify("_encstr_B64A0A51D01CC9225F2737DE");
      thread dohoist();
      break;
    case 4:
      self.toptrigger disabletrigger();
      self.pulluptrigger disabletrigger();

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
      self notify("_encstr_B14A0A4D563A41342CDC959B");
      giveboostscore(self.p2);
      dograb();
      break;
  }
}

handlephasecancellation() {
  for(;;) {
    self waittill("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");

    switch (self.phase) {
      case 0:
        break;
      case 1:
        thread setphase(0);
        break;
      case 2:
        if(isDefined(self.p1) && self.p1 scripts\cp_mp\utility\player_utility::_isalive())
          thread setphase(1);
        else
          thread setphase(0);

        break;
      case 3:
        if(isDefined(self.p1) && self.p1 scripts\cp_mp\utility\player_utility::_isalive())
          thread setphase(1);
        else
          thread setphase(0);

        break;
      case 4:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger))
          thread setphase(4);
        else
          thread setphase(0);

        break;
      case 5:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger))
          thread setphase(4);
        else
          thread setphase(0);

        break;
      case 6:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger))
          thread setphase(4);
        else
          thread setphase(0);

        break;
      case 7:
        if(isDefined(self.p2) && self.p2 scripts\cp_mp\utility\player_utility::_isalive() && isDefined(self.topwatchtrigger) && self.p2 istouching(self.topwatchtrigger))
          thread setphase(4);
        else
          thread setphase(0);

        break;
    }
  }
}

usetriggerholdloop(var_0, var_1) {
  while(usetest(var_0, var_1)) {
    var_0.curprogress = var_0.curprogress + 50 * var_0.userate;

    if(var_0.curprogress >= var_0.usetime)
      return var_1 scripts\cp_mp\utility\player_utility::_isalive();

    waitframe();
  }

  return 0;
}

usetest(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(!var_1 useButtonPressed())
    return 0;

  if(var_1 scripts\cp\cp_weapon::grenadeinpullback())
    return 0;

  if(var_1 meleeButtonPressed())
    return 0;

  if(var_0.curprogress >= var_0.usetime)
    return 0;

  return 1;
}

preparetohoist() {
  self.initialtrigger disabletrigger();
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  thread watchplayeruseButtonPressed(self.p1);
  thread cancelonuserelease(self.p1, "_encstr_B64A0A51D01CC9225F2737DE");
  thread create_player_rig(self.p1, "_encstr_BEF008DC78585A54909D");
  var_0 = thread playeranimsingle(self.p1, "_encstr_934F0C93C70FC359619BE8C09280");
  wait(var_0);
  createboosttrigger();
  thread watchdeath(self.p1);
  thread watchdisconnect(self.p1);
  thread playeranimlooping(self.p1, "_encstr_92D8112A40D8E684A76EF503314F91E3C19895", "_encstr_B64A0A51D01CC9225F2737DE");
}

dosoloboost() {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  thread create_player_rig(self.p1, "_encstr_A9E60821E82117F21B48");
  var_0 = thread playeranimsingle(self.p1, "_encstr_9A7A060DDE4BDC47");
  wait(var_0);
  var_0 = playeranimsingle(self.p1, "_encstr_A6320BA81AB4177B876EA8BC77");
  wait(var_0);

  if(level.usequickrope == 1)
    thread quicktriggertimeout();

  thread setphase(0);
}

dohoist() {
  self.p2.blockupdatewalldata = 1;
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  thread playeranimsingle(self.p1, "_encstr_9A7A060DDE4BDC47");
  thread watchplayeruseButtonPressed(self.p1, 2.0);
  thread create_player_rig(self.p2, "_encstr_A9E60821E82117F21B48");
  var_0 = thread playeranimsingle(self.p2, "_encstr_9A7A060DDE4BDC47");
  thread watchplayeruseButtonPressed(self.p2, 2.0);
  wait(var_0);

  if(!level.pullbothup) {
    var_1 = thread playeranimsingle(self.p1, "_encstr_A6320BA81AB4177B876EA8BC77");
    var_2 = thread playeranimsingle(self.p2, "_encstr_A6320BA81AB4177B876EA8BC77");
    wait(var_1);
    self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p1.blockupdatewalldata = 0;
    self.p2.blockupdatewalldata = 0;
    thread setphase(4);
  } else {
    var_1 = thread playeranimsingle(self.p1, "_encstr_84EA0D92F8A3D703D9F56F5FA540CE");
    var_2 = thread playeranimsingle(self.p2, "_encstr_84EA0D92F8A3D703D9F56F5FA540CE");
    wait(var_1);
    self.p1 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p2 thread scripts\cp\cp_infilexfil::takegunlesscp();
    self.p1.blockupdatewalldata = 0;
    self.p2.blockupdatewalldata = 0;
    thread setphase(4);
  }

  if(level.usequickrope == 1)
    thread quicktriggertimeout();
}

preparetograb() {
  thread create_player_rig(self.p2, "_encstr_A9E60821E82117F21B48");
  var_0 = thread playeranimsingle(self.p2, "_encstr_99FB0BEC278598FA9C95C2465E");
  wait(var_0);
  thread createpulluptrigger();
  thread playeranimlooping(self.p2, "_encstr_A263103C2BC22D7983DB5A1FABE77AA0AC45", "_encstr_B14A0A4D563A41342CDC959B");
}

dograb() {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  thread create_player_rig(self.p1, "_encstr_BEF008DC78585A54909D");
  thread playeranimsingle(self.p1, "_encstr_8572057C52DA0D");
  var_0 = thread playeranimsingle(self.p2, "_encstr_8572057C52DA0D");
  wait(var_0);
  remove_player_rig(self.p1);
  remove_player_rig(self.p2);
  thread setphase(4);
}

initialtriggerthink() {
  while(isDefined(self.initialtrigger)) {
    self.initialtrigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }
    self.initialtrigger disabletrigger();

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p1 = var_0;
      thread setphase(1);
      continue;
    }

    self.initialtrigger enabletrigger();
  }
}

cancelonuserelease(var_0, var_1) {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");

  if(isDefined(var_1))
    self endon(var_1);

  while(!var_0.releasedusebutton)
    waitframe();

  thread setphase(0);
}

createboosttrigger() {
  self.boosttrigger enabletrigger();
  var_0 = self.p1 gettagorigin("_encstr_83190BAD47D7A3B3B20C5E03E4");
  self.boosttrigger.origin = var_0;
  self.boosttrigger linkTo(self.p1, "_encstr_83190BAD47D7A3B3B20C5E03E4", (0, 0, 10), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self.p1) {
      self.boosttrigger disableplayeruse(var_2);
      continue;
    }

    self.boosttrigger enableplayeruse(var_2);
  }
}

boosttriggerthink() {
  while(isDefined(self.boosttrigger)) {
    self.boosttrigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }
    if(var_0 == self.p1) {
      continue;
    }
    self.boosttrigger disabletrigger();

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      self.p2 = var_0;
      thread setphase(3);
      continue;
    }

    self.boosttrigger enabletrigger();
  }
}

giveboostscore(var_0) {
  var_1 = "_encstr_A7CE0C56751992A136F0574F608B";
}

createtoptrigger() {
  self.toptrigger enabletrigger();
  var_0 = self.p2 gettagorigin("_encstr_83190BAD47D7A3B3B20C5E03E4");
  self.toptrigger.origin = var_0;
  self.toptrigger linkTo(self.p2, "_encstr_83190BAD47D7A3B3B20C5E03E4", (0, 0, 0), (0, 0, 0));

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

toptriggertrackplayer() {
  if(isDefined(self.topwatchtrigger)) {
    return;
  }
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
  self.topwatchtrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.p2.origin, 0, 48, 72);

  for(;;) {
    if(!self.p2 istouching(self.topwatchtrigger)) {
      break;
    }

    waitframe();
  }

  self notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
}

toptriggerthink() {
  while(isDefined(self.toptrigger)) {
    self.toptrigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

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
      self notify("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");
      break;
    }
  }
}

createpulluptrigger() {
  self.pulluptrigger enabletrigger();
  var_0 = self.p2 gettagorigin("_encstr_83190BAD47D7A3B3B20C5E03E4");
  self.pulluptrigger.origin = var_0;
  self.pulluptrigger linkTo(self.p2, "_encstr_83190BAD47D7A3B3B20C5E03E4", (0, 0, 0), (0, 0, 0));

  foreach(var_2 in level.players) {
    if(var_2 == self.p2) {
      self.pulluptrigger disableplayeruse(var_2);
      continue;
    }

    self.pulluptrigger enableplayeruse(var_2);
  }
}

pulluptriggerthink() {
  while(isDefined(self.pulluptrigger)) {
    self.pulluptrigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

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

playeranimsingle(var_0, var_1) {
  if(getdvarint("_encstr_AA17156E36C9AF13AB19235E31F67BDCD1BE99B7C9B1AC", 2) == 2) {
    var_0 setOrigin(self.initialorg.origin);
    var_0 setplayerangles(self.initialorg.angles);
  }

  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_1);
  var_2 = getanimlength(level.scr_anim[var_0.animname][var_1]);
  var_3 = getdvarfloat("_encstr_8CE115F241B87702A5D183EFC5401A93702E6ABCB93015", 0.2);
  return var_2 - var_3;
}

playeranimlooping(var_0, var_1, var_2) {
  self endon("_encstr_8FB619045641B33F85C0025AD8DF74EF9BA89B89E0A9278551581A");

  if(isDefined(var_2))
    self endon(var_2);

  for(;;) {
    var_3 = playeranimsingle(var_0, var_1);
    wait(var_3);
  }
}

debug_loopbuddyboostanims() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(level.players.size < 5)
    waitframe();

  wait 5.0;
  var_3 = undefined;
  var_4 = level.players[0].origin;

  if(getdvarint("_encstr_B4E616331262F7CE1B791923C6B0A732DBA71BBA40DFEF1A", 0) == 1)
    var_4 = (700, -1600, 70);

  for(var_5 = 0; var_5 < level.traversalassist.size; var_5++) {
    var_6 = distance2d(var_4, level.traversalassist[var_5].initialorg.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_0 = level.traversalassist[var_5];
    }
  }

  for(;;) {
    debug_assignroles(var_0);
    var_0 thread create_player_rig(var_0.hoister, "_encstr_BEF008DC78585A54909D");
    var_0 thread create_player_rig(var_0.climber, "_encstr_A9E60821E82117F21B48");
    var_7 = gettime();
    iprintlnbold("_encstr_B8FD1201B361A875FEEC5853029377F3D527B048");
    var_8 = var_0 thread playeranimsingle(var_0.hoister, "_encstr_934F0C93C70FC359619BE8C09280");
    wait(var_8);
    iprintlnbold("_encstr_BE230C693713A822D62978980B44");
    var_8 = var_0 thread playeranimsingle(var_0.hoister, "_encstr_9A7A060DDE4BDC47");
    var_9 = var_0 thread playeranimsingle(var_0.climber, "_encstr_9A7A060DDE4BDC47");
    wait(var_9);

    switch (getdvarint("_encstr_86BF149BAA021FE97FD48503AA6F300FEBF12040C29B", 0)) {
      case 0:
        iprintlnbold("_encstr_973B13289B4BAD740286DB4BB98EAFCDBE9D4E1626");
        var_8 = var_0 thread playeranimsingle(var_0.hoister, "_encstr_84EA0D92F8A3D703D9F56F5FA540CE");
        var_9 = var_0 thread playeranimsingle(var_0.climber, "_encstr_84EA0D92F8A3D703D9F56F5FA540CE");
        wait(var_9);
        break;
      case 1:
        iprintlnbold("_encstr_B188119FE8B0CD07E99B6DE47E3929861E38AF");
        var_8 = var_0 thread playeranimsingle(var_0.hoister, "_encstr_A6320BA81AB4177B876EA8BC77");
        var_9 = var_0 thread playeranimsingle(var_0.climber, "_encstr_A6320BA81AB4177B876EA8BC77");
        wait(var_9);
        iprintlnbold("_encstr_9B3B113F050A43D2B0171070FB37139B522F9B");
        var_9 = var_0 thread playeranimsingle(var_0.climber, "_encstr_99FB0BEC278598FA9C95C2465E");
        wait(var_9);
        iprintlnbold("_encstr_8AC10B0DBD4140323627A58BDB");
        var_8 = var_0 thread playeranimsingle(var_0.hoister, "_encstr_8572057C52DA0D");
        var_9 = var_0 thread playeranimsingle(var_0.climber, "_encstr_8572057C52DA0D");
        wait(var_8);
        break;
    }

    var_10 = gettime();
    remove_player_rig(var_0.hoister);
    remove_player_rig(var_0.climber);
    iprintlnbold("_encstr_BD591050309365BABD955A412D20BF6D9DDA" + (var_10 - var_7) / 1000);
    wait 3.0;
  }
}

debug_assignroles(var_0) {
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

  if(getdvarint("_encstr_B29017FBC8D3679A038DF392F56ACA2715D7B09FA99FEBC7BB", 0) != 0)
    var_0.hoister = level.players[0];

  if(getdvarint("_encstr_AF2717A00AA2FF099F3465E30ACF906F8B51A8A042BD3DA1EB", 0) != 0)
    var_0.climber = level.players[0];
}

watchplayeruseButtonPressed(var_0, var_1) {
  var_0 notify("_encstr_AA221CCB7E5C301B318B83BBC77BCDE8E51E3323A3BF90DF2BB7DFB7FFC2");
  var_0 endon("_encstr_AA221CCB7E5C301B318B83BBC77BCDE8E51E3323A3BF90DF2BB7DFB7FFC2");
  var_0.releasedusebutton = 0;
  var_2 = gettime();

  if(!isDefined(var_1))
    var_3 = undefined;
  else
    var_3 = var_2 + var_1 * 1000;

  while(!isDefined(var_3) || gettime() < var_3) {
    if(!var_0 useButtonPressed()) {
      var_0.releasedusebutton = 1;
      break;
    }

    waitframe();
  }
}

quicktriggerthink() {
  self.quicktrigger disabletrigger();

  while(isDefined(self.quicktrigger)) {
    self.quicktrigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(istrue(var_0.takinggunless)) {
      continue;
    }
    self.quicktrigger disabletrigger();

    if(var_0 scripts\cp\cp_infilexfil::givegunlesscp()) {
      thread create_player_rig(var_0, "_encstr_BEF008DC78585A54909D");
      var_1 = thread playeranimsingle(var_0, "_encstr_8572057C52DA0D");
      wait(var_1);
      var_0 thread scripts\cp\cp_infilexfil::takegunlesscp();
      remove_player_rig(var_0);
    }

    thread quicktriggertimeout();
  }
}

quicktriggertimeout() {
  self.quicktrigger enabletrigger();
  self.initialtrigger disabletrigger();
  self.quickavailable = 1;
  self notify("_encstr_8FB51401D540E7BCC9C8C23A78F3B27338B19D876D4B");
  self endon("_encstr_8FB51401D540E7BCC9C8C23A78F3B27338B19D876D4B");
  self.quicktrigger setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_B85C0AD87B9B8E95CD8E2B46");
  self.quicktrigger playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  wait 20.0;
  self.quicktrigger disabletrigger();
  self.initialtrigger enabletrigger();
  self.quickavailable = 0;
  self.quicktrigger setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_BA19049F4B2D");
  self.quicktrigger stoploopsound();
}

spawnhintobjects(var_0) {
  if(isDefined(var_0)) {
    self.initialorg = spawnStruct();
    self.initialorg.origin = var_0.wallscenenodepos;
    self.initialorg.angles = var_0.wallscenenodeang;
  }

  var_1 = anglesToForward(self.initialorg.angles);
  var_2 = anglestoright(self.initialorg.angles);
  var_3 = anglestoup(self.initialorg.angles);

  if(isDefined(var_0))
    self.initialtrigger = var_0.wallprompt;
  else {
    var_4 = self.initialorg.origin + var_1 * -22 + var_3 * 48;
    self.initialtrigger = scripts\cp\utility::createhintobject(var_4, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_B27E1E6A415E4549A059A84AD4A026F550D4D452A6A2EB82A454AF249EE99A45", -10000, undefined, undefined, 400, 160, 100, 120);
  }

  thread initialtriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * -50 + var_3 * 120;
  self.boosttrigger = scripts\cp\utility::createhintobject(var_4, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_A6AC1A4D5B5D0B4614EB98A349BF6DE9E8179A17C3A12FAA402F5314", -10000, undefined, undefined, 400, 160, 100, 120);
  thread boosttriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * 50 + var_3 * 120;
  self.toptrigger = scripts\cp\utility::createhintobject(var_4, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_830D20A9A079A22950655425A6A013BE14A94D29A6457D4125A2D782556231FAAA05", -10000, undefined, undefined, 400, 160, 100, 120);
  thread toptriggerthink();
  var_4 = self.initialorg.origin + var_1 * -10 + var_2 * -50 + var_3 * 150;
  self.pulluptrigger = scripts\cp\utility::createhintobject(var_4, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_A2921CD4415EA82950952A4A355031F5284DA6949A51FA82551326F5AA0A", -10000, undefined, undefined, 400, 160, 100, 120);
  thread pulluptriggerthink();
  var_4 = self.initialorg.origin + var_1 * -3 + var_3 * 70;
  self.quicktrigger = scripts\cp\utility::createhintobject(var_4, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_A2921CD4415EA82950952A4A355031F5284DA6949A51FA82551326F5AA0A", -10000, undefined, undefined, 400, 160, 100, 120);
  self.quicktrigger setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  thread quicktriggerthink();
}

enabletrigger() {
  self show();
  self makeusable();
}

disabletrigger() {
  self hide();
  self makeunusable();

  if(self islinked())
    self unlink();
}

add_contextualwalltraversal_array() {
  level.contextualwalltraversals = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_A1C318964793A3FB287BE8409283ABF833E4A61FB647AB1F56E2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    var_3.point0 = var_2.origin;
    var_3.angles = var_2.angles;

    if(isDefined(var_2.target)) {
      var_4 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_4)) {
        var_3.point1 = var_4.origin;
        var_3.linesegment = var_3.point1 - var_3.point0;
        var_3.linelengthsq = vectordot(var_3.linesegment, var_3.linesegment);
      }
    }

    var_3.normal = vectorNormalize(anglesToForward(var_2.angles) * -1);
    var_5 = var_3.point0 + var_3.normal * 23.5;
    var_6 = scripts\engine\utility::drop_to_ground(var_5, 50.0, -200.0);
    var_3.usehigh = var_5[2] - var_6[2] > 150;
    var_3.index = level.contextualwalltraversals.size;
    level.contextualwalltraversals[level.contextualwalltraversals.size] = var_3;
  }

  level thread updatecontextuawalltraversals();
}

updatecontextuawalltraversals() {
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

        if(!isDefined(var_3) || var_6.distsq < var_3.distsq)
          var_3 = var_6;
      }

      var_8 = var_2 scripts\cp\utility::_hasperk("_encstr_A38D13A343A04392178DFBD0271ADDADFF5E548753");

      if(!isDefined(var_3) || var_3.distsq > 490000) {
        if(isDefined(var_2.wallprompt))
          var_2.wallprompt hidefromplayer(var_2);

        if(var_8 && isDefined(var_2.ladderpreviewmodel))
          var_2.ladderpreviewmodel hidefromplayer(var_2);

        continue;
      }

      var_9 = var_3.closestpoint + var_3.wall.normal * 23.5;
      var_10 = scripts\engine\utility::drop_to_ground(var_9, 50.0, -200.0);
      var_11 = var_9[2] - var_10[2] > 150;
      var_9 = var_10 + (0, 0, 48);

      if(!var_8)
        var_10 = var_10 + var_3.wall.normal * -23.5;

      var_2.wallscenenodepos = var_10;
      var_2.wallscenenodeang = var_3.wall.angles;
      var_2.bestwall = var_3;
    }

    waitframe();
  }
}

closestpointtowall(var_0, var_1) {
  if(!isDefined(var_1.point1))
    var_2 = var_1.point0;
  else {
    var_3 = var_0.origin - var_1.point0;
    var_4 = vectordot(var_3, var_1.linesegment) / var_1.linelengthsq;
    var_4 = clamp(var_4, 0.0, 1.0);
    var_2 = var_1.point0 + var_4 * var_1.linesegment;
  }

  var_5 = var_0.origin - var_2;
  var_6 = vectordot(var_5, var_5);
  var_7 = spawnStruct();
  var_7.closestpoint = var_2;
  var_7.distsq = var_6;
  var_7.wall = var_1;
  return var_7;
}

spawnwallprompt(var_0, var_1, var_2) {
  if(var_2)
    var_3 = scripts\cp\utility::createhintobject(var_1, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_8AC91035D9026AB327E5C0692C0FABD7F945", -10000, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 400, 160, 100, 120);
  else
    var_3 = scripts\cp\utility::createhintobject(var_1, "_encstr_827311DBB13454F18DA5070F8B8F1807BCF923", undefined, &"_encstr_B27E1E6A415E4549A059A84AD4A026F550D4D452A6A2EB82A454AF249EE99A45", -10000, undefined, undefined, 400, 160, 100, 120);

  var_3 dontinterpolate();
  var_3.owner = var_0;
  var_3 hide();
  return var_3;
}

createactivecontextualwalltraversal(var_0, var_1) {
  if(!isDefined(level.activecontextualwalltraversals))
    level.activecontextualwalltraversals = [];

  var_2 = spawnStruct();
  var_2.type = var_1;
  var_2.player = var_0;

  if(var_1 == "_encstr_BDE70BD1CB0BA5581EE75F9F04")
    var_2 setup_traversalassist(var_0);
  else if(var_1 == "_encstr_A7E607E068D02BA2B6")
    var_2 scripts\cp\cp_ladder::setupdynamicladders();

  level.activecontextualwalltraversals[level.activecontextualwalltraversals.size] = var_2;
}

updatecontextualwallpromptforplayer(var_0) {
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

  var_4 = var_0 scripts\cp\utility::_hasperk("_encstr_A38D13A343A04392178DFBD0271ADDADFF5E548753");
  level createactivecontextualwalltraversal(var_0, scripts\engine\utility::ter_op(var_4, "_encstr_A7E607E068D02BA2B6", "_encstr_BDE70BD1CB0BA5581EE75F9F04"));
}