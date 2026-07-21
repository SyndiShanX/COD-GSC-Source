/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\target_marker.gsc
***********************************************/

init() {
  scripts\mp\playeractions::registeractionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_8F0508CE59DCA357392B"]);
}

gettargetmarker(var_0, var_1) {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  scripts\mp\playeractions::allowactionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var_2 = asmdevgetallstates(var_0.weaponname);
  var_3 = undefined;
  thread watchforinvalidweapon(var_2, var_0);
  thread watchforammouse(var_2, var_0);
  thread watchforempapply(var_2, var_0);

  if(!istrue(var_1)) {
    if(!isai(self)) {
      self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_A6E60A229B175A3B48A543AB");
      self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

      if(!self isconsoleplayer()) {
        self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
        self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
        self notifyonplayercommand("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
      }
    }
  }

  for(;;) {
    var_3 = waittill_succeed_fail_end("_encstr_859917A2DB4D5FE2F9C17568F950683FF6F35A4A212D239FF8", "_encstr_87141435F95FA07141DA882872653B3E7B914B3945A3", "_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", "_encstr_AF98149D096B11095F8A71A019221A88E0494EDFF754", "_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");

    if(var_3.string == "_encstr_AF98149D096B11095F8A71A019221A88E0494EDFF754") {
      break;
    } else {
      if(var_3.string == "_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1") {
        if(!istrue(var_1)) {
          break;
        } else
          scripts\mp\hud_message::showerrormessage("_encstr_BD861A2D529889352A92A20A69D45E86A027937A51D76ABA92456812");

        continue;
      }

      if(var_3.string == "_encstr_87141435F95FA07141DA882872653B3E7B914B3945A3") {
        scripts\mp\hud_message::showerrormessage("_encstr_AF921D67B9FD894EB3F97DE570F738B9C6C6E5F70C9121BD77F154ED988755");
        continue;
      }

      if(isDefined(var_3) && var_3.string == "_encstr_859917A2DB4D5FE2F9C17568F950683FF6F35A4A212D239FF8") {
        if(updatecallback(var_3)) {
          scripts\mp\hud_message::showerrormessage("_encstr_8B7A241AE09B2C77291BE54D3969EEBD21DD9827A1B7667B7158E157ED4DE9C8CAC4CBD73742");
          continue;
        } else if(!self isonground() || self isonladder()) {
          scripts\mp\hud_message::showerrormessage("_encstr_AF8121A5A43189A65129A20A2DA95E860A2793E945D7842AF5413128D05111AF5092A4");
          continue;
        } else if(_calloutmarkerping_handleluinotify_enemyrepinged::updateleaders()) {
          scripts\mp\hud_message::showerrormessage("_encstr_973A2469526289A64525510AA56A97688239C9F445FA90A2D7829805A1A811EB355512D58295");
          continue;
        }
      }

      break;
    }
  }

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_4 = var_3.location + (0, 0, 20);
    var_5 = var_3.location + (0, 0, -1000);
    var_6 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_87991799DBEBC6C8EB52F9703DC490F0932F4FC3B712014B10", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"];
    var_7 = physics_createcontents(var_6);
    var_8 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_7);

    if(isDefined(var_8["_encstr_850E077B0BF30318B9"])) {
      var_9 = var_8["_encstr_850E077B0BF30318B9"];
      var_3.moving_platform = var_9;
      var_10 = var_3.location - var_9.origin;
      var_11 = vectordot(var_10, anglesToForward(var_9.angles));
      var_12 = -1.0 * vectordot(var_10, anglestoright(var_9.angles));
      var_13 = vectordot(var_10, anglestoup(var_9.angles));
      var_3._id_11DBE = (var_11, var_12, var_13);
      var_3._id_11DBD = combineangles(invertangles(var_9.angles), var_3.angles);
    }

    var_3.visual = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.location + var_3.fxoffset);
    var_3.visual.angles = var_3.angles;

    if(var_0.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48")
      var_3.visual setModel("_encstr_9A9A197F4791D38FB57F77DF53256A20B559D5F813FFE79BF188E7");

    if(isDefined(var_3.visual.model) && var_3.visual.model != "_encstr_B40101") {
      var_3.visual setotherent(self);
      var_3.visual setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_B8B00782A191CB07D9", 0);
    }
  }

  if(scripts\mp\utility\player::isreallyalive(self))
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, scripts\mp\playeractions::allowactionset, "_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 1);
  return var_3;
}

updatecallback(var_0) {
  var_1 = 0;
  var_2 = var_0.location;

  if(!scripts\engine\trace::sphere_trace_passed(var_2 + (0, 0, 100), var_2, 20, undefined, scripts\engine\trace::create_character_contents()))
    var_1 = 1;

  return var_1;
}

watchforinvalidweapon(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  for(;;) {
    if(self getcurrentweapon() != var_0) {
      self notify("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
      break;
    }

    waitframe();
  }
}

watchforammouse(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  var_2 = self getweaponammoclip(var_0);

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_3);

    if(var_3 == var_0)
      self setweaponammoclip(var_3, var_2);
  }
}

watchforempapply(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  self waittill("_encstr_AB770C81EB09798E707B29137D77");
  self notify("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
}

waittill_succeed_fail_end(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_return(var_0, var_5);

  if(isDefined(var_1))
    childthread waittill_return(var_1, var_5);

  if(isDefined(var_2))
    childthread waittill_return(var_2, var_5);

  if(isDefined(var_3))
    childthread waittill_return(var_3, var_5);

  if(isDefined(var_4))
    childthread waittill_return(var_4, var_5);

  childthread waittill_return("_encstr_AD75063D571AE108", var_5);
  var_5 waittill("_encstr_BE3009989F7CABE51AAFDD", var_6, var_7, var_8, var_9, var_10);
  var_5 notify("_encstr_B81804322D2B");
  var_11 = spawnStruct();
  var_11.weapon = var_7;
  var_11.location = var_8;
  var_11.angles = var_9;
  var_11.string = var_10;
  var_11.fxoffset = var_6;
  return var_11;
}

waittill_return(var_0, var_1) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3, var_4, var_5);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_2, var_3, var_4, var_5, var_0);
}