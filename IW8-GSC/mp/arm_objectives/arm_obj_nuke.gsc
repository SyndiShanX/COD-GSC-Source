/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\arm_objectives\arm_obj_nuke.gsc
***********************************************/

init() {}

objectivesetup() {
  debugprint("_encstr_855715DF6F3586CF683837BED3183E6A32615F971965CB");
  level._effect["_encstr_B49E35F4574B97E8B75ACAC837EE2159867CE3F42C53D3D2C70B8860F703FBEB2AA4ED0D835BB3597B97E858B324F017524D50209BB251"] = loadfx("_encstr_AA0E4B604BA8281BB3B02099FFFB5B0857CB10709B5F39F31E4B8C9B45E2B73A0FB3C87037ECB8E98237F3242EDB7F3BAE7B91A0DFB1C9A37A5FF5AE03123F4615D370D0CF43C0778295ECBC58");
  initnukeobjectivelocations();
}

debugprint(var_0) {
  if(1)
    return;
}

initnukeobjectivelocations() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_85EA121BA7106257BD21B3692818379E70339F6E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0[randomint(var_0.size)];
  level.objective_nuke = var_1 createuseableobject(var_1.origin, var_1.angles, "_encstr_A98C0D181E4BCA85EFD189A71088D0", &"_encstr_AC8A229BE75FED89D8392839518D07D1BDFFBBD3485918DF296C86BDD3292DB786C5BAED", "_encstr_88180BF63135B2B1A355CD9532");
  level.objective_nuke.curorigin = level.objective_nuke.origin;
  level.objective_nuke.offset3d = (0, 0, 30);

  if(!isDefined(level.objective_nuke.objidnum) || level.objective_nuke.objidnum < 0) {
    level.objective_nuke scripts\mp\gameobjects::requestid(1, 1);
    setupobjectobjective(level.objective_nuke, "_encstr_BAAA13DC622751D6B08F3113DF7810E1951507541F");
  }
}

setupobjectobjective(var_0, var_1) {
  var_2 = var_0.objidnum;
  objective_state(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_setlabel(var_2, var_1);
  objective_setzoffset(var_2, 30);
  objective_icon(var_2, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  objective_setplayintro(var_2, 0);
  objective_sethot(var_2, 1);
  objective_showtoplayersinmask(var_2);
  objective_setbackground(var_2, 1);
  objective_position(var_2, var_0.origin + (0, 0, 50));
  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
}

watchobjuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 waittill("_encstr_88180BF63135B2B1A355CD9532", var_1);
    nukeused(var_0, var_1);
  }
}

shownukelocation(var_0) {
  if(!isDefined(level.objective_nuke)) {
    return;
  }
  thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::playnukeintrovo(var_0);

  foreach(var_2 in scripts\mp\utility\player::getteamarray(var_0.team))
  objective_addclienttomask(level.objective_nuke.objidnum, var_2);

  if(!istrue(level.nukespotted)) {
    level.nukespoted = 1;

    foreach(var_5 in level.players) {
      if(var_5.team != var_0.team)
        continue;
    }
  }
}

hidenukefromeveryone() {
  foreach(var_1 in level.players)
  objective_removeclientfrommask(level.objective_nuke.objidnum, var_1);
}

hidenukefromplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.objective_nuke)) {
    return;
  }
  objective_removeclientfrommask(level.objective_nuke.objidnum, var_0);
  thread watchobjuse(var_0);
}

nukeused(var_0, var_1) {
  setgameendtime(0);
  level.scorelimitoverride = 1;
  wait 3;
  var_2 = 10 - level.players.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = vectorNormalize(var_0 getEye() - var_1.origin);
    var_5 = var_1.origin + (randomfloat(1024), randomfloat(1024), 0);
    playFX(level._effect["_encstr_B49E35F4574B97E8B75ACAC837EE2159867CE3F42C53D3D2C70B8860F703FBEB2AA4ED0D835BB3597B97E858B324F017524D50209BB251"], var_5, var_4);
    earthquake(0.245, 2.2, var_5, 50000);
    playrumbleonposition("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", var_5);
    wait(0.5 + randomfloat(0.5));
  }

  foreach(var_7 in level.players) {
    if(var_7.team == var_0.team) {
      continue;
    }
    var_4 = vectorNormalize(var_7 getEye() - var_0.origin);
    playFX(level._effect["_encstr_B49E35F4574B97E8B75ACAC837EE2159867CE3F42C53D3D2C70B8860F703FBEB2AA4ED0D835BB3597B97E858B324F017524D50209BB251"], var_7.origin, var_4);
    earthquake(0.245, 2.2, var_7.origin, 50000);
    playrumbleonposition("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB", var_7.origin);
    wait(0.5 + randomfloat(0.5));
    var_7 kill();
  }

  thread playnukeusedvo(var_0);
  wait 5;
  level.finalkillcam_winner = var_0.team;
  thread scripts\mp\gamelogic::endgame(var_0.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"], undefined, 1, 0);
}

createuseableobject(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5 setnodeploy(1);
  var_5.targetname = "_encstr_A3520E95F27AEB694C8F6918AB9D8109";
  var_5 setModel(var_2);
  var_5.angles = var_1;
  var_5.useobj = scripts\mp\gameobjects::createhintobject(var_5.origin + anglestoup(var_5.angles) * 7, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_3, -3, undefined, "_encstr_BD1805CB69C063", 250, 160, 200, 160);
  var_5.useobj linkTo(var_5);
  var_5.useobj.waitmsg = var_4;

  foreach(var_7 in level.players)
  var_5.useobj disableplayeruse(var_7);

  var_5 thread usethink();
  return var_5;
}

usethink() {
  self endon("_encstr_A517132A055FFBA18B687763D8068882E3A674E6F6");
  var_0 = self.useobj;
  var_1 = undefined;

  if(istrue(level.gameended) && !isDefined(var_0)) {
    return;
  }
  while(isDefined(self)) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_2.isusingobject = 1;
    var_1 = createuseent();
    var_1.id = "_encstr_AB19049D0FC0";
    var_3 = var_1 useholdthink(var_2, 15);

    if(!isDefined(var_2)) {
      return;
    }
    if(!var_3) {
      var_2.isusingobject = 0;
      continue;
    }

    var_2.isusingobject = 0;
    var_2 notify(var_0.waitmsg, self);
  }
}

useholdthink(var_0, var_1) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var_1;
  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0))
    var_0 scripts\common\utility::allow_weapon(1);

  if(isDefined(var_0))
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

useholdthinkloop(var_0) {
  while(var_0 isplayerusing(self)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return 0;
    }

    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler))
      self.userate = 1 * self.objectivescaler;
    else
      self.userate = 1;

    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  if(isDefined(self))
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);

  return 0;
}

createuseent() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_0 linkTo(self);
  var_0 thread deleteuseent(self);
  return var_0;
}

deleteuseent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.usedby)) {
    foreach(var_2 in self.usedby) {
      var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      var_2.ui_securing = undefined;
    }
  }

  self delete();
}

isplayerusing(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

playnukeusedvo(var_0) {
  _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::playplayerbattlechatter(var_0, "_encstr_93B8247B53F38EB0A3DB2658849C50C95A93FBDDDBA9D620F9324B36AE4F187EF2177D095393", 10);
  _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::playannouncerbattlechatter(var_0, "_encstr_93B8247B53F38EB0A3DB2658849C50C95A93FBDDDBA9D620F9324B36AE4F187EF2177D095393", 20);
}