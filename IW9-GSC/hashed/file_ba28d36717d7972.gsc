/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_ba28d36717d7972.gsc
***********************************************/

_id_827E9869096F452F(taskid) {
  self allowedstances("stand");
  self.minpaindamage = 0;
  self._id_9AA77AB756FDCA82 = 0;
  self.aggressivemode = 1;
  self.disablereload = 1;
  self.dontevershoot = 1;
  self.allowstrafe = 0;
  self setengagementmaxdist(0.1, 768.0);
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleemaxzdiff = 100;
  self._id_C2D7CF1CFD42CBBB = 12100;
  self.meleebashmaxdistsq = 12100;
  self.meleetargetallowedoffmeshdistsq = 30625;
  self.meleetryhard = 1;
  self.meleeignorefinalzdiff = 1;
  self.meleeignoreplayerstance = 1;
  self._id_1A0D03789F333F98 = 10;
  self.pushable = 0;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.disablegrenaderesponse = 1;
  self.pathenemyfightdist = 0;
  self.maxfaceenemydist = 1200;
  self._id_98ADD129A7ECB962 = 0;
  self _meth_ AE41FBF799BA43F(1, "entity");
  self._id_8E3405AC46C40E0F = 0;
  self._id_D5E499E7FE2C490B = 0;
  self._id_54294E8BB0D07CDA = 0;
  self._id_C833409FB72D15FB = 1;
  self._id_CBDA25FEF016B253 = 1;
  self._id_9440DC8A2AA90AED = 500;
  self._id_7D606BEC79308EB5 = 8;
  self._id_85A0F6383A5DD784 = 70;
  self._id_788185F07AA6076E = 8000;
  self._id_07E9CD3125EF8A1F = 0;
  self._id_A67833FEA11A521C = 360;
  self._id_0427CBD3288A2F59 = 128;
  self._id_5E7D402B7B6E5C12 = 25;
  self._id_20833644CC82839F = 200;
  self._id_717EB05B8FB85CFF = 80;
  self._id_E2B553399F5FF8A3 = 1000;
  self._id_E2D849399F862A5D = 2000;
  self._id_7878EF8B36BC3525 = 1000;
  self._id_789BF98B36E292DB = 2000;
  self._id_C55E355AC8064555 = 400;
  self.maxfaceenemydist = 80;
  self._id_B3FA6C20CA52B960 = 0;
  self._id_CD251FBF5563EB4A = 0;
  self._id_F44C9CEDE4FB20D6 = 1;
  self._id_274D3A7704E351EF = 1;
  self._id_302574C170388345 = 2;
  self enabletraversals(0);
  self._id_80DF8C39483C18E9 = -1.0;
  self._id_7341CE07337943FC = "execution_baton_jailer_00";
  scripts\cp_mp\execution::_giveexecution(self._id_7341CE07337943FC);
  self._id_7DD3A351B4100995 = self.maxhealth * 0.5;
  self._id_2D8D11A34BE5B244 = ::_id_440AD18BB8B7DA30;
}

_id_3729E5E27DA73905(taskid) {
  if(!isDefined(self.maxhealth) || !isDefined(self.health) || !isDefined(self._id_725248D464D15738))
    return anim.failure;

  if(!self._id_725248D464D15738) {
    self._id_80DF8C39483C18E9 = -1.0;
    return anim.failure;
  }

  if(isDefined(self.flashendtime))
    return anim.failure;

  if(_id_440AD18BB8B7DA30()) {
    if(self._id_80DF8C39483C18E9 < 0) {
      self._id_80DF8C39483C18E9 = gettime() + 2000;
      _id_35DE402EFC5ACFB3::_id_D54E84A9513B0E45("guard_hostile_burst", "hostile_burst", 0, 0, 3);
    } else if(gettime() > self._id_80DF8C39483C18E9)
      return anim.success;

    return anim.running;
  } else
    return anim.failure;
}

_id_60CE9F4482409A3B(taskid) {
  self._id_80DF8C39483C18E9 = -1.0;
  return anim.success;
}

_id_B90B44351A9D3B87(taskid) {
  self _meth_1C339DAABA3F71DB(0);
}

_id_440AD18BB8B7DA30() {
  if(self.health < self._id_7DD3A351B4100995)
    return 1;

  return 0;
}