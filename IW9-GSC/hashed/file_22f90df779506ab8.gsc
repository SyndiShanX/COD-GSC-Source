/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22f90df779506ab8.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "onUserInit":
      return::_id_3DBD361F74B442F9;
    case "onUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "askForCoverFire":
      return::_id_BD30A256562F3CDC;
    case "agreeToCoverFire":
      return::_id_B98F00D5DB5E9C5D;
    case "volunteerToCoverFire":
      return::_id_05EF09B6972C9FAB;
    case "waitForCoverFire":
      return::_id_C753B2BAC95C6BFE;
    case "coveringFire":
      return::_id_32D11EF968F509A0;
    case "coveringFireCleanup":
      return::_id_DDF0D739DAA1D97C;
    case "changeCover":
      return::_id_E94882B86C7AADAC;
    case "tempDialogue":
      return::_id_30B70873A0937989;
    case "dialogue":
      return::dialogue;
    case "gesture":
      return _id_26F456DBDF9AA216::_id_5AD32AB5F21DDF93;
    case "setstationary":
      return::_id_46A6CB991C2A5D49;
    case "isChangingCover":
      return::_id_C3722414C55A6AE1;
    case "clearGoal":
      return::_id_8586052802BD2C79;
  }
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {
  self.keepclaimednode = 1;
  self.bulletsinclip = weaponclipsize(self.weapon);
}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  self clearbtgoal(1);
  self.maxfaceenemydist = 300;
  self aiclearscriptdesiredspeed();
  self notify("endcoverfire");
  self.keepclaimednode = 0;
  self.shootstyleoverride = undefined;

  if(!isalive(self))
    _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "death", 1);
}

_id_46A6CB991C2A5D49(statename, params) {
  self _meth_E64EA2B4E79C4B74(1);
  self setbtgoalRadius(1, params[0]);
}

_id_BD30A256562F3CDC(statename, params) {
  _id_7E18A8A72A7ADD37 = getaiarray(self.team);
  _id_7E18A8A72A7ADD37 = sortbydistance(_id_7E18A8A72A7ADD37, self.origin);
  other = _id_7E18A8A72A7ADD37[1];
  self endon("death");
  other endon("death");

  if(!isDefined(other)) {
    return;
  }
  _id_7D535542E36D66F9::_id_6FBEA72303085C6F(other, 1);
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_coverfire", "caps/interactions/cap_coverfire");
  _func_216C67AB6749137A(self, other, "moving");
  wait 1;
}

_id_B98F00D5DB5E9C5D(statename, params) {
  self endon("death");
  other = _id_CBE869548EA6BAAC("changingcover");

  if(!isDefined(other)) {
    return;
  }
  other endon("death");
  _id_7D535542E36D66F9::_id_6FBEA72303085C6F(other, 1, 0.8);
  wait 1;

  if(!isDefined(other) || !isDefined(self)) {
    return;
  }
  _func_216C67AB6749137A(self, other, "suppressing");
  wait 1;

  if(!isDefined(other) || !isDefined(self)) {
    return;
  }
  other _meth_1C339DAABA3F71DB(0);
  self _meth_1C339DAABA3F71DB(0);
}

_id_05EF09B6972C9FAB(statename, params) {
  other = _id_CBE869548EA6BAAC("changingcover");
  self endon("death");
  other endon("death");
  _id_7D535542E36D66F9::_id_6FBEA72303085C6F(other, 1);
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_coverfire", "caps/interactions/cap_coverfire_volunteer");
  _func_216C67AB6749137A(self, other, "suppressing");
  wait 1;
}

_id_C753B2BAC95C6BFE(statename, params) {
  _id_7E18A8A72A7ADD37 = getaiarray(self.team);
  _id_7E18A8A72A7ADD37 = sortbydistance(_id_7E18A8A72A7ADD37, self.origin);
  other = _id_7E18A8A72A7ADD37[1];
  self endon("death");
  other endon("death");
  wait 2;

  if(!isDefined(other) || !isDefined(self)) {
    return;
  }
  _id_7D535542E36D66F9::_id_6FBEA72303085C6F(other, 1);
  _func_216C67AB6749137A(self, other, "moving");
}

_id_32D11EF968F509A0(statename, params) {
  self endon("death");
  self endon("endcoverfire");
  other = _id_CBE869548EA6BAAC("changingcover");

  if(!isDefined(other)) {
    return;
  }
  other endon("death");
  self _meth_1C339DAABA3F71DB(0);
  self.maxfaceenemydist = 2048;
  _id_8D92E2462E6C7E1F = 3000;
  _id_ADC43CF18BAABED5 = gettime() + 10000;
  self.balwayscoverexposed = 1;
  self.providecoveringfire = 1;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.shootstyleoverride = "full";
}

_id_DDF0D739DAA1D97C(statename, params) {
  self.balwayscoverexposed = 0;
  self.providecoveringfire = 0;
}

_id_E94882B86C7AADAC(statename, params) {
  self endon("death");
  self endon("endcoverfire");
  self.maxfaceenemydist = 64;
  self aisetdesiredspeed(270);
  maxtime = 5000;
  starttime = gettime();
  self.keepclaimednode = 0;
  _func_216C67AB6749137A(self, undefined, "moving_up");

  while(isDefined(self.covernode))
    waitframe();

  while(!isDefined(self.covernode) && gettime() < starttime + maxtime)
    waitframe();
}

dialogue(statename, params) {
  if(isDefined(params[0]))
    _id_5D265B4FCA61F070::say(params[0]);
}

_id_C3722414C55A6AE1(statename) {
  return isDefined(self.covernode) || !isalive(self);
}

_id_8586052802BD2C79(statename) {
  self clearbtgoal(1);
}

_id_678BBF15AC4B000F(interval, func, param, _id_E3108E412AFB3811) {
  time = gettime() + interval;

  while(gettime() < time) {
    if(!isDefined(_id_E3108E412AFB3811))
      waitframe();

    if(isDefined(func)) {
      if(isDefined(param)) {
        self[[func]](param);
        continue;
      }

      self[[func]]();
    }
  }
}

_id_30B70873A0937989(_id_22E9090A351646E9) {}

_id_CBE869548EA6BAAC(tag) {
  id = self _meth_92435C7A6AE85C3C();
  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(id, tag);
  return _id_7E18A8A72A7ADD37[0];
}

_id_9867614BBD49F378(asmname, statename, params) {
  targetpos = undefined;

  if(isDefined(self.node) && distancesquared(self.node.origin, self.origin) > 1024)
    targetpos = self.node.origin;
  else if(isDefined(self.enemy))
    targetpos = self.enemy.origin;

  _id_077B9E4B599269EB = 0;

  if(isDefined(targetpos)) {
    _id_935CE979BB3EF270 = vectortoyaw(targetpos - self.origin);
    _id_077B9E4B599269EB = angleclamp180(_id_935CE979BB3EF270 - self.angles[1]);
  }

  turnanim = undefined;
  _id_5263A610669EFA35 = abs(_id_077B9E4B599269EB);
  animindex = 8;

  if(_id_5263A610669EFA35 > 135)
    animindex = 2;
  else if(_id_077B9E4B599269EB > 45 && _id_077B9E4B599269EB <= 135)
    animindex = 6;
  else if(_id_077B9E4B599269EB >= -135 && _id_077B9E4B599269EB < -45)
    animindex = 4;

  turnanim = _id_4E1D4DD23699A8A4::_id_18E6C36C02A94DBD(statename, statename + "_" + animindex);
  return turnanim;
}

_id_8FD655A41A26C662(asmname, statename, _id_F2B19B25D457C2A6, param) {
  if(!isDefined(self.prevcovernode))
    return 0;

  if(!isDefined(param))
    return 0;

  return self.prevcovernode.type == param;
}