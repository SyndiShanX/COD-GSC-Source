/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\mortar_launcher.gsc
***********************************************/

mortar_launcher_init() {
  load_fx();
  var_0 = getEntArray("_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0) && var_0.size > 0) {
    setupmortarmodelanimscripts();
    setupmortarplayeranimscripts();
  } else
    return;

  foreach(var_2 in var_0) {
    if(istrue(level.ismp)) {
      if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
        var_2 delete();
        continue;
      }
    }

    var_2 thread mortar_test(var_2);
  }
}

load_fx() {
  level._effect["_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"] = loadfx("_encstr_B44C2A2E959895C7DC6A86BA29B40FBDCA0BBD823398CACFA89B0A0376016F72A8EB3A3745E0526717F3020B");
  level._effect["_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"] = loadfx("_encstr_84DF2B2B8173EE0CE011471CB330D72B30B852A2E84C8F404AA506782FC01D2BC5311BA9F3A647BC686D2EE659");
  level._effect["_encstr_AC3C1560B2C867705F9AD5477277B9D132FA30C0FAA54D"] = loadfx("_encstr_B6D13767330FF24BDD70CBEEB258C1F2AF2BE10E367B795BED27A3C2C9BCEC333CFADADBE43A58277D56E1071BB7B94B7BB9D713B571EC663C");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

setupmortarplayeranimscripts() {
  level.scr_animtree["_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5"] = #animtree;
  level.scr_anim["_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = % _encstr_8D3515AC6B317D67DAEBB6B7398E0BC9EB1CB1162FACC9;
  level.scr_animname["_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = "_encstr_8D3515AC6B317D67DAEBB6B7398E0BC9EB1CB1162FACC9";
  level.scr_eventanim["_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = "_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B";
  level.scr_viewmodelanim["_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = "_encstr_8D3515AC6B317D67DAEBB6B7398E0BC9EB1CB1162FACC9";
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

setupmortarmodelanimscripts() {
  level.scr_animtree["_encstr_B6DF07A09FB6288BD6"] = #animtree;
  level.scr_model["_encstr_B6DF07A09FB6288BD6"] = "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693";
  level.scr_anim["_encstr_B6DF07A09FB6288BD6"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = % _encstr_85FD155DB5CA572B8DA7B8B00BCC814561DDC05E4B52D5;
  level.scr_animname["_encstr_B6DF07A09FB6288BD6"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = "_encstr_85FD155DB5CA572B8DA7B8B00BCC814561DDC05E4B52D5";
  level.scr_viewmodelanim["_encstr_B6DF07A09FB6288BD6"]["_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B"] = "_encstr_85FD155DB5CA572B8DA7B8B00BCC814561DDC05E4B52D5";
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.animname = var_1;
  var_0 predictstreampos(var_0.origin);
  var_4 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_4.player = var_0;
  var_0.player_rig = var_4;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
}

put_player_into_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 scripts\common\utility::allow_ads(0);
  var_6 scripts\common\utility::allow_prone(0);
  var_6 scripts\common\utility::allow_crouch(0);
  var_6 scripts\common\utility::allow_weapon_switch(0);

  if(var_1 > 0.0) {
    var_6 playerlinktoblend(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0, 0);
    wait(var_1);
  }

  var_6 playerlinktodelta(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", 1, var_2, var_3, var_4, var_5, 1);
}

take_player_out_of_rig(var_0) {
  var_0 scripts\common\utility::allow_weapon(1, "_encstr_B6DF07A09FB6288BD6");
  var_0 scripts\common\utility::allow_ads(1);
  var_0 scripts\common\utility::allow_prone(1);
  var_0 scripts\common\utility::allow_crouch(1);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 unlink();
  var_0.player_rig delete();
}

mortar_launch_player_effect(var_0, var_1) {
  if(!istrue(level.ismp))
    var_1 playSound("_encstr_951611547F8ED0F7B73D43DB878389D5A09E69");

  wait 2.2;
  var_0 playRumbleOnEntity("_encstr_853B0E216F3A5FC89D2949A30D4C2B0D");
  earthquake(0.24, 1, var_1.origin, 256);
  var_1 hidepart(var_1.shell, "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
}

movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089", "_encstr_87070320DF");

  if(getdvarint("_encstr_996F134B0A7A8790BFA860EBE0B6C11079C8D15089")) {
    var_0.origin = var_1;
    var_5 = getdvarint("_encstr_979A08F619C1EA8361C7");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      var_0 anglemortar();
      waitframe();
    }
  } else {
    var_11 = 1200;

    if(isDefined(var_4))
      var_11 = var_4;

    var_12 = 1 / (var_3 / 0.05);
    var_13 = 0;

    while(var_13 < 1) {
      var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
      var_0 anglemortar();
      var_13 = var_13 + var_12;
      wait 0.05;
    }

    var_0.origin = var_2;
  }
}

anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

#using_animtree("_encstr_B40101");

mortar_test(var_0) {
  if(!istrue(level.ismp))
    var_0.interact = mortarlauncher_createhintobject(var_0.origin + (0, 0, 40), "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A536220FA150B8AF8106F30B1C318F908213872BFB7C1063624F3D057559CC386CBB2BE3", undefined, undefined, "_encstr_BD1805CB69C063", 50, 160, 32, 120);
  else
    var_0.interact = mortarlauncher_createhintobject(var_0.origin + (0, 0, 40), "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_859E1A9122C1A3E46F277139774F3C7149051506CF79E38C026B2999", undefined, undefined, "_encstr_BD1805CB69C063", 256, 160, 128, 160);

  var_0.flash = "_encstr_A9810C98BF98634B92DDA911C7CB";
  var_0.shell = "_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159";
  var_0 hidepart(var_0.shell, "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  var_0.animname = "_encstr_B6DF07A09FB6288BD6";
  var_0 useanimtree(#animtree);
  var_0.og_angles = var_0.angles;

  for(;;) {
    var_0.interact makeusable();
    var_0.interact waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_1 scripts\common\utility::allow_usability(0);
    var_0.interact makeunusable();
    player_launch_mortar(var_1, var_0);
    wait 5;
    var_0 rotateTo(var_0.og_angles, 0.1);
    wait 1;
  }
}

player_launch_mortar(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 setOrigin(var_1.origin);
  var_0 setplayerangles(var_1.angles);
  var_0 create_player_rig(var_0, "_encstr_8BEA0E435AA8CAAA184F2D772D2C20D5");
  var_0.player_rig.angles = var_1.angles;
  put_player_into_rig(var_0.player_rig, 0.5, 0, 0, 0, 0, var_0);
  var_0 scripts\common\utility::allow_weapon(0, "_encstr_B6DF07A09FB6288BD6");
  var_2 = var_0 mortar_targetting(var_1);

  if(isDefined(var_2)) {
    var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
    var_3 = vectortoangles(var_2 - var_1.origin);
    var_1.angles = (0, var_3[1], 0);
    var_1 showpart(var_1.shell, "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
    var_0.player_rig show();
    var_1 scripts\engine\utility::delaythread(2.25, ::launch_mortar, var_2, var_0);
    thread mortar_launch_player_effect(var_0, var_1);
    var_1 thread scripts\common\anim::anim_single([var_1, var_0.player_rig], "_encstr_9B4D130323307337D051255FCE8BBF328F3DC0A09B");
    var_0.player_rig waittillmatch("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A");
    var_1 notify("_encstr_BAF40DB5ED9C1D5839BECC9627AC8C");
  }

  var_0 scripts\common\utility::allow_usability(1);
  var_1 hidepart(var_1.shell, "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  take_player_out_of_rig(var_0);

  if(isDefined(var_1.previs_model))
    var_1.previs_model delete();
}

mortar_targetting(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread mortar_ondeathcleanup(var_0);
  var_1 = undefined;
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 45, 45, 60, 60, 1);

  if(isDefined(var_0.previs_model))
    var_0.previs_model setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_930B07BB1B6B3854FF");

  for(;;) {
    if(self stancebuttonPressed() || self attackButtonPressed()) {
      if(self attackButtonPressed()) {
        while(self attackButtonPressed())
          wait 0.05;

        return var_1;
      }

      while(self stancebuttonPressed())
        wait 0.05;

      return undefined;
    }

    var_2 = scripts\engine\trace::ray_trace(self getEye() + (0, 0, 128), self getEye() + anglesToForward(self getplayerangles()) * 16000);
    var_1 = getgroundposition(var_2["_encstr_BD260953AA97E3F014279D"], 8, 0, 1500);
    var_3 = vectortoangles(var_1 - var_0.origin);
    var_0.angles = (0, var_3[1], 0);

    if(!isDefined(var_0.previs_model)) {
      var_0.previs_model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
      var_0.previs_model setModel("_encstr_8F520E6BF6E4E8C227D78E8593D9AC1D");
      var_0.previs_model.angles = (-90, 0, 0);
      var_0.previs_model setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_930B07BB1B6B3854FF");

      foreach(var_5 in level.players)
      var_0.previs_model hidefromplayer(var_5);

      var_0.previs_model showtoplayer(self);
    }

    var_0.previs_model moveTo(var_1 + (0, 0, 10), 0.1);
    wait 0.05;
  }
}

mortar_ondeathcleanup(var_0) {
  var_0 endon("_encstr_BAF40DB5ED9C1D5839BECC9627AC8C");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0.previs_model))
    var_0.previs_model delete();
}

launch_mortar(var_0, var_1) {
  var_2 = self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB");
  var_3 = getgroundposition(self.origin + anglesToForward(self.angles) * 8000, 8, 1000);

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), (0, 0, 0));
  var_4 setModel("_encstr_99A0281521632C9FF8D7C843B1B56FE20D7EA8C9AF2A2B458B41D002FAED0833A3FADDDD4F98C3B085CB");
  playFX(scripts\engine\utility::getfx("_encstr_935811B333E1AFCC8DC29CB2AF3616EACDB134"), self.origin + (0, 0, 3) + anglesToForward(self.angles) * 8, anglesToForward(self.angles));

  if(!istrue(level.ismp))
    playsoundatpos(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), "_encstr_8F8D198F054F9B19C5FF15D48ACA3FFE928A4B971F74392FEE200B");
  else
    playsoundatpos(self gettagorigin("_encstr_A9810C98BF98634B92DDA911C7CB"), "_encstr_8F8D198F054F9B19C5FF15D48ACA3FFE928A4B971F74392FEE200B");

  var_4 show();
  var_5 = 5;
  thread movemortar(var_4, var_2, var_3, var_5, 1200);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!istrue(level.ismp))
    var_4 playLoopSound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");
  else
    var_4 playLoopSound("_encstr_B1F913170377C39FD05832BBB193D71A59932FF3D1");

  wait(var_5 - 1.7);

  if(!istrue(level.ismp))
    var_4 playSound("_encstr_8D6815EEACC2E0FAADBDC98EB0C97D4BDC36EDADB4E6CE");

  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_A7BE11D38041791F48A6ECF1BE96A3FA9B4BFA"), var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 stoploopsound();
  playFX(scripts\engine\utility::getfx("_encstr_AC3C1560B2C867705F9AD5477277B9D132FA30C0FAA54D"), var_3);
  earthquake(0.25, 3, var_3, 2048);

  if(!istrue(level.ismp))
    playrumbleonposition("_encstr_97011287E9A8326880FBF2BF9329BAEB19652317", var_3);
  else {
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_3);
    playsoundatpos(var_3, "_encstr_88FA177353CF60A7A86F868BEF525F20D99B81B9E340BABDDA");
  }

  magicgrenademanual("_encstr_A5EF0A384DEA382F83D76B59", var_3 + (0, 0, 5), (0, 0, 0), 0.05);

  if(!istrue(level.ismp))
    radiusdamage(var_3 + (0, 0, 5), 512, 250, 250, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");
  else
    radiusdamage(var_3 + (0, 0, 5), 512, 1000, 250, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");

  var_4 delete();
}

kill_mortar_target() {
  self.previs_model setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_A7A408B9CA5D1D4E2C63");
}

mortarlauncher_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11))
    var_12 = var_11;
  else
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);

  var_12 makeusable();

  if(isDefined(var_11) && isDefined(var_0))
    var_12 sethinttag(var_0);

  if(isDefined(var_1))
    var_12 setCursorHint(var_1);
  else
    var_12 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  if(isDefined(var_2))
    var_12 sethinticon(var_2);

  if(isDefined(var_3))
    var_12 setHintString(var_3);

  if(isDefined(var_4))
    var_12 setusepriority(var_4);
  else
    var_12 setusepriority(0);

  if(isDefined(var_5))
    var_12 setuseholdduration(var_5);
  else
    var_12 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_6))
    var_12 sethintonobstruction(var_6);
  else
    var_12 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    var_12 sethintdisplayrange(var_7);
  else
    var_12 sethintdisplayrange(200);

  if(isDefined(var_8))
    var_12 sethintdisplayfov(var_8);
  else
    var_12 sethintdisplayfov(160);

  if(isDefined(var_9))
    var_12 setuserange(var_9);
  else
    var_12 setuserange(50);

  if(isDefined(var_10))
    var_12 setusefov(var_10);
  else
    var_12 setusefov(120);

  if(!isDefined(var_11))
    return var_12;
}