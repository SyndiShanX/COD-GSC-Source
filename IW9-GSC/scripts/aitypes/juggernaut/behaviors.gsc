/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\juggernaut\behaviors.gsc
****************************************************/

juggernaut_init(taskid) {
  self.spec = "juggernaut";
  self.wearing_helmet = 1;
  self allowedstances("stand");
  self.juggernaut = 1;
  self.dontmeleeme = 1;
  self.minpaindamage = 500;
  self.grenadeammo = 0;
  self.doorflashchance = 0.05;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disablepistol = 1;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleedamageoverride = 400;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = 2500;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self._id_274D3A7704E351EF = 1;
  self._id_DF41B7F76F62D9A2 = 0;
  self._id_98ADD129A7ECB962 = 0;
  self._id_9440DC8A2AA90AED = 3000;
  self._id_7D606BEC79308EB5 = 750;
  self._id_85A0F6383A5DD784 = 300;
  self._id_A67833FEA11A521C = 750;
  self._id_0427CBD3288A2F59 = 300;
  self._id_5E7D402B7B6E5C12 = 25;
  self._id_20833644CC82839F = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self._id_B29C3655B12E292D = 0;
  self._id_717EB05B8FB85CFF = 40;
  self._id_E2B553399F5FF8A3 = 1000;
  self._id_E2D849399F862A5D = 2000;
  self._id_7878EF8B36BC3525 = 1000;
  self._id_789BF98B36E292DB = 2000;
  self._id_2D670E4D288C86FB = 1;
  self.combat_func_active = 1;
  self _meth_ AE41FBF799BA43F(1, "entity");
  self _meth_8BBCAEB23A1512EF("all", 0, "bt");
  self _meth_5847240C0F9900F2(0);

  if(!scripts\common\utility::issp() && !scripts\engine\utility::is_equal(level.gametype, "trial")) {
    self giveweapon("iw9_lm_dblmg_execution_mp");
    self giveexecution("jug_execution_000_stand_8", "iw9_lm_dblmg_execution_mp");
  }
}

juggernaut_shouldexecute(taskid) {
  _id_DC17DE3AAD9B4859 = 10000;
  _id_FD17B339E3ECF73C = 1;

  if(_id_FD17B339E3ECF73C && !istrue(self.ballowexecutions))
    return anim.failure;

  if(isDefined(self.timeoflastexecute) && gettime() - self.timeoflastexecute < _id_DC17DE3AAD9B4859)
    return anim.failure;

  if(istrue(self.onlyexecutefromthefront)) {
    _id_79B0B08B6461B1FF = self.origin - self.enemy.origin;
    _id_F38131FB9A95561A = vectortoyaw(_id_79B0B08B6461B1FF);
    angledelta = angleclamp180(_id_F38131FB9A95561A - self.enemy.angles[1]);

    if(angledelta < -45 || angledelta > 45)
      return anim.failure;
  }

  return anim.success;
}

juggernaut_setupexecute(taskid) {
  self.timeoflastexecute = gettime();
  _id_79B0B08B6461B1FF = self.origin - self.enemy.origin;
  _id_F38131FB9A95561A = vectortoyaw(_id_79B0B08B6461B1FF);
  angledelta = angleclamp180(_id_F38131FB9A95561A - self.enemy.angles[1]);
  _id_4EA1B715CF150E33 = "jug_execution_";
  _id_8C1A95A9ABCE46D8 = "_stand_";
  _id_2B33B2A868985889 = "00";
  dir = "8";

  if(angledelta < 45 && angledelta > -45) {
    _id_433FA147FA57A371 = randomint(4);
    _id_2B33B2A868985889 = _id_2B33B2A868985889 + _id_433FA147FA57A371;
  } else {
    _id_433FA147FA57A371 = randomint(2);
    _id_2B33B2A868985889 = _id_2B33B2A868985889 + _id_433FA147FA57A371;

    if(angledelta < -135 || angledelta > 135)
      dir = "2";
    else if(angledelta >= 45)
      dir = "4";
    else
      dir = "6";
  }

  _id_C5D77FD3C0F3BDDB = _id_4EA1B715CF150E33 + _id_2B33B2A868985889 + _id_8C1A95A9ABCE46D8 + dir;
  self giveexecution(_id_C5D77FD3C0F3BDDB, "iw9_lm_dblmg_execution_mp");
  return anim.success;
}

_id_AAD2563E98827B23(taskid) {
  self._id_F8C080BE8D680A2E = 1;

  if(self pathdisttogoal() > 256 && self aigetdesiredspeed() > 70)
    self._id_8B54FC69D81B03CF = 1;

  self._blackboard._id_7460B96395361857 = undefined;
  thread _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_jugg_sweep", "caps/common/cap_jugg_sweep");
  thread _id_9DB78F7B52B4AD06();
}

_id_C082B9EFBF242464(taskid) {
  if(isDefined(self._id_F8C080BE8D680A2E))
    return anim.running;

  return anim.success;
}

_id_E1138CCE8B2F28D4(taskid) {
  if(isDefined(self._id_F8C080BE8D680A2E)) {
    self._id_F8C080BE8D680A2E = undefined;

    if(!isDefined(self._blackboard._id_7460B96395361857))
      self._blackboard._id_7460B96395361857 = "abort";
  }
}

_id_9DB78F7B52B4AD06() {
  self endon("death");
  self waittill("cap_exit_completed");
  self._id_F8C080BE8D680A2E = undefined;
}