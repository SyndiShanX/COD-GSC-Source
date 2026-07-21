/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_bombzone.gsc
***********************************************/

setupobjective(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(level.curobj))
    level.curobj scripts\mp\gameobjects::deleteuseobject();

  if(isDefined(var_0.originalpos))
    var_0.origin = var_0.originalpos;
  else
    var_0.originalpos = var_0.origin;

  var_5 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0.objectivekey))
    var_6 = var_0.objectivekey;
  else
    var_6 = var_0.script_label;

  if(istrue(var_2))
    var_7 = getreservedobjid(var_6);
  else
    var_7 = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" || scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9") {
    var_4 = var_0.script_label;
    var_8 = getEnt("_encstr_B6B311298409C86067EA8A50523F30889D1189" + var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(scripts\mp\utility\game::inovertime()) {
      if(var_4 == "_encstr_B20703DFCF" || var_4 == "_encstr_B40703E96D") {
        var_0 delete();
        var_5[0] delete();
        var_8 delete();
        return;
      }

      var_3 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_0, var_5, (0, 0, 64), var_7, var_1);
      var_3 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
      var_3.trigger.script_label = "_encstr_B20703DFCF";
    } else if(var_4 == "_encstr_B6070359BA") {
      var_0 delete();
      var_5[0] delete();
      var_8 delete();
      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284")
    setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", 0);

  if(!isDefined(var_3)) {
    var_3 = scripts\mp\gameobjects::createuseobject(game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_0, var_5, (0, 0, 64), var_7, var_1);
    var_3 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  }

  if(isDefined(var_0.objectivekey))
    var_3.objectivekey = var_0.objectivekey;
  else
    var_3.objectivekey = var_3 scripts\mp\gameobjects::getlabel();

  if(isDefined(var_0.iconname))
    var_3.iconname = var_0.iconname;
  else
    var_3.iconname = var_3 scripts\mp\gameobjects::getlabel();

  var_3.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  var_3.trigger setusepriority(-3);
  var_3 scripts\mp\gameobjects::setusetime(level.planttime);
  var_3 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_3 scripts\mp\gameobjects::setusehinttext(&"_encstr_86521C40F31A48B789C00EA1E87719B36165B94985B9F1294046695955AA");
  var_3.trigger setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");

  if(!level.multibomb)
    var_3 scripts\mp\gameobjects::setkeyobject(level.sdbomb);

  if(var_3.objectivekey == "_encstr_B6070359BA") {
    var_3.objectivekey = "_encstr_B20703DFCF";
    var_3.iconname = "_encstr_B20703DFCF";
  }

  if((scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9" || scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182") && scripts\mp\utility\game::inovertime()) {
    var_3 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8F361077FED381AD0833C589FCA8DA67776B");
    var_3 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  }

  var_3.onbeginuse = ::bombzone_onbeginuse;
  var_3.onenduse = ::bombzone_onenduse;
  var_3.onuse = ::bombzone_onuseplantobject;
  var_3.oncantuse = ::bombzone_oncantuse;
  var_3.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
  var_3.bombplanted = 0;
  var_3.bombexploded = undefined;
  var_3.resetprogress = level.resetprogress;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    if(isDefined(var_5[var_9].script_exploder)) {
      var_3.exploderindex = var_5[var_9].script_exploder;
      var_5[var_9] thread setupkillcament(var_3);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA") {
    var_3.bombdefusetrig = getEnt(var_5[0].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3.bombdefusetrig.origin = var_3.bombdefusetrig.origin + (0, 0, -10000);
    var_3.bombdefusetrig.label = var_4;
  } else {
    var_10 = getEnt(var_5[0].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 delete();
    var_3.bombdefusetrig = var_3.trigger;
  }

  var_3.noweapondropallowedtrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.trigger.origin, 0, 140, 100);
  return var_3;
}

getreservedobjid(var_0) {
  if(var_0 == "_encstr_B20703DFCF")
    var_1 = 0;
  else
    var_1 = 1;

  return var_1;
}

setupkillcament(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["_encstr_BD260953AA97E3F014279D"];

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case "_encstr_AB5D0960CBB77E40E7D955":
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      if(var_0.objectivekey == "_encstr_B20703DFCF")
        var_2 = (1373, 2048, 213);

      break;
    default:
      break;
  }

  self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

allowedwhileplanting(var_0) {
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);

  if(var_0) {
    scripts\engine\utility::_id_143B9(0.8, "_encstr_A5DB1426DB5B26D70B36B17BDDD7EDCC3343B0B9C837");
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  } else {
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  }

  scripts\common\utility::allow_offhand_weapons(var_0);
}

setbombplantingomnvar(var_0) {
  wait 0.35;

  if(var_0 == "_encstr_B20703DFCF")
    var_1 = 1;
  else
    var_1 = 2;

  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", var_1);
}

setbombdefusingomnvar(var_0) {
  wait 0.35;

  if(var_0 == "_encstr_B20703DFCF")
    var_1 = 3;
  else
    var_1 = 4;

  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", var_1);
}

bombzone_onbeginuse(var_0) {
  var_0 thread allowedwhileplanting(0);

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"]) && self.bombplanted) {
    if(level.codcasterenabled)
      var_0 setgametypevip(1);

    var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("_encstr_830C078CCA33ABB959");
    var_0 notify("_encstr_92661027570F970339F8A6D2D8D17D51608D");
    var_0.isdefusing = 1;
    var_0 thread setbombdefusingomnvar(self.objectivekey);
    setomnvar("_encstr_BD7B101550D84D98AABE2F51A7E0EB1B6372", var_0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AC9D18EB87CB3B2F68388327708015A22FADF7277D3DB257D090", "_encstr_BDA717274F5BF7A8B1456B066E6F6026D1A38B9DB74333E8D7");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var_0.team);
    scripts\mp\utility\game::setmlgannouncement(2, var_0.team, var_0 getentitynumber());

    if(isDefined(level.sdbombmodel))
      level.sdbombmodel hide();
    else if(isDefined(level.ddbombmodel[self.objectivekey]))
      level.ddbombmodel[self.objectivekey] hide();

    var_0 thread startnpcbombusesound("_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B", "_encstr_8FB11CBBCAC20EBEDC5DD2E8B1B0B959AF4695CC5737ACFA13AB3A8E7B37");
  } else {
    var_1 = 2;

    if(self.objectivekey == "_encstr_B20703DFCF")
      var_1 = 1;

    var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("_encstr_A24E069389FFAA3C");
    var_0 notify("_encstr_92661027570F970339F8A6D2D8D17D51608D");
    var_0.isplanting = 1;
    var_0.bombplantweapon = self.useweapon;
    var_0 thread setbombplantingomnvar(self.objectivekey);
    scripts\mp\utility\dialog::statusdialog("_encstr_A1DC0E3527D2B6C75F8D09559BBCF6F8" + self.objectivekey, var_0.team, "_encstr_A16D07532531CB4BF7");
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_BEB0175F88AAF87A43A083719E6712B236684B8F68A329B2A7");
    var_0 thread startnpcbombusesound("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B", "_encstr_99301BB7CF4A67991B3358F35EF19B15410B13333F52B838354BE36805");
  }
}

bombzone_onenduse(var_0, var_1, var_2) {
  if(var_2 && istrue(var_1.isdefusing))
    setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);

  setomnvar("_encstr_BD7B101550D84D98AABE2F51A7E0EB1B6372", -1);
  var_3 = self.objidnum;

  if(level.resetprogress) {
    scripts\mp\objidpoolmanager::objective_set_progress(var_3, 0);
    scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);
  }

  if(!var_2) {
    if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0)
      self.showprogressforteam = undefined;

    if(var_1.isdefusing)
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_845713ABEFF337D863A6AC51A3053678ABCDF87AF9", "_encstr_AC9D18EB87CB3B2F68388327708015A22FADF7277D3DB257D090");
    else if(scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5")
      scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
    else
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");

    if(isDefined(self.radialtimeobjid))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var_1.team);
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread allowedwhileplanting(1);
  var_1.bombplantweapon = undefined;

  if(isalive(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_bomb_planting_defusing = undefined;
  }

  if(scripts\mp\gameobjects::isfriendlyteam(var_1.pers["_encstr_8AEF05472BC2D6"])) {
    if(level.codcasterenabled)
      var_1 setgametypevip(0);
  } else if(isDefined(level.sdbombmodel) && !var_2) {
    if(self.bombplanted)
      level.sdbombmodel show();
  } else if(isDefined(level.ddbombmodel)) {
    if(isDefined(level.ddbombmodel[self.objectivekey]) && !var_2)
      level.ddbombmodel[self.objectivekey] show();
  }
}

startnpcbombusesound(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A59116B43BFC789EA936D3FB55659B77F7A01");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565")) {
    self setentitysoundcontext("_encstr_B8BA0D53AA8B85403377C1C1719D58", "_encstr_AB0703DBB9");
    return;
  }

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_2);

    if(var_2.basename == var_0) {
      break;
    }
  }

  self playsoundtoteam(var_1, self.team, self);
  var_3 = scripts\mp\utility\game::getotherteam(self.team)[0];
  self playsoundtoteam(var_1, var_3);
  self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self notify("_encstr_8A59116B43BFC789EA936D3FB55659B77F7A01");
}

bombzone_oncantuse(var_0) {}

bombzone_onuseplantobject(var_0) {
  if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0 || !scripts\mp\gameobjects::isfriendlyteam(var_0.pers["_encstr_8AEF05472BC2D6"])) {
    self.showprogressforteam = undefined;
    level thread bombzone_onbombplanted(self, var_0);
    var_0 playSound("_encstr_9A730EB61C7D98BDB6137D07C6C2DC1D");
    var_0 notify("_encstr_AB3D0DE25FE81EF7B7188A42230553");
    var_1 = 2;

    if(self.objectivekey == "_encstr_B20703DFCF")
      var_1 = 1;

    scripts\mp\utility\game::setmlgannouncement(0, var_0.team, var_0 getentitynumber(), var_1);
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_8FB00783D8C2CDE8DC", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8FB00783D8C2CDE8DC", var_0.pers["_encstr_8FB00783D8C2CDE8DC"]);
    var_0 scripts\cp_mp\pet_watch::addplantingcharge();
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_8FB00783D8C2CDE8DC"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team]))
      var_0 thread removebombcarrierclass();

    if(scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182") {
      if(scripts\mp\utility\game::inovertime())
        scripts\mp\utility\dialog::statusdialog("_encstr_84B513CA73CADABC7D98BDDAC4AF0E63B0B9D156C8", scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);
      else
        scripts\mp\utility\dialog::statusdialog("_encstr_B4780BBF35437AD7D97320883B" + self.objectivekey, scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);

      scripts\mp\utility\dialog::statusdialog("_encstr_AB3D0DE25FE81EF7B7188A42230553", var_0.team, 1);
    }

    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_BDC714DE36AAB188158BA958FF5561C1D25EC0DD8F82", var_0);
    level.bombowner = var_0;
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A24E069389FFAA3C");
    var_0.bombplantedtime = gettime();

    if(isPlayer(var_0)) {
      var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12062();
      var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A24E069389FFAA3C", var_0.origin);
    }
  }
}

bombzone_onusedefuseobject(var_0) {
  var_1 = 0;
  setomnvar("_encstr_9131145D2DFA31DBD698BED2B9E82B4E581B8EA5B9EC", 0);

  foreach(var_3 in level.objectives) {
    if(isDefined(var_3.objectivekey) && var_3.objectivekey == self.objectivekey) {
      var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_3.objectivekey);
      level thread bombdefused(var_3);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA") {
    scripts\mp\gameobjects::disableobject();
    iprintln(&"_encstr_8BBB1989608E9D892A8031C9C8F3FB17F7DC05949D974589C10889", var_0);
  }

  scripts\mp\utility\dialog::statusdialog("_encstr_93E61365C8514FA84FF8120AC077A727692DFB1D55", scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);
  scripts\mp\utility\dialog::statusdialog("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C", var_0.team, 1);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_8296148FDED0FD585863F74830FBF0D9A7B6909213DF", var_0);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1201F();
  scripts\mp\events::bombdefused(var_0);
}

bombzone_onbombplanted(var_0, var_1) {
  level endon("_encstr_9BC10FEA30280BA2C7687A82409B5DAFA1");
  level notify("_encstr_AB3D0DE25FE81EF7B7188A42230553", var_0);
  var_2 = var_1.team;
  level.bombdefused = 0;
  var_0.bombdefused = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" && level.bombsplanted <= 0) {
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
  }

  level.bombplanted = 1;
  level.bombsplanted = level.bombsplanted + 1;

  if(scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5")
    level.timelimitoverride = 1;

  level.defuseendtime = int(gettime() + level.bombtimer * 1000);

  if(var_0.objectivekey == "_encstr_B20703DFCF")
    level.aplanted = 1;
  else
    level.bplanted = 1;

  setbombtimeromnvars(var_1.team);
  level.destroyedobject = var_0;
  level.destroyedobject.bombplanted = 1;

  if(!level.multibomb) {
    var_1 setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 0);
    setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", -1);
    setgameendtime(level.defuseendtime);
  }

  var_0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];

  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    var_3 = removespawnprotectiononnotify();
    level.sdbomb scripts\mp\gameobjects::setdropped(undefined, scripts\engine\utility::ter_op(var_3 > 0, var_3, undefined));
    level.sdbombmodel = level.sdbomb.visuals[0];
    level.sdbombmodel setteaminhuddatafromteamname(var_2);
    level.sdbombmodel setasgametypeobjective();
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182") {} else if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" || scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    level.ddbombmodel[var_0.objectivekey] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    level.ddbombmodel[var_0.objectivekey].angles = var_1.angles;
    level.ddbombmodel[var_0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var_0.objectivekey] setasgametypeobjective();
    level.ddbombmodel[var_0.objectivekey] setnonstick(1);
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9") {
    var_4 = var_0.trigger.origin;
    var_5 = var_0.trigger.angles;
    var_6 = (0, 0, 0);

    if(isDefined(level.tacopssublevel)) {
      if(var_0.objectivekey == "_encstr_B20703DFCF") {
        var_6 = (0, 0, 50);
        var_5 = (-90, -45, 0);
      } else {
        var_6 = (0, 0, 50);
        var_5 = (-90, 90, 0);
      }
    }

    level.ddbombmodel[var_0.objectivekey] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4 + var_6);
    level.ddbombmodel[var_0.objectivekey].angles = var_5;
    level.ddbombmodel[var_0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var_0.objectivekey] setasgametypeobjective();
  } else {
    level.sdbombmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    level.sdbombmodel.angles = var_1.angles;
    level.sdbombmodel setModel(getbombmodel());
    level.sdbombmodel setasgametypeobjective();
    level.sdbombmodel setnonstick(1);
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA" && scripts\mp\utility\game::getgametype() != "_encstr_917E062D776791E9" && scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182" || scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5") {
    var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_0 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  }

  var_7 = [];

  if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" || scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9" || scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182" || scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_8 = var_0;
    var_8 scripts\mp\gameobjects::setownerteam(var_1.team);
  } else {
    var_9 = var_0.bombdefusetrig;
    var_9.origin = level.sdbombmodel.origin;
    var_10 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_0 scripts\mp\gameobjects::releaseid(1, 1);
    var_8 = scripts\mp\gameobjects::createuseobject(var_10, var_9, var_7, (0, 0, 32));
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_8.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(var_8.objidnum, 0);
  }

  var_8.objectivekey = var_0.objectivekey;
  var_8.iconname = var_0.iconname;
  var_8.id = "_encstr_86DB0E32ACCC579B56BEBD31A9CAB11D";
  var_8.trigger setusepriority(-3);

  if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182")
    var_8 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  else
    var_8 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");

  var_8 scripts\mp\gameobjects::setusetime(level.defusetime);
  var_8 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_8 scripts\mp\gameobjects::setusehinttext(&"_encstr_8DAB1D45DFE61398FB4C18514FF9850348F1078997C53641D15F8A64DD709F");
  var_8.trigger setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_8 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_8 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AC9D18EB87CB3B2F68388327708015A22FADF7277D3DB257D090", "_encstr_845713ABEFF337D863A6AC51A3053678ABCDF87AF9");

  if(scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182")
    var_8 thread current_carrier(var_2, "_encstr_B4A01574965B2928A90310512BF72045817FE5746FC2D9", "_encstr_834B10DD2CF283DE4B9B3AFA19ACCC57DC95");

  if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182" && level.cmdrules == 2) {} else {
    var_8.onbeginuse = ::bombzone_onbeginuse;
    var_8.onenduse = ::bombzone_onenduse;
    var_8.onuse = ::bombzone_onusedefuseobject;
    var_8.resetprogress = level.resetprogress;
    var_8.useweapon = getcompleteweaponname("_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B");
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1.team, 22, 23);
  var_0 bombtimerwait(var_0.objectivekey);
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  var_8.bombplanted = 0;

  if(level.gameended)
    return;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_B807035284" && level.bombdefused || scripts\mp\utility\game::getgametype() == "_encstr_9B0703CD93" && level.bombdefused) {
    var_8 scripts\mp\gameobjects::deleteuseobject();
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" || scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9" || scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182" || scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_8.showprogressforteam = undefined;
    var_11 = _encstr_BAF31CCD6C9C5A1C3AE6E5D607E5EC2CAD563ABC0E596EBC3246C576E68D::bombhandler;

    if(var_0.bombdefused) {
      var_0 thread[[var_11]](var_1, "_encstr_9A7B088CCA335D37CA91");
      var_0.onuse = ::bombzone_onuseplantobject;

      if(isDefined(level.ddbombmodel[var_0.objectivekey]))
        level.ddbombmodel[var_0.objectivekey] delete();

      return;
    } else {
      level.bombexploded = level.bombexploded + 1;
      var_0 thread[[var_11]](var_1, "_encstr_860808CB78E2984063BA", var_2);
    }
  } else
    level.bombexploded = level.bombexploded + 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182")
    level waittill("_encstr_AF8715E8C3C3C717AFA9274548B9B981702D0DE88307D5");

  level notify("_encstr_A36F0EC4EDDAC4AFB20F3836F623B246" + var_0.objectivekey);
  var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_BDE80911CA4B20E0D6FC4B");
  var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8146112D4D4930A902A997F3CF2BA03ACABB3D");

  if(isDefined(level.sd_onbombtimerend))
    level thread[[level.sd_onbombtimerend]]();

  if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182")
    var_12 = var_0.curorigin;
  else if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" || scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9" || scripts\mp\utility\game::getgametype() == "_encstr_A9190405B4E5") {
    var_12 = level.ddbombmodel[var_0.objectivekey].origin;
    level.ddbombmodel[var_0.objectivekey] delete();
  } else {
    var_12 = level.sdbombmodel.origin;
    level.sdbombmodel delete();
  }

  if(isDefined(var_1)) {
    var_0.visuals[0] radiusdamage(var_12, 512, 200, 20, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_8B460D8A6176034A70279C992770D2", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B460D8A6176034A70279C992770D2", var_1.pers["_encstr_8B460D8A6176034A70279C992770D2"]);
  } else
    var_0.visuals[0] radiusdamage(var_12, 512, 200, 20, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");

  var_13 = randomfloat(360);

  if(isDefined(var_0.trigger.effect))
    var_14 = var_0.trigger.effect;
  else if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10")
    var_14 = "_encstr_8FEA176E88AAD7E059F9BF8ACD877A59C0F8B2A4357FF00758";
  else
    var_14 = "_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73";

  var_15 = var_12 + (0, 0, 50);
  var_16 = spawnfx(level._effect[var_14], var_15, (0, 0, 1), (cos(var_13), sin(var_13), 0));
  triggerfx(var_16);
  physicsexplosionsphere(var_15, 200, 100, 3);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_12);
  earthquake(0.75, 2.0, var_12, 2000);
  playsoundatpos(var_15, "_encstr_BAE710E54853EF0127F728A88F54B9B73A72");

  if(scripts\mp\utility\game::getgametype() == "_encstr_917E062D776791E9") {
    foreach(var_18 in level.objectives) {
      if(isDefined(var_18.exploderindex))
        scripts\engine\utility::exploder(var_18.exploderindex);
    }
  } else if(isDefined(var_0.exploderindex))
    scripts\engine\utility::exploder(var_0.exploderindex);

  var_8 scripts\mp\gameobjects::disableobject();

  if(isDefined(level.onobjectivecomplete))
    [[level.onobjectivecomplete]]("_encstr_979A09DA67D0262B70CD82", self.objectivekey, var_1, game["_encstr_991C0AB9ED5B57161FE89B83"], undefined);
}

removespawnprotectiononnotify() {
  switch (level.mapname) {
    case "_encstr_A90A0D75F9E1455F9EA3227A68F5EF":
      return 10;
    default:
      return 0;
  }
}

current_carrier(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = level.framedurationseconds;
  var_4 = var_3 * 1000;
  var_5 = level.bombtimer * 1000;
  var_6 = var_4 / var_5;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    var_7 = "_encstr_A2BE0AB4DC3BB46E5A981BAC";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, var_7, self.curorigin + self.offset3d);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var_1, var_2, self.radialtimeobjid);
  self.bombplanted = 1;

  while(self.bombplanted) {
    var_8 = var_6;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.radialtimeobjid, var_0);
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, var_8);
    var_6 = min(var_6 + var_4 / var_5, 1.0);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);
  self.radialtimeobjid = -1;
}

getbombmodel(var_0) {
  if(istrue(level.setplayerselfrevivingextrainfo) && istrue(var_0))
    return "_encstr_970B20ADB4632DA32C9C97BEC8DE3B1DC2D9DCD734D5B616B9EB9B5BEA36D87D8126";

  return "_encstr_93161A78F20BBB801DE4C79F0589407E9F7AD161EA27653936F75BAD";
}

initobjectivecam(var_0) {
  var_1 = undefined;
  var_2 = getEntArray("_encstr_B1AC117F48D0A2B7FD10776BF04F0899E15BFB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(var_4.script_label == var_0.objectivekey) {
      var_1 = var_4;
      break;
    }
  }

  var_6 = [];

  if(isDefined(var_1) && isDefined(var_1.target)) {
    var_7 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    while(isDefined(var_7)) {
      var_6[var_6.size] = var_7;

      if(isDefined(var_7.target)) {
        var_7 = getEnt(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        continue;
      }

      break;
    }
  }

  if(isDefined(var_1) && var_6.size) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_8.origin = var_1.origin;
    var_8.angles = var_1.angles;
    var_8.path = var_6;
    var_8 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_8 hide();
    return var_8;
  } else
    return undefined;
}

runobjectivecam() {
  level notify("_encstr_BE2B0E376618C796A1085B62D1E74EBF");

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 visionsetnakedforplayer("_encstr_8A8C09A5D372D6302FEE93", 0.5);
    }
  }

  wait 0.5;

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::setusingremote("_encstr_BE2B0E376618C796A1085B62D1E74EBF");
      var_1 scripts\common\utility::allow_weapon(0);
      var_1 playerlinkweaponviewtodelta(self, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 180, 180, 180, 180, 1);
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 setplayerangles(self.angles);
      var_1 visionsetnakedforplayer("_encstr_B40101", 0.5);
    }
  }

  for(var_5 = 0; var_5 < self.path.size; var_5++) {
    var_6 = 0;

    if(var_5 == 0)
      var_6 = 5 / self.path.size / 2;

    var_7 = 0;

    if(var_5 == self.path.size - 1)
      var_7 = 5 / self.path.size / 2;

    self moveTo(self.path[var_5].origin, 5 / self.path.size, var_6, var_7);
    self rotateTo(self.path[var_5].angles, 5 / self.path.size, var_6, var_7);
    wait(5 / self.path.size);
  }
}

bombtimerwait(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9BC10FEA30280BA2C7687A82409B5DAFA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_0);
  var_1 = int(level.bombtimer * 1000 + gettime());
  setomnvar("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92" + var_0, var_1);
  thread updatetimerconstant("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92" + var_0, var_1, level.bombtimer * 1000, var_0);
  level thread handlehostmigration(var_1, var_0);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

updatetimerconstant(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9BC10FEA30280BA2C7687A82409B5DAFA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_3);
  self.startbombtime = gettime();

  while(gettime() < var_1) {
    var_4 = gettime() - self.startbombtime;
    setomnvar(var_0, int(gettime() + var_2 - var_4));
    waitframe();
  }
}

handlehostmigration(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_1);
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  setomnvar("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92" + var_1, 0);
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0)
    setomnvar("_encstr_8C831627B81E9A0ADB36D90BABF36232A670D3EB28B0DD92" + var_1, var_0 + var_2);
}

bombdefused(var_0) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA" && scripts\mp\utility\game::getgametype() != "_encstr_917E062D776791E9" && scripts\mp\utility\game::getgametype() != "_encstr_9719046E3182" && scripts\mp\utility\game::getgametype() != "_encstr_A9190405B4E5")
    level.bombdefused = 1;

  var_0.bombdefused = 1;
  setbombtimeromnvars();
  level notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + var_0.objectivekey);

  if(isDefined(level.onobjectivecomplete))
    [[level.onobjectivecomplete]]("_encstr_979A09DA67D0262B70CD82", self.objectivekey, undefined, game["_encstr_B6A70A23CA6659DC91CAE4DC"], undefined);
}

updatebombplantedomnvar(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_9719046E3182") {
    return;
  }
  if(isDefined(var_0)) {
    if(var_0 == "_encstr_9A8507BA4040188D08")
      setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", 2);
    else
      setomnvar("_encstr_8AAD13574BF54CB7DAC4EBDEBBB959C9BE1D9516B6", 1);
  }

  if(isDefined(level.aplanted)) {
    if(level.aplanted)
      setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 1);
    else
      setomnvar("_encstr_B47A12BBF4378A8F5573A12B03F138F30588CED7", 0);
  }

  if(isDefined(level.bplanted)) {
    if(level.bplanted)
      setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 1);
    else
      setomnvar("_encstr_B67A125D2DF589F65B31D78363B0DCE8AC8CBE4C", 0);
  }
}

setbombtimeromnvars(var_0) {
  updatebombplantedomnvar(var_0);
}

bombzone_setupbombcase(var_0) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_1 = getEnt(var_0 + "_encstr_A5280DBEC721CEE4288AE1C3CA6BB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1))
    scripts\engine\utility::error("_encstr_831904A5870A" + var_0 + "_encstr_9BB223FAC1D2366DBA07AFD1C9963B801D4E963B3B2B9340997BABE62304B4DC026B580EC5");
  else {
    var_2[0] = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_2[0])) {
      scripts\engine\utility::error("_encstr_831904A5870A" + var_0 + "_encstr_AFE01C409B1B4ED2E01DBE6BF62395C608CCDB5DB9C8042DB901B6C2C117");
      return;
    }

    var_2[0] setModel(getbombmodel(1));
    var_2[0] setnonstick(1);
    var_2[0] = getadjustedfirstroundbombcaseposition(var_2[0]);
    var_1 = getadjustedfirstroundbombcaseposition(var_1, 1);

    if(!level.multibomb) {
      level.sdbomb = scripts\mp\gameobjects::createcarryobject(game["_encstr_991C0AB9ED5B57161FE89B83"], var_1, var_2, (0, 0, 32), undefined, 1);
      level.sdbomb scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
      level.sdbomb.allowweapons = 1;
      level.sdbomb.onpickup = ::onpickup;
      level.sdbomb.ondrop = ::ondrop;
      level.sdbomb.firstpickup = 1;
      level thread bombsitewatcher();
      level.bombrespawnpoint = level.sdbomb.visuals[0].origin;
      level.bombrespawnangles = level.sdbomb.visuals[0].angles;
      level.sdbomb.visualgroundoffset = (0, 0, 2);
      return;
    }

    var_1 delete();
    var_2[0] delete();
  }
}

getadjustedfirstroundbombcaseposition(var_0, var_1) {
  switch (level.mapname) {
    case "_encstr_A3890850E25F90B79A83":
      if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        var_2 = (-518, -959.2, 267);

        if(istrue(var_1))
          var_0.origin = var_2;
        else {
          var_0.origin = var_2;
          var_0.angles = (0, 90, 0);
        }
      }

      break;
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      var_2 = (263, -2500, 146);

      if(istrue(var_1))
        var_0.origin = var_2;
      else {
        var_0.origin = var_2;
        var_0.angles = (0, 90, 0);
      }

      break;
    default:
      break;
  }

  return var_0;
}

movebombcase(var_0, var_1) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = var_0;
    level.sdbomb.visuals[0].origin = var_0;
    level.sdbomb.visuals[0].angles = var_1;
    level.sdbomb.visuals[0] show();
    level.sdbomb scripts\mp\gameobjects::allowcarry("_encstr_ACFC091AE8AB2FCBE15119");
    level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B4010EEEB0BC0EEDA5B91DBE4CDEB598");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
  }
}

bombsitewatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_87010C8932778E41AAD96F77ED92");

    foreach(var_1 in level.objectives)
    var_1.trigger enableplayeruse(level.sdbomb.carrier);

    waitframe();
  }
}

onpickup(var_0, var_1, var_2) {
  var_0.isbombcarrier = 1;

  if(isPlayer(var_0)) {
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
    scripts\mp\utility\game::setmlgannouncement(1, var_0.team, var_0 getentitynumber());
  }

  var_0 setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 1);
  setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", var_0 getentitynumber());
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_92441AF343C568B8CF1A2AF3024FE87011DD4F5FE7EAC0E0B3D2A0B9");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team]))
    var_0 thread applybombcarrierclass();

  if(!level.bombdefused) {
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_8201135F5150B9C74353B0C6F0250E6171F747AD91");
    scripts\mp\hud_util::teamplayercardsplash("_encstr_96C9128FDB3934CF5363CF9AD55D1EFBCBB8D5E8", var_0, var_0.team);

    if(istrue(self.firstpickup)) {
      var_3 = "_encstr_A98012D8DF684B37F353A62FDDCB9EC3FC8622D3";
      self.firstpickup = 0;

      if(istrue(level.setplayerselfrevivingextrainfo)) {
        level.sdbomb.visuals[0] setModel(getbombmodel());
        playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], self.trigger.origin + (0, 0, -9970));
      }
    } else
      var_3 = "_encstr_87010C8932778E41AAD96F77ED92";

    var_4 = [];
    var_4[var_4.size] = var_0;
    level thread playerdelayedvo(var_0, var_3);
    level thread teamdelayedvo(var_0.pers["_encstr_8AEF05472BC2D6"], var_4);
  }

  scripts\mp\utility\sound::playsoundonplayers(game["_encstr_BA2A15987B5B13EB39AC6CB7B3B29C9523EB6EBDEA3719"], game["_encstr_991C0AB9ED5B57161FE89B83"]);

  if(level.codcasterenabled)
    var_0 setgametypevip(1);

  scripts\mp\utility\game::_id_119AC(var_0, undefined, "_encstr_A2C10F2E081BE2E8C798574FC0792059F9", var_0.origin);
  level notify("_encstr_87010C8932778E41AAD96F77ED92");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 25, undefined, var_0, 21);
}

ondrop(var_0) {
  level notify("_encstr_88310DBE28821BF909DB18232367E7");
  setomnvar("_encstr_A55A105862213D10B76AA0A641E37B93177B", -1);

  if(level.codcasterenabled) {
    if(isDefined(var_0))
      var_0 setgametypevip(0);
  }

  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B4010EEEB0BC0EEDA5B91DBE4CDEB598");
  scripts\mp\utility\sound::playsoundonplayers(game["_encstr_BE9B13E59FF216D154AAD04B523D40C04B3773752B"], game["_encstr_991C0AB9ED5B57161FE89B83"]);

  if(isDefined(var_0)) {
    var_0.isbombcarrier = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 24);
  }

  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0)
    thread waitforbombreset(level.bombresettimer);
}

waitforbombreset(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87010C8932778E41AAD96F77ED92");
  wait(var_0);
  scripts\mp\weapons::equipmentdeletevfx(self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

enablemultibombui() {
  foreach(var_1 in level.players) {
    if(!isai(var_1))
      var_1 setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", var_1.pers["_encstr_8AEF05472BC2D6"] == game["_encstr_991C0AB9ED5B57161FE89B83"]);
  }
}

respawnbombcase() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;

  if(level.multibomb)
    enablemultibombui();
  else
    movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

advancebombcase() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombrespawnpoint = level.curobj.visuals[0].origin + (0, 0, 48);
  level.bombrespawnangles = level.curobj.visuals[0].angles;

  if(level.multibomb)
    enablemultibombui();
  else
    movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

applybombcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.sd_loadout[self.team];
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.lastclass = "_encstr_AAAC09D09972B9C83F2B7F";
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

removebombcarrierclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!self isonground())
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = undefined;
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

bombzone_awardgenericbombzonemedals(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(!isDefined(var_3.bombdefusetrig.origin)) {
      continue;
    }
    var_4 = istrue(var_3.bombplanted);
    var_5 = distsquaredcheck(var_0.origin, var_1.origin, scripts\engine\utility::ter_op(var_4, var_3.bombdefusetrig.origin, var_3.trigger.origin));

    if(var_5) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_B60703EACA" && scripts\mp\utility\game::inovertime()) {
        if(var_0.team == var_3.ownerteam) {
          var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "_encstr_A20C07ABF304625E08", "_encstr_AB3508737F830710ACDB"));
          var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "_encstr_93D80ED6F646B2AFF0EB1995CCCA3791", "_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C"));
        } else {
          var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
          var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        }

        continue;
      }

      if(var_1.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
        var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "_encstr_A20C07ABF304625E08", "_encstr_AB3508737F830710ACDB"));
        var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "_encstr_93D80ED6F646B2AFF0EB1995CCCA3791", "_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C"));
        continue;
      }

      var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "_encstr_AB3508737F830710ACDB", "_encstr_A20C07ABF304625E08"));
      var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C", "_encstr_93D80ED6F646B2AFF0EB1995CCCA3791"));
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000)
    return 1;
  else
    return 0;
}

playerdelayedvo(var_0, var_1) {
  var_2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming))
    var_3 = 8;
  else
    var_3 = 5;

  var_4 = var_3 - var_2;

  if(var_4 > 0)
    wait(var_4);

  if(isDefined(var_0))
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer(var_1);
}

teamdelayedvo(var_0, var_1) {
  var_2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming))
    var_3 = 8;
  else
    var_3 = 5;

  var_4 = var_3 - var_2;

  if(var_4 > 0)
    wait(var_4);

  scripts\mp\utility\dialog::leaderdialog("_encstr_B2C30DC06FBD8177D266831BFFFB5B", var_0, "_encstr_999B050670F0FA", var_1);
}

resetuiomnvargamemode() {
  self setclientomnvar("_encstr_845A1183746F28871B8BBB83E312C068E7CDE9", 0);
}

setteaminhuddatafromteamname(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A")
    self setteaminhuddata(1);
  else if(var_0 == "_encstr_9A8507BA4040188D08")
    self setteaminhuddata(2);
  else
    self setteaminhuddata(0);
}