/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_destruction.gsc
***********************************************/

init_damageable_start_door() {
  level.startdoorstruct = scripts\engine\utility::getStruct("_encstr_BDE715118A2F27A8D7D7679111FAF8FBFB42CE99F24FE6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.startdoorstruct)) {
    return;
  }
  var_0 = getEntArray(level.startdoorstruct.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread watchfordoorenttriggered();

  scripts\cp\cp_objectives::setomnvarbasedonindex(6);
}

watchfordoorenttriggered() {
  level endon("_encstr_A622153BA86BD77A55A2C77E956BA3B536F05BB780812E");
  level.startdoorstruct waittill("_encstr_A3DF0B1FB0E7C818235A48D3A3", var_0);

  if(self.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C") {
    self connectpaths();
    self notsolid();
  }

  if(var_0 == "_encstr_ACB31A33EF16B3304652E008C6822FB0EEA8E07557082899DD61A172") {
    level notify("_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC");
    scripts\cp\cp_objectives::clearobjectivetext();
    var_1 = scripts\cp\utility::getinteractionbynoteworthy("_encstr_AFD40C343795C93FA2AF7B1FA258");

    foreach(var_3 in level.players)
    scripts\cp\cp_objectives::clearobjectivetextforplayer(var_3);

    scripts\cp\cp_objectives::setomnvarbasedonindex(7);
  }
}

getanimsdatafromthedestructiontable() {
  var_0 = "_encstr_837126C12BBA70279913B332AE0723A03D7351971393FB2BDBF96B43FFE6E7ECC75971FDA689972E";
  level.crafteditemsanimdata = [];

  for(var_1 = 1; var_1 <= 2; var_1++) {
    var_2 = tablelookup(var_0, 0, var_1, 1);
    level.crafteditemsanimdata[var_2] = spawnStruct();
    level.crafteditemsanimdata[var_2].crafteditemindex = var_1;
    level.crafteditemsanimdata[var_2].crafteditem = var_2;
    level.crafteditemsanimdata[var_2].player_scr_anim = getplayeranimfile(var_2);
    level.crafteditemsanimdata[var_2].player_scr_animname = tablelookup(var_0, 0, var_1, 3);
    level.crafteditemsanimdata[var_2].player_scr_eventanim = tablelookup(var_0, 0, var_1, 4);
    level.crafteditemsanimdata[var_2].player_scr_viewmodelanim = tablelookup(var_0, 0, var_1, 5);
    level.crafteditemsanimdata[var_2].obj_scr_anim = getobjanimfile(var_2);
    level.crafteditemsanimdata[var_2].obj_scr_animname = tablelookup(var_0, 0, var_1, 7);
  }

  level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"] = ::scriptmodelplayanim;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

getobjanimfile(var_0) {
  switch (var_0) {
    case "_encstr_ACB31A33EF16B3304652E008C6822FB0EEA8E07557082899DD61A172":
      return % _encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0;
    case "_encstr_957E0E09C9CA2CC6A11086D016E49DCA":
      return % _encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0;
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

getplayeranimfile(var_0) {
  switch (var_0) {
    case "_encstr_ACB31A33EF16B3304652E008C6822FB0EEA8E07557082899DD61A172":
      return % _encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A;
    case "_encstr_957E0E09C9CA2CC6A11086D016E49DCA":
      return % _encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A;
  }
}

init_destruction() {
  if(!objective_mlgicon())
    level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"] = loadfx("_encstr_87A513C328120F12F7166FF576894A0618F24B3B70");
  else
    level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"] = loadfx("_encstr_A9A5323476F3F0CBC3A7D1583B8D9513FF1936A3CD77280D6F8BD93B02F537297F8FC6B022AB296B1672E1E0EACC0780A23E449B");

  level thread getanimsdatafromthedestructiontable();
  scripts\common\anim::initanim();

  if(!isDefined(level.scr_viewmodelanim))
    level.scr_viewmodelanim = [];

  if(!isDefined(level.scr_eventanim))
    level.scr_eventanim = [];

  anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"] = scripts\cp\cp_anim::teleport_entity;
  anim.callbacks["_encstr_A6480D47345F98017A5397D3E3F2D9"] = scripts\cp\cp_anim::should_do_anim;
  anim.callbacks["_encstr_B63D0C4DB578B5480DDFF04BFF56"] = scripts\cp\cp_anim::do_animation;
  anim.callbacks["_encstr_8B620D11F6230BC6D258B1A0E6D2B5"] = scripts\cp\cp_anim::do_facial_anim;
  level.destructibles = [];
  level thread watchforconnectedplayers();
  wait 3;
  level thread init_damageable_start_door();
  add_destructible_array("_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

add_destructible_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    add_destructible(var_5, var_4);
    var_5 assigninteractteam(level.teamnamelist);
    var_5 thread updatewaitforjoined();

    if(!isDefined(level.destructibles[var_0]))
      level.destructibles[var_0] = [];

    level.destructibles[var_0][level.destructibles[var_0].size] = var_5;
    var_5 process_action("_encstr_88C5055208731B");
  }
}

pvpve_break_doors() {
  wait 16;

  foreach(var_1 in level.destructibles["_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F"]) {
    foreach(var_3 in var_1.ents) {
      if(isDefined(var_3.classname)) {
        if(var_3.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" || var_3.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" || var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
          var_3 delete();
      }
    }
  }

  foreach(var_11, var_7 in level.usedestructibleobjects) {
    foreach(var_10, var_9 in var_7)
    var_9 delete();
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.scr_animtree["_encstr_A51B086302E74E1BADDA"] = #animtree;
  level.scr_anim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"] = % _encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A;
  level.scr_animname["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"] = "_encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A";
  level.scr_eventanim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"] = "_encstr_82F710FD2F3B379237983F8160894BCF511B";
  level.scr_viewmodelanim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"] = "_encstr_9BB213B3B5BE562EBA96387D8D43FA851D8E161B43";
  level.scr_animtree["_encstr_A7B90C0AE07C73CB400F81843F40"] = #animtree;
  level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = var_0;
  level.scr_animname["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = var_1;
  level.scr_eventanim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = var_2;
  level.scr_viewmodelanim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"] = var_3;

  if(isDefined(var_6)) {
    level.scr_animtree[var_6] = #animtree;
    level.scr_anim[var_6]["_encstr_A24E069389FFAA3C"] = var_4;
    level.scr_animname[var_6]["_encstr_A24E069389FFAA3C"] = var_5;
  }

  if(var_6 == "_encstr_8B07036CD0")
    level.breachanimlength = getanimlength(level.scr_anim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"]);
  else
    level.breachanimlength = getanimlength(level.scr_anim["_encstr_A7B90C0AE07C73CB400F81843F40"]["_encstr_AC010C3955ECA9038931DB187790"]);
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_4 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_4.player = var_0;
  var_0.player_rig = var_4;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 scripts\common\utility::allow_fire(0);
  var_0 scripts\common\utility::allow_ads(0);

  if(isDefined(var_1) && var_1 == "_encstr_A51B086302E74E1BADDA")
    var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 0, 0, 0, 0, 0, 0);
  else
    var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 0);

  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig) || !isDefined(var_0.origin)) {
    return;
  }
  var_0 unlink();

  if(isDefined(var_0 getdroptofloorposition(var_0.origin)))
    var_0 setOrigin(var_0 getdroptofloorposition(var_0.origin));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
  var_0 scripts\common\utility::allow_fire(1);
  var_0 scripts\common\utility::allow_ads(1);
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

add_destructible(var_0, var_1) {
  if(!isDefined(var_0.ents))
    var_0.ents = [];

  var_0 read_properties(var_1);
  var_0 read_actions(var_1);
  var_0.ents[var_0.ents.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_5 in var_2)
      add_destructible(var_0, var_5);
    }

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_8 in var_3)
      add_destructible(var_0, var_8);
    }
  }
}

read_properties(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.previewbomb))
    self.previewbomb = [];

  if(!isDefined(var_0.classname)) {
    if(isDefined(var_0.script_parameters)) {
      switch (var_0.script_parameters) {
        case "_encstr_BAC20FFE656B294903E2414B540703B1AA":
        case "_encstr_846D0D4CBD5BC4BE0E9CAC672D95EE":
          var_1 = var_0.script_label;
          var_2 = var_0.script_parameters;

          if(isDefined(var_2))
            self.previewbomb[var_0.script_parameters] = var_0;

          break;
      }
    }
  } else {
    switch (var_0.classname) {
      case "_encstr_A38E124303C0477207C357B07F1D8725F85596B3":
        var_3 = var_0.name;

        if(isDefined(var_3)) {
          switch (var_3) {
            case "_encstr_81620F7E08888229ED356F5F771D83C71A":
            case "_encstr_88620F6A3093DE3FB30E594FACB9C32993":
              self.use_triggers[var_3] = var_0;
              break;
          }
        }

        break;
      case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
        var_1 = var_0.script_label;
        var_2 = var_0.script_parameters;

        if(isDefined(var_2)) {
          if(var_0.script_label == self.ents[0].name)
            self.previewbomb[var_0.script_label] = var_0;
        }

        var_4 = var_0.name;

        if(isDefined(var_4))
          self.weapontouse = var_4;

        break;
    }
  }
}

read_actions(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  var_1 = strtok(var_0.script_noteworthy, "_encstr_964C0249");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_encstr_854C021F");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size < 2) {
      return;
    }
    var_3 = var_4[0];

    if(!isDefined(var_0.actions))
      var_0.actions = [];

    if(!isDefined(var_0.actions[var_3]))
      var_0.actions[var_3] = [];

    for(var_5 = 1; var_5 < var_4.size; var_5++)
      var_0.actions[var_3][var_0.actions[var_3].size] = var_4[var_5];
  }
}

process_action(var_0) {
  if(!isDefined(self.ents)) {
    return;
  }
  foreach(var_2 in self.ents) {
    if(isDefined(var_2.actions) && isDefined(var_2.actions[var_0])) {
      foreach(var_4 in var_2.actions[var_0])
      var_2 actionmap(var_4, self);
    }
  }

  self.state = var_0;
}

process_action_override(var_0, var_1, var_2) {
  if(!isDefined(self.ents)) {
    return;
  }
  foreach(var_4 in self.ents) {
    if(isDefined(var_4.actions) && isDefined(var_4.actions[var_0])) {
      foreach(var_6 in var_4.actions[var_0]) {
        if(var_6 == var_1)
          var_6 = var_2;

        var_4 actionmap(var_6, self);
      }
    }
  }

  self.state = var_0;
}

actionmap(var_0, var_1) {
  switch (var_0) {
    case "_encstr_A29106F6B9EAE6B2":
      if(isDefined(level.actionmapfuncs) && isDefined(level.actionmapfuncs["_encstr_A29106F6B9EAE6B2"]))
        level[[level.actionmapfuncs["_encstr_A29106F6B9EAE6B2"]]](var_1);

      break;
    case "_encstr_BD1805CB69C063":
      if(isent(self))
        self show();

      break;
    case "_encstr_BECC055CF3811A":
      if(isent(self))
        self hide();

      break;
    case "_encstr_AB610616DF039871":
      if(isent(self))
        self solid();

      break;
    case "_encstr_AC1C094DFF93103033EAF9":
      if(isent(self))
        self notsolid();

      break;
    case "_encstr_B41C1023A59BC67BB99B2B8D4707581D1ADC":
      if(isent(self))
        self disconnectPaths();

      break;
    case "_encstr_B4A50D583AB837D53F1397E2241B48":
      if(isent(self))
        self connectpaths();

      break;
    case "_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73":
      var_2 = self.origin;
      var_3 = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
      var_4 = undefined;
      var_4 = spawnfx(level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"], var_2, anglesToForward(var_3) * -1.0, (0, 0, 1));
      triggerfx(var_4);
      physicsexplosionsphere(var_2, 200, 100, 3);

      foreach(var_6 in level.players) {
        if(distancesquared(var_6.origin, var_2) > 562500) {
          continue;
        }
        var_6 shellshock("_encstr_AB1C128A0DE0F74345D2F1DA1BB0FB6BD0B50504", 2);
      }

      earthquake(0.5, 1.0, var_2, 1000);

      if(soundexists("_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD"))
        playsoundatpos(var_2, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");

      waitframe();
      var_4 delete();
      break;
    case "_encstr_8AE20E8B98AF3F0D288D2F5015C7B112":
      var_2 = self.origin;
      earthquake(0.2, 1.0, var_2, 1000);

      if(soundexists("_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD"))
        playsoundatpos(var_2, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");

      break;
  }
}

destructible_interactions() {
  if(getdvarint("_encstr_A3A112DB6ECA410ED706B1675B1AC69075464130", 0) == 0)
    scripts\cp\cp_interaction::registerinteraction("_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F", ::breach_hint_func, ::plantbreachweapon, ::initbreachpoint);
}

breach_hint_func(var_0, var_1) {
  var_2 = "_encstr_B40101";

  if(isDefined(level.fubar_hint_breach))
    return [[level.fubar_hint_breach]](var_0, var_1);

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    if((!isDefined(var_1.powers["_encstr_8D7C09102FE7216D71A66D"]) || var_1.powers["_encstr_8D7C09102FE7216D71A66D"].charges <= 0) && istrue(var_1.has_crowbar)) {
      var_1 thread testanimationduringuseduration(var_0, var_1);
      var_1.interaction_trigger sethinticon("_encstr_93A3152C9B106FBA96FFA36FC148029A218122F7B19010");
      var_1.interaction_trigger sethintrequiresholding(1);
      var_1.interaction_trigger setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
      var_1.interaction_trigger sethintdisplayrange(96);
      var_1.interaction_trigger sethintdisplayfov(270);
      var_1.interaction_trigger setuserange(96);
      var_1.interaction_trigger setusefov(270);
      var_2 = &"_encstr_B28822A86F8DDAA71792FF6DD993ED774A693965E5D6401806CD1F5C5E09AEE7786B4D31";
    } else if(isDefined(var_1.powers["_encstr_8D7C09102FE7216D71A66D"]) || !istrue(var_1.has_crowbar) || istrue(var_1.forcedc4)) {
      var_1.interaction_trigger sethinticon("_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60");
      var_2 = &"_encstr_B6841A683D7A41EB0DA40532459272E8F2124915A00D90BE84923951";
    }
  } else if((!isDefined(var_1.powers["_encstr_8D7C09102FE7216D71A66D"]) || var_1.powers["_encstr_8D7C09102FE7216D71A66D"].charges <= 0) && istrue(var_1.has_crowbar)) {
    var_1 thread testanimationduringuseduration(var_0, var_1);

    if(!isotherplayersnearpoint(var_0.origin, var_1)) {
      var_1.last_interaction_point = undefined;
      var_1.interaction_trigger sethinticon("_encstr_87B6150D5374E9A32A9FF58F8BB2F8F8376C2918FDDD68");
      var_2 = &"_encstr_8F0C171AA0D79AAA2994595031CB9014929CBE24942A05A109";
      var_1.interaction_trigger sethintstringparams(1);
    } else {
      var_1.last_interaction_point = undefined;
      var_1.interaction_trigger sethinticon("_encstr_93A3152C9B106FBA96FFA36FC148029A218122F7B19010");
      var_1.interaction_trigger sethintrequiresholding(1);
      var_1.interaction_trigger setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
      var_2 = &"_encstr_B28822A86F8DDAA71792FF6DD993ED774A693965E5D6401806CD1F5C5E09AEE7786B4D31";
    }
  } else if(isDefined(var_1.powers["_encstr_8D7C09102FE7216D71A66D"]) || istrue(var_1.forcedc4)) {
    var_1.interaction_trigger sethinticon("_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60");
    var_2 = &"_encstr_B6841A683D7A41EB0DA40532459272E8F2124915A00D90BE84923951";
  }

  return var_2;
}

testanimationduringuseduration(var_0, var_1) {
  var_1 notify("_encstr_AF091FBB6F4B989FA2EF8B9BB3FAC0F0D4C3E390558759BE4A23A385FFD31BB086");
  var_1 endon("_encstr_AF091FBB6F4B989FA2EF8B9BB3FAC0F0D4C3E390558759BE4A23A385FFD31BB086");
  var_2 = var_1 scripts\engine\utility::waittill_any_ents_return(var_1.interaction_trigger, "_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B");

  if(!isDefined(var_0.script_noteworthy) || var_0.script_noteworthy != "_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F") {
    return;
  }
  var_1 thread plantbreachweapon(var_0, var_1, 1);
  var_1 endon("_encstr_8B75165B6F4CC18BA29B9BBDE75A4DC8FF0546B31589803D");
  var_1 thread earlyexit(var_1);
  var_2 = var_1 scripts\engine\utility::waittill_any_ents_return(var_1.interaction_trigger, "_encstr_8F5C086405E70FBA4B4A", var_1, "_encstr_8B75165B6F4CC18BA29B9BBDE75A4DC8FF0546B31589803D", var_1, "_encstr_83CB1C1B33F756C83C0E97EF21A59095D31A91634A778059521DA3AD530C", var_1, "_encstr_8D500B42B7434369DFA31BB103", level, "_encstr_878C0E7B3750C3BFC89B979ED1F0CDDA");

  if(isDefined(var_2) && var_2 != "_encstr_8D500B42B7434369DFA31BB103")
    var_1 notify("_encstr_AA7E104C0B30B73FDFD887272D7E42C37E98");

  remove_player_rig(var_1);

  if(isDefined(var_1.linktoent)) {
    var_1 unlink();
    var_1.linktoent delete();
    var_1.linktoent = undefined;
  }

  var_1.isbreaching = 0;
  var_1 stopgestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED");
}

earlyexit(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8B75165B6F4CC18BA29B9BBDE75A4DC8FF0546B31589803D");
  var_0 endon("_encstr_AA7E104C0B30B73FDFD887272D7E42C37E98");

  while(var_0 useButtonPressed())
    waitframe();

  var_0 notify("_encstr_8D500B42B7434369DFA31BB103");
}

initbreachpoint(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F") {
      add_destructible(var_2, var_2);
      storeothersideobjectreference(var_2);
      var_2 thread cleanupthreadforbombobject(var_2);

      foreach(var_4 in var_0) {
        if(var_4 != var_2) {
          if(var_2.target == var_4.target) {
            var_2.opposite_struct = var_4;
            storeothersideobjectreference(var_2.opposite_struct);
          }
        }
      }
    }
  }
}

breach_use_func(var_0, var_1) {
  if(level.gametype == "_encstr_839E0CBFD1801B5DB0D34C932998") {
    level notify("_encstr_A9C21823CA99AC9B46BE37955C5DACDCC6957D9BD18527D1B232");
    scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy(var_0.script_noteworthy);
  }
}

isotherplayersnearpoint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 0;

  foreach(var_4 in level.players) {
    if(var_4 != var_1) {
      if(distance(var_4.origin, var_0) <= 96) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

storeothersideobjectreference(var_0) {
  if(!isDefined(level.usedestructibleobjects))
    level.usedestructibleobjects = [];

  level.usedestructibleobjects[level.usedestructibleobjects.size] = var_0;
}

watchforconnectedplayers() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread showandhidebreachobjectsbasedonavailability();
  }
}

showandhidebreachobjectsbasedonavailability() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_842626DE9BB2D7B473B9D10B73B1ACBEB766EBE60DED77435A232B984EAC58B143BD89A966EAE6C6");
  self endon("_encstr_842626DE9BB2D7B473B9D10B73B1ACBEB766EBE60DED77435A232B984EAC58B143BD89A966EAE6C6");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AD("_encstr_872B14E9F2AFEF484D35F7854A7728A6AB09E0F02A6B", "_encstr_BE20134D3717D07B8747FEFB1D5187A338B96FAD2B");

    if(!isDefined(var_0)) {
      continue;
    }
    if(!isDefined(level.usedestructibleobjects)) {
      continue;
    }
    switch (var_0) {
      case "_encstr_872B14E9F2AFEF484D35F7854A7728A6AB09E0F02A6B":
        foreach(var_2 in level.usedestructibleobjects) {
          if(isDefined(var_2) && scripts\engine\utility::array_contains(level.current_interaction_structs, var_2)) {
            var_2.temp_disable_interaction = 1;
            scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
          }
        }

        break;
      case "_encstr_BE20134D3717D07B8747FEFB1D5187A338B96FAD2B":
        foreach(var_2 in level.usedestructibleobjects) {
          if(isDefined(var_2)) {
            if(isDefined(var_2.temp_disable_interaction) && var_2.temp_disable_interaction == 1) {
              var_2.temp_disable_interaction = 0;
              scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
            }
          }
        }

        break;
    }
  }
}

cleanupthreadforbombobject(var_0) {
  self waittill("_encstr_83621899C792E5F805B1E37824FB69A52A73031B7B093C584A99" + var_0.target);

  switch (var_0.name) {
    case "_encstr_846D0D4CBD5BC4BE0E9CAC672D95EE":
      foreach(var_2 in var_0.ents) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" || var_2.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" || var_2.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
            var_2 delete();
        }
      }

      break;
    case "_encstr_BAC20FFE656B294903E2414B540703B1AA":
      foreach(var_2 in var_0.ents) {
        if(isDefined(var_2.classname)) {
          if(var_2.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" || var_2.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" || var_2.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
            var_2 delete();
        }
      }

      break;
  }
}

getanimdataforexplosive(var_0) {
  foreach(var_2 in level.crafteditemsanimdata) {
    if(var_2.crafteditem == var_0)
      return var_2;
  }
}

chooserandomexplosive() {
  var_0 = ["_encstr_957E0E09C9CA2CC6A11086D016E49DCA"];
  var_1 = scripts\engine\utility::random(var_0);
  return var_1;
}

hasrequiredcrafteditemfordestruction(var_0) {
  foreach(var_2 in self.crafteditemslist) {
    if(var_0 == var_2)
      return 1;
  }

  return 0;
}

plantbreachweapon(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D500B42B7434369DFA31BB103");
  var_1 endon("_encstr_AF2E0F7B3545E99B9BA6C55786B5EF8265");

  if(var_0.script_noteworthy != "_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F") {
    return;
  }
  if(isDefined(level.fubar_breach_logic))
    return self[[level.fubar_breach_logic]](var_0, var_1);

  if(isDefined(level.fubar_breach_logic_plane_combat)) {
    if(!istrue([[level.fubar_breach_logic_plane_combat]](var_0, var_1)))
      return;
  }

  var_3 = 1;

  if(!level.only_one_player)
    var_4 = 2;
  else
    var_4 = 1;

  if((!isDefined(var_1.powers["_encstr_8D7C09102FE7216D71A66D"]) || var_1.powers["_encstr_8D7C09102FE7216D71A66D"].charges <= 0) && isDefined(var_2) && istrue(var_1.has_crowbar)) {
    var_5 = 3.3;
    var_6 = 1.0;
    crowbar_use_activate(var_1, var_0, var_3, var_4, var_5, var_6);
    return 1;
  } else if(!isDefined(var_1.throwinggrenade) && !isDefined(self.plantedbomb)) {
    bomb_use_activate(var_1, var_0);
    return 1;
  }

  return 0;
}

bomb_use_activate(var_0, var_1) {
  if(isDefined(var_0.forcedc4) && !var_0.forcedc4)
    var_0 thread scripts\cp\cp_powers::power_adjustcharges(-1, var_0.powers["_encstr_8D7C09102FE7216D71A66D"].slot);

  if(istrue(var_0.breaching)) {
    return;
  }
  var_0.breaching = 1;

  if(isPlayer(var_0))
    var_1 bomb_anim_think(var_0, var_1);

  var_1 thread actionmap("_encstr_A29106F6B9EAE6B2", var_1);

  if(isPlayer(var_0))
    remove_player_rig(var_0);

  var_1 thread bomb_planted_think(var_0, var_1);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

bomb_anim_think(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
  var_1.players_using_breach = -1;

  if(isDefined(var_1.opposite_struct))
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);

  script_model_anims(%_encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A, "_encstr_8C4E13BB5BFACAE2AEB40EEBB168BEB03A1D0BD81A", "_encstr_82F710FD2F3B379237983F8160894BCF511B", "_encstr_9BB213B3B5BE562EBA96387D8D43FA851D8E161B43", %_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0, "_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0", "_encstr_8B07036CD0");

  if(!isDefined(var_0.interaction_trigger)) {
    return;
  }
  thread watchplayerdeath(var_0);
  var_0.linktoent = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0, 0);
  var_0.linktoent moveTo(var_1.origin, 0.25, 0.1, 0.1);

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_0.linktoent rotateTo(var_1.angles, 0.25, 0.1, 0.1);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  wait 0.29;

  if(istrue(self.cancelplant))
    return 0;

  var_0 unlink();
  var_0.linktoent delete();
  var_0.linktoent = undefined;
  thread create_player_rig(var_0, "_encstr_A51B086302E74E1BADDA");
  var_0 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_A24E069389FFAA3C");
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 setModel("_encstr_A3B30E856CADE209A050075FE07EC3EF");
  var_2.animname = "_encstr_8B07036CD0";
  var_2 useanimtree(#animtree);
  self.plantedbomb = var_2;
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "_encstr_A24E069389FFAA3C");
  wait(getanimlength(level.scr_anim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"]));

  if(istrue(self.cancelplant))
    return 0;
}

bomb_planted_think(var_0, var_1) {
  var_1 endon("_encstr_8BD2102BB120421F5680A25A6EB53BFCC017");

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  var_0.breaching = undefined;

  if(!istrue(var_1.no_fuse))
    bomb_fuse_think(var_1);

  process_action("_encstr_83320ADDB7DB01AB8F3FF8E8");
  var_1 process_action("_encstr_83320ADDB7DB01AB8F3FF8E8");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);

  if(isDefined(var_1.opposite_struct))
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);

  wait 0.1;

  if(isDefined(self.plantedbomb)) {
    if(isDefined(var_0))
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    else
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 300, 1000, 100, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  }

  level notify("_encstr_878C0E7B3750C3BFC89B979ED1F0CDDA", self.origin, var_1);

  if(isDefined(self.plantedbomb)) {
    self.plantedbomb delete();
    self.plantedbomb = undefined;
  }

  var_2 = getEntArray("_encstr_A2771733B49B2CB1EB9827B258B11AFAC6DBB1635A37B4B7E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, var_2, 100);

  if(isDefined(var_3)) {
    var_3 connectpaths();
    var_3 delete();
  }

  if(isDefined(level.fubar_breach_spawners))
    thread[[level.fubar_breach_spawners]](self.origin);

  var_1 notify("_encstr_83621899C792E5F805B1E37824FB69A52A73031B7B093C584A99" + var_1.target);
}

bomb_fuse_think(var_0) {
  var_1 = gettime();
  var_2 = int(var_1 + 5000);
  var_3 = var_2 - var_1;

  while(var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250) {
        if(soundexists("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E"))
          self.plantedbomb playSound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
      } else if(var_3 < 500) {
        if(soundexists("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74"))
          self.plantedbomb playSound("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74");
      } else if(var_3 < 1500) {
        if(soundexists("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7"))
          self.plantedbomb playSound("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7");
      } else if(soundexists("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C"))
        self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.25;
    } else if(var_3 < 3500) {
      if(soundexists("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C"))
        self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.5;
    } else {
      if(soundexists("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF"))
        self.plantedbomb playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");

      wait 1.0;
    }

    if(var_3 < 0) {
      break;
    }
  }
}

crowbar_use_activate(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(crowbar_breach_try_think(var_0, var_1, var_2, var_3, var_4 - var_5)) {
    thread crowbar_planted_think(var_0, var_1);
    process_action("_encstr_A29106F6B9EAE6B2");
    actionmap("_encstr_A29106F6B9EAE6B2", self);
    self notify("_encstr_874010B5023760D6C3A939A092FB19080B6D");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1.opposite_struct);
    return 1;
  } else {
    remove_player_rig(var_0);
    var_0.isbreaching = 0;
    return 0;
  }
}

crowbar_breach_try_think(var_0, var_1, var_2, var_3, var_4) {
  crowbar_anim_think(var_0, var_1, var_2);
  wait(var_4);

  if(istrue(self.cancelplant))
    return 0;

  var_2 = getnumplayersusingthisinteraction(var_1);

  if(var_2 >= var_3)
    return 1;

  return 0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

crowbar_anim_think(var_0, var_1, var_2) {
  script_model_anims(%_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D, "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D", "_encstr_82F710FD2F3B379237983F8160894BCF511B", "_encstr_8C7A1A1B3137DAE17EA8776798F1A7535FD5A392288FB23686832B7B", %_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0, "_encstr_B4CD16EEB5FACA2E57D2C1AF1B0DEB2CE81DC28DA17D36D0", "_encstr_8B07036CD0");

  if(!(var_1.script_noteworthy == "_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F")) {
    return;
  }
  thread watchplayerdeath(var_0);
  var_0.linktoent = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0, 0);
  var_0.isbreaching = 1;
  var_2 = getnumplayersusingthisinteraction(var_1);
  setbreachernum(var_2, var_0, var_1);

  if(!isDefined(var_0.breachernum))
    var_0.breachernum = 1;

  if(var_0.breachernum == 1) {
    if(distance(var_0.origin, var_1.origin) > 3)
      var_0.linktoent moveTo((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    else
      var_0.linktoent moveTo(var_1.origin, 0.25, 0.05, 0.05);

    var_3 = getplayerrotationforbreach(var_1, var_0);
    var_0.linktoent rotateTo(var_3, 0.25, 0.05, 0.05);
  } else if(var_0.breachernum == 2) {
    if(distance(var_0.origin, var_1.origin) > 3)
      var_0.linktoent moveTo((var_1.origin + var_0.origin) / 2, 0.25, 0.05, 0.05);
    else
      var_0.linktoent moveTo(var_1.origin, 0.25, 0.05, 0.05);

    var_3 = getplayerrotationforbreach(var_1, var_0);
    var_0.linktoent rotateTo(var_3, 0.25, 0.05, 0.05);
  }

  var_0 setstance("_encstr_A5AD069B231F0BAF");
  wait 0.29;

  if(istrue(self.cancelplant))
    return 0;

  if(isDefined(var_0.linktoent)) {
    var_0 unlink();
    var_0.linktoent delete();
    var_0.linktoent = undefined;
  }

  thread create_player_rig(var_0);
  var_4 = 2.0;
  var_0 forceplaygestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED");
  wait(var_4);

  if(istrue(self.cancelplant))
    return 0;

  var_0 forceplaygestureviewmodel("_encstr_91FA18B395CDFA3DF66B894BAC9BD73956CEB467ACAF53DE6CD6");
  waitframe();

  if(istrue(self.cancelplant))
    return 0;

  var_0 forceplaygestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED");

  if(var_2 == 1) {
    for(var_5 = 0; var_5 < 1; var_5++) {
      wait(var_4);

      if(istrue(self.cancelplant))
        return 0;

      var_0 forceplaygestureviewmodel("_encstr_91FA18B395CDFA3DF66B894BAC9BD73956CEB467ACAF53DE6CD6");
      waitframe();

      if(istrue(self.cancelplant))
        return 0;

      var_0 forceplaygestureviewmodel("_encstr_B6E311E1953671A55DAF34A7CDADEB501B6AED");
    }
  }
}

crowbar_planted_think(var_0, var_1) {
  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  var_1 process_action_override("_encstr_83320ADDB7DB01AB8F3FF8E8", "_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73", "_encstr_8AE20E8B98AF3F0D288D2F5015C7B112");
  wait 0.1;
  level notify("_encstr_878C0E7B3750C3BFC89B979ED1F0CDDA", self.origin);
  remove_player_rig(var_0);
  var_1 notify("_encstr_83621899C792E5F805B1E37824FB69A52A73031B7B093C584A99" + var_1.target);
}

getplayerrotationforbreach(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_3 = var_0.opposite_struct.origin - var_1.origin;
  var_4 = (var_2 + var_3) / 2;
  var_5 = vectortoangles(var_4);
  return var_5;
}

getnumplayersusingthisinteraction(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(istrue(var_3.isbreaching)) {
      if(distance(var_3.origin, var_0.origin) <= 96)
        var_3.last_interaction_point = var_0;
    }

    if(isDefined(var_3.last_interaction_point) && isDefined(var_3.last_interaction_point.target)) {
      if(var_0.target == var_3.last_interaction_point.target) {
        if(istrue(var_3.isbreaching))
          var_1++;
      }
    }
  }

  return var_1;
}

getplayersusingthisinteraction(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_2++;

    if(isDefined(var_4.last_interaction_point) && isDefined(var_4.last_interaction_point.target)) {
      if(var_0.target == var_4.last_interaction_point.target) {
        if(isDefined(var_4.isbreaching) && var_4.isbreaching)
          var_1[var_2] = var_4;
      }
    }
  }

  return var_1;
}

setbreachernum(var_0, var_1, var_2) {
  var_3 = 1;

  if(var_0 == 1)
    var_1.breachernum = var_3;
  else if(var_0 == 2) {
    foreach(var_5 in getplayersusingthisinteraction(var_2)) {
      var_1.breachernum = var_3;
      var_3++;
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

  if(!nullweapon(var_1 getheldoffhand()))
    return 0;

  if(var_1 meleeButtonPressed())
    return 0;

  if(var_0.curprogress >= var_0.usetime)
    return 0;

  return 1;
}

watchplayerdeath(var_0) {
  self endon("_encstr_874010B5023760D6C3A939A092FB19080B6D");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_1 = undefined;

      foreach(var_3 in self.ents) {
        foreach(var_5 in var_3.parent.previewbomb) {
          if(var_5.script_label == "_encstr_846D0D4CBD5BC4BE0E9CAC672D95EE" || var_5.script_label == "_encstr_BAC20FFE656B294903E2414B540703B1AA")
            var_1 = var_5;
        }
      }

      self.useobjects[var_1.script_label] show();

      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

updatewaitforjoined() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    applyinteractteam(var_0);
  }
}

assigninteractteam(var_0) {
  foreach(var_2 in level.players)
  applyinteractteam(var_2);
}

applyinteractteam(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318") {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in self.ents) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.parent.previewbomb)) {
      continue;
    }
    foreach(var_5 in var_3.parent.previewbomb) {
      if(var_5.script_label == "_encstr_846D0D4CBD5BC4BE0E9CAC672D95EE" || var_5.script_label == "_encstr_BAC20FFE656B294903E2414B540703B1AA")
        var_1 = var_5;
    }
  }

  if(isDefined(self.useobjects)) {
    foreach(var_9 in self.useobjects) {
      var_9 enableplayeruse(var_0);
      var_9 showtoplayer(var_0);
    }
  }
}

killtriggerloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1)) {
      if(isPlayer(var_1)) {
        var_1 suicide();
        var_2 = var_1 getcorpseentity();
        var_2 hide(1);
        var_2.permhidden = 1;

        if(var_1.loadoutarchetype == "_encstr_965C10C227B143CA1D5E38B27DCD36BDBAA3")
          playFX(level._effect["_encstr_8BAD12721DBE4381E3198A61B0A9B760670BC585"], var_1.origin + (0, 0, 12));
        else
          playFX(level._effect["_encstr_ACC80DCE272D7346B2C9D7B65A8DD8"], var_1.origin + (0, 0, 12));

        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "_encstr_AB7D0B4593E88784DB08BA1298") {
            var_1 notify("_encstr_B6110FF80C36106A72E7A7BB337925D0D4");
            continue;
          }

          if(var_1.streakname == "_encstr_8AB60633E836170B")
            var_1 notify("_encstr_A2340A5D2752B7D09F9FCD59", var_1.origin);
        }
      }
    }
  }
}

droptonavmeshtriggers() {
  wait 1;
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (256, 800, 16), 0, 256, 500);
  var_0 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_0;
}