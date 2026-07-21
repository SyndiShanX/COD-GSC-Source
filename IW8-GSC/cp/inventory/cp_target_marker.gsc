/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\inventory\cp_target_marker.gsc
***********************************************/

init() {
  scripts\mp\playeractions::registeractionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_8F0508CE59DCA357392B"]);
}

gettargetmarker(var_0, var_1) {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\mp\playeractions::allowactionset("_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 0);
  scripts\mp\utility\entity::_enableequipdeployvfx();
  var_2 = asmdevgetallstates(var_0.weaponname);
  var_3 = undefined;
  thread watchforinvalidweapon(var_2, var_0);
  thread watchforlaststand(var_0);
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
    var_3 = waittill_succeed_fail_end("_encstr_859917A2DB4D5FE2F9C17568F950683FF6F35A4A212D239FF8", "_encstr_87141435F95FA07141DA882872653B3E7B914B3945A3", "_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");

    if(var_3.string == "_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1") {
      if(!istrue(var_1)) {
        break;
      } else
        scripts\cp\cp_hud_message::showerrormessage("_encstr_BD861A2D529889352A92A20A69D45E86A027937A51D76ABA92456812");

      continue;
    }

    if(var_3.string == "_encstr_87141435F95FA07141DA882872653B3E7B914B3945A3") {
      scripts\cp\cp_hud_message::showerrormessage("_encstr_AF921D67B9FD894EB3F97DE570F738B9C6C6E5F70C9121BD77F154ED988755");
      continue;
    }

    break;
  }

  if(isDefined(var_3.location) && isDefined(var_3.angles)) {
    var_3.visual = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.location + var_3.fxoffset);
    var_3.visual.angles = var_3.angles;

    if(var_0.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48")
      var_3.visual setModel("_encstr_9A9A197F4791D38FB57F77DF53256A20B559D5F813FFE79BF188E7");
    else if(var_0.streakname == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4" || var_0.streakname == "_encstr_AA060B6EB2731DE4BCFAEC57E6")
      var_3.visual setModel("_encstr_91C41BA8C32123D1BB7DBF217FFB9BA5D20AC8815AC655A84F82A8A948");
    else
      var_3.visual setModel("_encstr_8AF40D5B6EEBDA85396DB293F5B50E");

    var_3.visual setotherent(self);
    var_3.visual setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_B8B00782A191CB07D9", 0);
  }

  if(scripts\cp_mp\utility\player_utility::_isalive())
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  scripts\mp\utility\entity::_disableequipdeployvfx();
  thread scripts\engine\utility::delaythread(0.05, scripts\mp\playeractions::allowactionset, "_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 1);
  return var_3;
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

watchforlaststand(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  scripts\mp\utility\entity::_disableequipdeployvfx();
  self.bgivensentry = 0;
  thread scripts\engine\utility::delaythread(0.05, scripts\mp\playeractions::allowactionset, "_encstr_A50E0E73A67238B54B6FC3E3E3828DD8", 1);

  if(scripts\cp_mp\utility\player_utility::_isalive())
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

watchforempapply(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  self waittill("_encstr_863E11C3C30331C04F4FB02BF94820FFCBFF9D");
  self notify("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1");
}

waittill_succeed_fail_end(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_return(var_0, var_3);

  if(isDefined(var_1))
    childthread waittill_return(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_return(var_2, var_3);

  childthread waittill_return("_encstr_AD75063D571AE108", var_3);
  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4, var_5, var_6, var_7, var_8);
  var_3 notify("_encstr_B81804322D2B");
  var_9 = spawnStruct();
  var_9.weapon = var_5;
  var_9.location = var_6;
  var_9.angles = var_7;
  var_9.string = var_8;
  var_9.fxoffset = var_4;
  return var_9;
}

waittill_return(var_0, var_1) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3, var_4, var_5);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_2, var_3, var_4, var_5, var_0);
}