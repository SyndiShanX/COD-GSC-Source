/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\exfil.gsc
***********************************************/

exfilinit() {
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
}

onexfilstart(var_0, var_1, var_2, var_3) {
  level.getexfilloccallback = var_1;
  level.onexfilfinishedcallback = var_2;
  level.onexfilkilledcallback = var_3;
  level.exfilgoaltrigger = getEnt(var_0 + "_encstr_ADCF0F3740A07D60E9312BFB073F42B7ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.exfilstarted = 1;

  if(isDefined(level.onexfilstarted))
    [[level.onexfilstarted]]();

  if(isDefined(level.objectives) && level.objectives.size > 0)
    thread removeallobjids();

  level.ignorescoring = 1;
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_4 = level.exfilactivetimer + level.exfilextracttimer;
  var_5 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
  level.watchdvars[var_5].value = var_4;
  level.overridewatchdvars[var_5] = var_4;
  runexfil(var_0, var_3);
}

removeallobjids() {
  foreach(var_1 in level.objectives) {
    if(isDefined(var_1.objidnum))
      var_1 scripts\mp\gameobjects::releaseid();

    if(isDefined(var_1.trigger) && isDefined(var_1.trigger.objidnum))
      var_1.trigger scripts\mp\gameobjects::releaseid();
  }
}

runexfil(var_0, var_1) {
  level thread scripts\mp\hud_message::notifyteam("_encstr_9AC816AF2129F4176370EEE940E799D9108343DD3DFBE3FF", "_encstr_A1A9152623D40268A55B49FF8353E2F027183F279F820E", var_0);
  level thread spawnexfilzone(var_0);
  level thread spawnexfilplayers(var_0);
  scripts\mp\utility\dialog::leaderdialog("_encstr_A30D0CB8CD600DD0AE55D0E2D368", scripts\mp\utility\game::getotherteam(var_0)[0], "_encstr_A16D07532531CB4BF7");
  scripts\mp\utility\dialog::leaderdialog("_encstr_82100F7A66A01BCA44C568E7D98051823C", var_0, "_encstr_A16D07532531CB4BF7");
  level.timelimitoverride = 0;
  wait 1;
  level.ontimelimit = ::onexfiltimelimit;
}

spawnexfilplayers(var_0) {
  var_1 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D311D9826EB896";
  level.watchdvars[var_1].value = 1;
  level.overridewatchdvars[var_1] = 1;
  level notify("_encstr_9A571863D0BB302F17D3668BBAF7DB70D2338FC760A650E057EA");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0, 8, 7);
}

skipkillcamandspawn() {
  self notify("_encstr_B6730EE73AE71389B1DA381842565B08");
  self.cancelkillcam = 1;
  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(0, 1);

  if(scripts\mp\utility\game::isteamreviveenabled() && isDefined(level.revivetriggers[self.guid]))
    level.revivetriggers[self.guid].victim thread scripts\mp\teamrevive::removetrigger(level.revivetriggers[self.guid].victim.guid);
}

spawnexfilzone(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(!isDefined(level.exfilgoaltrigger)) {
    var_2 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++)
      var_3[var_3.size] = var_2[var_4];

    foreach(var_6 in var_3) {
      if(var_6.script_label == "_encstr_B40703E96D") {
        var_6.script_label = "_encstr_B40703E96D";
        level.exfilgoaltrigger = var_6;

        if(!isDefined(level.exfilgoaltrigger)) {
          level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");
          return;
        }
      }
    }
  }

  level.exfilgoalent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.exfilgoaltrigger.origin);
  level.exfilgoalent.angles = (0, 270, 0);
  level.exfilgoalent.team = var_1;
  level.exfilgoalent.visibleteam = "_encstr_9A19040BCDBC";
  level.exfilgoalent.ownerteam = var_1;
  level.exfilgoalent.type = "_encstr_B40101";
  var_8 = level.exfilgoaltrigger.origin;
  var_9 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 1);
  var_10 = [];
  var_11 = scripts\engine\trace::ray_trace(level.exfilgoalent.origin + (0, 0, 20), level.exfilgoalent.origin - (0, 0, 4000), var_10, var_9, 0);

  if(isPlayer(var_11["_encstr_850E077B0BF30318B9"]))
    var_11["_encstr_850E077B0BF30318B9"] = undefined;

  if(isDefined(var_11)) {
    var_12 = randomfloat(360);
    var_13 = var_11["_encstr_BD260953AA97E3F014279D"];

    if(isDefined(self.visualgroundoffset))
      var_13 = var_13 + self.visualgroundoffset;

    var_14 = (cos(var_12), sin(var_12), 0);
    var_14 = vectorNormalize(var_14 - var_11["_encstr_820E07FAE8780B3A4C"] * vectordot(var_14, var_11["_encstr_820E07FAE8780B3A4C"]));
    var_15 = vectortoangles(var_14);
    level.exfilgoalent.origin = var_13;
    level.exfilgoalent setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
    level.exfilgoalent setscriptablepartstate("_encstr_912B0778976260C323", "_encstr_8419044EB232");
    level.exfilgoalent playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  }

  level.exfilgoaltrigger thread goaltriggerwatcher(self);
  level.exfilobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(level.exfilobjid != -1) {
    var_16 = "_encstr_AF5A081BBAC993AC73A3";
    scripts\mp\objidpoolmanager::objective_add_objective(level.exfilobjid, var_16, level.exfilgoaltrigger.origin + (0, 0, 60));
    scripts\mp\objidpoolmanager::objective_set_play_intro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_outro(level.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(level.exfilobjid);
    self.showworldicon = 1;
  }

  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("_encstr_95A11CD7B7D88A37D8710852A8705E63B8E77F4F31F442D271D940DF2D70", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A", level.exfilobjid);
  objective_sethot(level.exfilobjid, 1);
  level thread watchforexfilactive(var_0);
  waitframe();
  playFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], level.exfilgoalent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

goaltriggerwatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_85450ED445E87F371DFB49F343672BF3");
  self endon("_encstr_85450ED445E87F371DFB49F343672BF3");
  level waittill("_encstr_8A1D17FA68413A27F1ADCFFC4658F7879BD0C13208E9B40369");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(var_0.team == level.exfilgoalent.team && !istrue(var_0.extracted))
      level thread onexfilsuccess(var_0);
  }
}

watchforexfilactive(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread runexfilnotactivefill(var_0);
  level thread runexfilwaitactiveunfill(var_0);
  var_1 = level.exfilactivetimer;
  wait(var_1);
  level.exfilnotactive = 0;
  level notify("_encstr_8A1D17FA68413A27F1ADCFFC4658F7879BD0C13208E9B40369");
  level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons("_encstr_818C1BB48DEDB9F5EE589783B796DC8EBEB06C1D4BD92BBEB28733A5B1", "_encstr_A1301CC32E5A4009B722CF18902B7DD3302F6BBA90A34073EF33303D6F9A", level.exfilobjid);
}

runexfilnotactivefill(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.exfilnotactive = 1;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = level.exfilactivetimer;
  var_3 = var_3 * 1000;
  var_4 = var_2;

  while(level.exfilnotactive) {
    if(var_4 != 0) {
      var_5 = min(var_4 / var_3, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, undefined);
      scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var_5);
      var_4 = min(var_4 + var_2, var_3);
    }

    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("_encstr_BE9712EBC342934851AA7368D33D99DD9A1F435B", scripts\mp\utility\game::getotherteam(var_0)[0], "_encstr_A16D07532531CB4BF7");
  scripts\mp\utility\dialog::leaderdialog("_encstr_932C15C9F37239C09AB555FC5E601FB3728AF076030460", var_0, "_encstr_A16D07532531CB4BF7");
}

runexfilwaitactiveunfill(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8A1D17FA68413A27F1ADCFFC4658F7879BD0C13208E9B40369");
  level.exfilactive = 1;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = level.exfilextracttimer;
  var_3 = var_3 * 1000;
  var_4 = var_3 - var_2;

  while(level.exfilactive) {
    var_5 = var_4 / var_3;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.exfilobjid, scripts\mp\utility\game::getotherteam(var_0)[0]);
    scripts\mp\objidpoolmanager::objective_show_progress(self.exfilobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.exfilobjid, var_5);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  scripts\mp\utility\dialog::leaderdialog("_encstr_B4C10F79534B7BA89FAE710FCD05B8319F", scripts\mp\utility\game::getotherteam(var_0)[0], "_encstr_A16D07532531CB4BF7");
  scripts\mp\utility\dialog::leaderdialog("_encstr_B10912CFAB550ACC09D823C7F083B1B22DCD1540", var_0, "_encstr_A16D07532531CB4BF7");
}

switchtoexfilweapons(var_0, var_1) {
  level waittill("_encstr_9A571863D0BB302F17D3668BBAF7DB70D2338FC760A650E057EA");
  var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(var_2 != "_encstr_8D19048EA595") {
    foreach(var_4 in level.players) {
      if(var_4.team == var_2) {
        var_4 takeallweapons();
        var_4 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
        var_4 thread switchtoexfilweapon(var_1);
        var_4 scripts\mp\equipment::giveequipment("_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381", "_encstr_BA7F0830B3A7859B60B0");
      }
    }
  }
}

switchtoexfilweapon(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A69E127DC0CCCF52D7B74D275B0580FF2373FBEB");

  while(scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1) == 0)
    waitframe();
}

onexfiltimelimit() {
  level.exfilactive = 0;

  if(level.exfilactive)
    level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");
}

onexfilsuccess(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;
  var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, 1000, undefined, 0);
  var_0 scripts\mp\playeractions::registeractionset("_encstr_84130EF561A0CC2B30CBFB82D1751F02", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_AC20072B9FA9487832", "_encstr_A60F0E030703D180A0665F43BA558F28"]);
  var_0 scripts\mp\playeractions::allowactionset("_encstr_84130EF561A0CC2B30CBFB82D1751F02", 0);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_9A9A165F635DD58FB3F577F3500D6A188F38CDE831E3628B");

  while(!var_0 isonground())
    waitframe();

  var_0 allowmovement(0);
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 playerlinkTo(var_1);
  var_1 moveTo(var_1.origin + (0, 0, 10000), 5, 2, 2);
}

stopunfillthread(var_0) {
  wait(var_0);
  self.exfilactive = 0;
}

assignhelitoexfilpoint(var_0, var_1, var_2) {
  wait(var_1 + randomint(10));
  var_3 = level.players[0] _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::spawnextractchopper(self, self.origin, var_0, 10 + var_1);
  var_3 playLoopSound("_encstr_8F1C1CCA9E4E378055D84A7118B5FADF83886F4538114F4D0B51D32A08A9");
  var_4 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
  var_5 dontinterpolate();
  var_5.angles = (-90, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = anglesToForward(var_3.angles * (1, 0, 0));
  var_7 = vectorNormalize(var_6) * 85;
  var_5 linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_7 + (0, 0, -60), var_5.angles);
  var_3.colmodelent = var_5;
  var_3 sethoverparams(5, 10, 5);
  self.choppers[self.choppers.size] = var_3;
  var_3.extractzone = self;

  if(!isDefined(var_2))
    var_2 = self.team;

  var_3.team = var_2;
  var_3.exfilspace = 6;
  var_3.passengers[0] = self;
  var_3.passengers[1] = self;
  var_3.passengers[2] = self;
  var_3.passengers[3] = self;
  var_3.passengers[4] = self;
  var_3.passengers[5] = self;
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 30);
  var_3 init_useprompt_interactions();
  thread bugoutontimeout(var_3);
  var_3.scene_node = undefined;
  var_8 = undefined;
  var_3 thread exfilpilotactorthink(var_2, var_3.scene_node, var_8);
}

createextractvfx() {
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"), self.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

exfilpilotactorthink(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.actors = thread spawnexfilpilotactors(var_0, var_2, var_3);
  scripts\common\anim::anim_first_frame(self.actors, "_encstr_A9020DB9EB43D7D81FA1D18A17F1C0", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\utility\infilexfil::showactors();

  if(isDefined(self.path))
    exfilactorthinkpath(var_0, var_1, var_2, var_3);
  else
    exfilactorthinkanim(var_0, var_1, var_2, var_3);
}

exfilactorthinkpath(var_0, var_1, var_2, var_3) {
  thread exfilactorloopthink(self.actors[0]);
  thread exfilactorloopthink(self.actors[1]);
}

exfilactorloopthink(var_0) {
  exfilactorloop(var_0);
  scripts\common\anim::anim_single_solo(var_0, "_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

exfilactorloop(var_0) {
  self endon("_encstr_81A8077D3088BFA631");

  for(;;)
    scripts\common\anim::anim_single_solo(var_0, "_encstr_A7C21261193E514B974920807023552E08825D52", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

exfilactorthinkanim(var_0, var_1, var_2, var_3) {
  thread scripts\common\anim::anim_single(self.actors, "_encstr_A9020DB9EB43D7D81FA1D18A17F1C0", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_4 = getanimlength(level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"]);
  wait(var_4);

  foreach(var_6 in self.actors)
  var_6 delete();

  self.actors = undefined;
}

spawnexfilpilotactors(var_0, var_1, var_2) {
  var_3 = [];
  var_3[var_3.size] = exfil_spawn_anim_model("_encstr_A266062032BD7723", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_81951771E3ACA0F63A432B5F2BF34B68773BDE29CA0DC020B2");
  var_3[var_3.size] = exfil_spawn_anim_model("_encstr_9B7408BFEF17BA445893", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", "_encstr_81951771E3ACA0F63A432B5F2BF34B68773BDE29CA0DC020B2");

  foreach(var_5 in var_3)
  var_5.infil = self;

  return var_3;
}

exfil_spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_5.head = var_6;
    var_5 thread scripts\engine\utility::delete_on_death(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "_encstr_8107069A17A718C5", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::delete_on_death(var_7);
    var_5.weapon = var_7;
  }

  var_5.animname = var_0;
  var_5 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_5);
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

bugoutontimeout(var_0) {
  level scripts\engine\utility::waittill_any_two("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7", "_encstr_8DA516B287334BC6BEF637BEB9EAB5ACEBC24E9C5A678536");
  scripts\mp\objidpoolmanager::returnobjectiveid(self.exfilgoalent.exfilobjid);
  thread forcelinkgoaltriggerwatcher(var_0);
  var_0 thread exfilleavesequence(var_0.origin);
}

forcelinkgoaltriggerwatcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_85450ED445E87F371DFB49F343672BF3");
  self endon("_encstr_85450ED445E87F371DFB49F343672BF3");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1.team == self.exfilgoalent.team && !istrue(var_1.extracted)) {
      var_1 thread playeranimlinktochopper(var_0);
      var_0.exfilspace--;

      if(var_0.exfilspace <= 0) {
        break;
      }
    }
  }
}

exfilusetriggerused(var_0, var_1, var_2) {
  if(!isDefined(self.exfilspace))
    self.exfilspace = 6;

  if(self.exfilspace > 0) {
    playerlinktochopper(var_0, self, self.exfilspace);
    thread disableotherseats(var_0, var_1, var_2);
    self.exfilspace--;
  } else {
    thread exfilleavesequence();
    scripts\mp\objidpoolmanager::returnobjectiveid(self.extractzone.exfilgoalent.exfilobjid);
  }
}

waitforsquadthenleave(var_0) {
  var_1 = level.teamdata[var_0.team]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1) {
    if(var_3 != var_0) {
      var_3 thread scripts\mp\utility\print::tutorialprint("_encstr_B85B1E5382D729391D286A54AF9E9326655EA3A815EB3D72FA0D24E9A0142AA4", 10);
      continue;
    }

    var_3 thread scripts\mp\utility\print::tutorialprint("_encstr_BACC248348C159281710545D19DFF0A9E89F2701CF7AD9E57BE98C45C0E33BF1B7178F97A755", 10);
  }

  wait 10;
  thread exfilleavesequence(undefined, 1);
}

disableotherseats(var_0, var_1, var_2) {
  foreach(var_4 in self.interactiontriggers)
  var_4 disableplayeruse(var_0);

  if(isDefined(var_2))
    var_0 thread enableexitprompt(var_1, self, var_2);
}

enableexitprompt(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 linkTo(self);
  var_3 setHintString(&"_encstr_8DA71BA6059742F49844AFA83DBEA3A88ABEE99191F50D24E941051525");
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 sethintonobstruction("_encstr_BECC055CF3811A");
  var_3 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_3 thread exfil_hopoff_think(var_1, self, var_0, var_2);
  var_1.exitinteract = var_3;
}

exfil_hopoff_think(var_0, var_1, var_2, var_3) {
  makechopperseatplayerusable(var_1);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    var_1 stopanimscriptsceneevent();
    var_0 scripts\mp\anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
    var_1.player_rig unlink();
    var_1 unlink();
    var_3 makechopperseatteamusable(var_0.team);

    foreach(var_5 in var_0.interactiontriggers)
    var_5 enableplayeruse(var_1);

    var_0 notify("_encstr_BD82096B5DA4B07F924F29");
    self delete();
  }
}

playerlinktochopper(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;
  var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, 1000, undefined, 0);
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_9A9A165F635DD58FB3F577F3500D6A188F38CDE831E3628B");

  while(!var_0 isonground())
    waitframe();

  var_0 allowmovement(0);
  var_0 playerlinkTo(var_1, "_encstr_96F20EADF9077641FE9B2890221713AB" + var_2, 1.0, 180, -180, 180, 180, 0);
}

playeranimlinktochopper(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0.passengers.size; var_2++) {
      if(var_0.passengers[var_2] == var_0.extractzone) {
        var_0.passengers[var_2] = self;
        var_1 = var_2;
      }
    }

    var_0 thread disableotherseats(self);
  }

  thread scripts\mp\infilexfil\infilexfil::infil_player_rig("_encstr_AC6B06F0DA2281E1" + var_1, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  self.player_rig linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
    case 0:
      self lerpviewangleclamp(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self lerpviewangleclamp(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self lerpviewangleclamp(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self lerpviewangleclamp(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.extracted = 1;
  self.spawnprotection = 1;
  scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
  rideloop(var_0);
}

rideloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_81A8077D3088BFA631");

  while(isDefined(var_0))
    var_0 scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_A7C21261193E514B974920807023552E08825D52", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

exfilleavesequence(var_0, var_1) {
  if(isDefined(self.exitinteract))
    self.exitinteract makeunusable();

  thread _encstr_B6D52CE3C835940B4B0697DD9F780FDEA3401BDBB8E3CABEA1EE9FCDB3FB9366E7A011F2E05F42FBB9D6E6C7CE21::littlebirdleave();
  playannouncerbattlechatter(self.team, "_encstr_925F2662F0D9B2AF4925477CB37323FD13D82A8BB8376DF7610C49665C3E3F494DF0D2727029A57F", 10);
  thread doexfilsplashforpassengers();

  if(isDefined(level.onexfilfinishedcallback))
    self[[level.onexfilfinishedcallback]](var_0);

  if(isDefined(var_1))
    waitthenendgame(self.team);
}

waitthenendgame(var_0) {
  wait 5;
  thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
}

doexfilsplashforpassengers() {
  wait 1;

  for(var_0 = 0; var_0 < self.passengers.size; var_0++) {
    if(self.passengers[var_0] != self.extractzone)
      self.passengers[var_0] thread scripts\mp\hud_message::showsplash("_encstr_9A9A165F635DD58FB3F577F3500D6A188F38CDE831E3628B");
  }
}

init_useprompt_interactions(var_0) {
  self.interactiontriggers = [];
  var_1 = self gettagorigin("_encstr_A3CC0FEB30D11F438BF68A0750BF2AFAB3");
  var_2 = self gettagorigin("_encstr_93CC0FF179CFE9378F3393590A7F655832");
  var_3 = self gettagorigin("_encstr_A1CC0F1DC2767D0EB06E9BB273ECB23933");
  var_4 = self gettagorigin("_encstr_8ECC0F13404778BB59873F951D37C95581");
  var_5 = self gettagorigin("_encstr_B8CC0FF3835F1FE72EDBB741322F8DFB7F");
  var_6 = self gettagorigin("_encstr_ACCC0FA30B76AF0E58B96E56E63B2BC96C");
  create_exfil_interaction(var_1, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 0, var_0);
  create_exfil_interaction(var_2, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 2, var_0);
  create_exfil_interaction(var_3, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 4, var_0);
  create_exfil_interaction(var_4, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 1, var_0);
  create_exfil_interaction(var_5, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 3, var_0);
  create_exfil_interaction(var_6, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 5, var_0);
}

create_exfil_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 linkTo(self);
  var_4 setHintString(var_1);
  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("_encstr_BECC055CF3811A");
  var_4 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_4 thread exfil_use_think(self, var_2, var_3);
  self.interactiontriggers[self.interactiontriggers.size] = var_4;
}

exfil_use_think(var_0, var_1, var_2) {
  if(isDefined(var_2))
    makechopperseatplayerusable(var_2);
  else
    makechopperseatteamusable(var_0.team);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    self makeunusable();
    var_0 exfilusetriggerused(var_2, var_1, self);
  }
}

makechopperseatteamusable(var_0) {
  self makeusable();
  thread _updatechopperseatteamusable(var_0);
}

makechopperseatplayerusable(var_0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var_0);
}

_updatechopperseatteamusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

_updatechopperseatplayerusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

playannouncerbattlechatter(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = "_encstr_8EE40543DB3BD1";
  var_4 = "_encstr_816908616B9751608687" + var_3 + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + var_2;

  if(soundexists(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0)
        var_6 queuedialogforplayer(var_4, var_1, 2);
    }
  }
}

votimeendingsoon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A15F178159EB5191911A2078F2F5B76E4BC596038F2F18D785");
  playannouncerbattlechatter(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_AF822BB23CD14EC28D3AAF63A53AE8D82B315A4E46D7D82B16D9A5CDD9D7CDB7DBDCBE0B7D339CD2ACE646635E", 10);
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

script_model_exfil_anims() {}