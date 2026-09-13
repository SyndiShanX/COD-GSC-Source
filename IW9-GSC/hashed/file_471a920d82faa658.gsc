/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_471a920d82faa658.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "onUserInit":
      return::_id_3DBD361F74B442F9;
    case "onUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "CalcStartOrigin":
      return::_id_18ADD0932F52EE9E;
    case "CalcAdditionalPos":
      return::_id_17C9514D056F8B0C;
    case "CanSupport":
      return::_id_E62B12681729B218;
    case "PathHasInvalidDoorCondition":
      return::_id_17557D7A61C7B24A;
    case "ArrivalSetup":
      return::_id_217DFEB1C92A9A53;
    case "SetDualEntry":
      return::_id_AF686E8A0657CE57;
    case "OnArrival":
      return::_id_EC9DC4B6415CD3B9;
    case "OnEnter":
      return::onenter;
    case "GoalCheckDelay":
      return::_id_8055622A418EBD4F;
    case "GoalCheckCleanup":
      return::_id_767FB54813708A82;
    case "ShouldExitEarly":
      return::_id_27937CCB1B1ABEF1;
    case "HasArrived":
      return::_id_23CD7F6FDF460EB4;
    case "ReachedIdle":
      return::_id_21BCB65DED71229F;
  }

  return _id_53651341190C5AAB::_id_EFCEA5D26798E5B6(_id_CC4F2E0388379546);
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {
  setdvarifuninitialized("dvar_6BFF7F7A44419FCE", 0);

  if(!isDefined(_func_060D6151AF81A343(_id_F8D4ED108521E632, "breachtype"))) {
    types = ["breach", "kick", "flashbang"];
    type = scripts\engine\utility::random(types);
    _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "breachtype", type);
  }

  if(isDefined(self.node))
    self._id_098A95D7433B5618 = self.node;
}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  if(isDefined(self._id_B4C85F2BC7ABB407) && isDefined(self._id_B4C85F2BC7ABB407._id_9C471C82ABE76355)) {
    self.script_pushable = self._id_B4C85F2BC7ABB407._id_9C471C82ABE76355;
    self._id_D28E54645050DF58 = self._id_B4C85F2BC7ABB407._id_512299FF86496AD6;
  }

  self._id_836489FAD2CCC639 = undefined;
  self._id_098A95D7433B5618 = undefined;
  self clearbtgoal(3);
  self._id_B4C85F2BC7ABB407 = undefined;
  self._id_DDAD29BBDECD1671 = undefined;

  if(self._id_A942DD31D55102C9 != self.asmname)
    _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();

  _id_7E18A8A72A7ADD37 = _func_ADF0D34FF483C35A(_id_F8D4ED108521E632);

  if(_id_7E18A8A72A7ADD37.size == 1) {
    doorid = _func_060D6151AF81A343(_id_F8D4ED108521E632, "doorindex");

    if(isDefined(doorid))
      _func_ E415E810D4E34ED(doorid, gettime() + 10000);
  }
}

_id_18ADD0932F52EE9E(statename, role) {
  id = self _meth_92435C7A6AE85C3C();
  origin = _func_BBFC94714C82788B(id);
  angles = _func_785F60047ABCFA05(id);
  _id_DAD5E6255A5BF2AC = anglesToForward(angles);
  _id_5C6AFC1001475042 = origin - self.origin;
  _id_775361D05A790917 = vectorcross(_id_5C6AFC1001475042, _id_DAD5E6255A5BF2AC);
  _id_2480E63EC7F4DE84 = 1;

  if(_id_775361D05A790917[2] < 0)
    _id_2480E63EC7F4DE84 = 0;

  idlestate = "door_idle";

  if(_id_2480E63EC7F4DE84)
    _id_9178C0EEF9E08EB1 = "left";
  else
    _id_9178C0EEF9E08EB1 = "right";

  _id_28D48E48018C61BA = _func_060D6151AF81A343(id, "door_knob");

  if(isDefined(_id_28D48E48018C61BA))
    _id_9178C0EEF9E08EB1 = _id_28D48E48018C61BA;

  if(role == "active")
    _func_AE368FAD1A1DC337(id, "activeside", _id_9178C0EEF9E08EB1);
  else {
    _id_8C2EA312139F3FDE = _func_060D6151AF81A343(id, "activeside");

    if(_id_8C2EA312139F3FDE == "left")
      _id_9178C0EEF9E08EB1 = "right";
    else
      _id_9178C0EEF9E08EB1 = "left";
  }

  _id_BCACB6B68B075492 = _func_060D6151AF81A343(id, "openness");

  if(isDefined(_id_BCACB6B68B075492))
    _id_BCACB6B68B075492 = abs(_id_BCACB6B68B075492);

  if(!istrue(_func_060D6151AF81A343(id, "path_has_door")) || isDefined(_id_BCACB6B68B075492) && _id_BCACB6B68B075492 > 45)
    _id_9178C0EEF9E08EB1 = _id_9178C0EEF9E08EB1 + "_doorless";

  type = _func_060D6151AF81A343(id, "breachtype");
  _id_975BE27F963E2F30 = type;
  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, _id_975BE27F963E2F30);
  animset = _id_996949B7474560EB.animation;
  _id_2C8936D08F85C5C1 = archetypegetrandomalias(animset, idlestate, _id_9178C0EEF9E08EB1, 0);
  xanim = animsetgetanimfromindex(animset, idlestate, _id_2C8936D08F85C5C1);
  _id_78FF943CA85E1279 = getstartorigin(origin, angles, xanim);
  _id_D78735C0A8459B07 = getstartangles(origin, angles, xanim);
  _id_6F0A02205DD25D2E = getclosestpointonnavmesh(_id_78FF943CA85E1279, self, 0, 1, 0);

  if(isDefined(_id_6F0A02205DD25D2E))
    _id_78FF943CA85E1279 = _id_6F0A02205DD25D2E;

  self._id_A57082FDF62BC898 = _id_9178C0EEF9E08EB1 + "_door_arrival";
  self._id_33B4C07D1F388776 = animset;
  self._id_0A41EDF45BB0FF97 = angles;
  self._id_B7C243F293B096D2 = _id_D78735C0A8459B07;
  self._id_171120E99DF3E286 = 1;
  self._id_A2A6C6C46DEFE8C4 = 1;
  self._id_B4C85F2BC7ABB407 = spawnStruct();
  self._id_B4C85F2BC7ABB407.asmname = _id_996949B7474560EB._id_3E38EE41DC326FDC;
  self._id_B4C85F2BC7ABB407._id_AE3EA15396B65C1F = animset;
  self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F = _id_9178C0EEF9E08EB1;
  self._id_B4C85F2BC7ABB407.angles = _id_D78735C0A8459B07;
  self._id_B4C85F2BC7ABB407._id_2B1676BAB1BA8985 = "solo";
  self._id_B4C85F2BC7ABB407.role = role;
  self._id_B4C85F2BC7ABB407._id_78FF943CA85E1279 = _id_78FF943CA85E1279;

  if(role == "support")
    self._id_B4C85F2BC7ABB407._id_2B1676BAB1BA8985 = "dual";

  self._id_DDAD29BBDECD1671 = ::_id_DDAD29BBDECD1671;
  return _id_78FF943CA85E1279;
}

_id_17C9514D056F8B0C(statename, _id_636C8575D7A7768B, maxdist) {
  id = self _meth_92435C7A6AE85C3C();
  origin = _func_BBFC94714C82788B(id);
  _id_9DFA31B22E1F2822 = vectorNormalize(self.origin - origin);
  dist = randomintrange(_id_636C8575D7A7768B, maxdist);
  endpoint = origin + _id_9DFA31B22E1F2822 * dist;
  point = findclosestlospointwithinradius(origin, maxdist, origin, endpoint);

  if(!isDefined(point)) {
    point = _func_F0EF5D175747F19F(endpoint);

    if(isDefined(point))
      return point.origin;
    else
      point = self getclosestreachablepointonnavmesh(endpoint);
  }

  return point;
}

_id_DDAD29BBDECD1671() {
  self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D = 1;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(self._id_B4C85F2BC7ABB407.asmname, self._id_B4C85F2BC7ABB407._id_AE3EA15396B65C1F);
}

_id_217DFEB1C92A9A53(statename, params) {}

_id_6D35024A1F783A16(statename, params) {
  self._id_A57082FDF62BC898 = undefined;
  self._id_33B4C07D1F388776 = undefined;
  self._id_0A41EDF45BB0FF97 = undefined;
  self._id_B7C243F293B096D2 = undefined;
  self._id_171120E99DF3E286 = 0;
  self._id_A2A6C6C46DEFE8C4 = 0;
}

_id_D104EA3FD0D1BE21(_id_F8D4ED108521E632, _id_D293838FE8A43473) {
  _id_7449DF250ED378C2 = _func_060D6151AF81A343(_id_F8D4ED108521E632, "door");

  if(isDefined(_id_7449DF250ED378C2) && _id_7449DF250ED378C2 scriptabledoorisclosed())
    _id_7449DF250ED378C2 scriptabledooropen("away", self.origin);
}

_id_EC9DC4B6415CD3B9(statename, params) {
  if(!istrue(self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D)) {
    _id_6D35024A1F783A16();
    _id_010B6724C15A95E8::_id_C434AF0895CC147C(self._id_B4C85F2BC7ABB407.asmname, self._id_B4C85F2BC7ABB407._id_AE3EA15396B65C1F);
  }

  self._id_836489FAD2CCC639 = 1;
  self._id_B4C85F2BC7ABB407._id_9C471C82ABE76355 = self.script_pushable;
  self._id_B4C85F2BC7ABB407._id_512299FF86496AD6 = self._id_D28E54645050DF58;
  self.script_pushable = 0;
  self._id_D28E54645050DF58 = 0;
  _id_8CBC802E0992BE6F = self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F;
  _id_38B98BFA4426BCF9 = self._id_B4C85F2BC7ABB407._id_2B1676BAB1BA8985;
  _id_4148B1F68BF5D60A = self._id_B4C85F2BC7ABB407.role;
  self._id_B4C85F2BC7ABB407._id_C58C71EBC71F7728 = _id_8CBC802E0992BE6F + "_" + _id_38B98BFA4426BCF9 + "_" + _id_4148B1F68BF5D60A;
  self _meth_FB02BE5D663ECA13();
  id = self _meth_92435C7A6AE85C3C();
  _id_121A3ED8C85DB0D4 = _func_060D6151AF81A343(id, "breachtype");
  _id_48D356C204BF2B81 = isDefined(_id_121A3ED8C85DB0D4) && _id_121A3ED8C85DB0D4 == "flashbang";

  if(_id_48D356C204BF2B81 && _func_060D6151AF81A343(id, "path_has_door"))
    _id_D104EA3FD0D1BE21(id, self.origin);
}

onenter(statename, params) {
  self endon("death");
  self._id_B4C85F2BC7ABB407._id_3F651B778E93656E = 1;

  if(isDefined(self._id_722A29E5A0428A0F)) {
    self setbtgoalnode(3, self._id_722A29E5A0428A0F);
    self._id_722A29E5A0428A0F = undefined;
  }

  endtime = gettime() + 5000;
  waitframe();

  while(gettime() < endtime) {
    if(self asmeventfired(self.asmname, "end")) {
      break;
    }

    waitframe();
  }
}

_id_27DC505064BCF45B(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_B4C85F2BC7ABB407._id_74C9B1F78857273D);
}

_id_57787698E416086F(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self._id_B4C85F2BC7ABB407._id_3F651B778E93656E);
}

_id_14242F7E3E92261C(asmname, statename, params) {
  alias = self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_0CFA7813E89867C4(asmname, statename, params) {
  alias = self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F + "_" + self._id_B4C85F2BC7ABB407._id_2B1676BAB1BA8985 + "_" + self._id_B4C85F2BC7ABB407.role;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

_id_CE30AC74CAB64CFD(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "door_open")
    _id_D104EA3FD0D1BE21(self _meth_92435C7A6AE85C3C(), self.origin);
}

_id_A3564484875DA8F8(asmname, statename, params) {
  thread scripts\asm\asm::_id_FB56C9527636713F(asmname, statename, 1);
  self orientmode("face angle", self._id_B4C85F2BC7ABB407.angles[1]);
  self asmfireephemeralevent("arrived", "end");
  self._id_836489FAD2CCC639 = 1;
}

_id_26B903A39F018550(asmname, statename, params) {
  thread scripts\asm\asm::asm_playanimstate(asmname, statename, params);
  self _meth_802C56A3DF8C7797(self._id_B4C85F2BC7ABB407._id_78FF943CA85E1279, self._id_B4C85F2BC7ABB407.angles, 0.3);
}

_id_A910D69A0DAA7775(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(params) || isarray(params))
    return 0;

  if(!isDefined(self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F))
    return 0;

  _id_A66BA9B157533F5A = self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F;

  if(isDefined(self._id_B4C85F2BC7ABB407.role) && self._id_B4C85F2BC7ABB407.role == "support") {
    if(_id_A66BA9B157533F5A == "left")
      _id_A66BA9B157533F5A = "right";
    else if(_id_A66BA9B157533F5A == "right")
      _id_A66BA9B157533F5A = "left";
  }

  return self._id_B4C85F2BC7ABB407._id_D6CF89A3E47ADA1F == params;
}

_id_23CD7F6FDF460EB4(params) {
  return istrue(self._id_836489FAD2CCC639) || self _meth_9D6AB3620932D51D(self.origin);
}

_id_21BCB65DED71229F(params) {
  return istrue(self._id_836489FAD2CCC639);
}

_id_E62B12681729B218(asmname, statename, _id_F2B19B25D457C2A6, params) {
  id = self _meth_92435C7A6AE85C3C();
  origin = _func_BBFC94714C82788B(id);
  angles = _func_785F60047ABCFA05(id);
  _id_DAD5E6255A5BF2AC = anglesToForward(angles);
  _id_5C6AFC1001475042 = origin - self.origin;
  _id_775361D05A790917 = vectorcross(_id_5C6AFC1001475042, _id_DAD5E6255A5BF2AC);
  _id_2480E63EC7F4DE84 = 1;

  if(_id_775361D05A790917[2] < 0)
    _id_2480E63EC7F4DE84 = 0;

  if(_id_2480E63EC7F4DE84)
    _id_9B185A7815A646B2 = "left";
  else
    _id_9B185A7815A646B2 = "right";

  _id_BB3BFBC5F90B8E98 = _func_060D6151AF81A343(id, "door_knob");
  _id_67DDFCEF5F2744B4 = _id_9B185A7815A646B2 == _id_BB3BFBC5F90B8E98;
  _id_BCACB6B68B075492 = _func_060D6151AF81A343(id, "openness");
  dooropen = 1;

  if(isDefined(_id_BCACB6B68B075492)) {
    _id_BCACB6B68B075492 = abs(_id_BCACB6B68B075492);
    dooropen = _id_BCACB6B68B075492 >= 45;
  }

  if(_id_67DDFCEF5F2744B4 && dooropen)
    return 0;

  return 1;
}

_id_17557D7A61C7B24A(asmname, statename, _id_F2B19B25D457C2A6, params) {
  id = self _meth_92435C7A6AE85C3C();
  _id_4AF98EB05ADDD7BF = _func_060D6151AF81A343(id, "path_has_door");
  return !istrue(_id_4AF98EB05ADDD7BF);
}

_id_27937CCB1B1ABEF1(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.enemy))
    return 0;

  id = self _meth_92435C7A6AE85C3C();
  origin = _func_BBFC94714C82788B(id);
  angles = _func_785F60047ABCFA05(id);
  _id_DAD5E6255A5BF2AC = anglesToForward(angles);
  _id_D59ED0E8C57E2DEF = self.enemy.origin;
  _id_9001DA663C7CDFEC = _func_767CEA82B001F645(_id_D59ED0E8C57E2DEF - origin);
  _id_3777ECE6A73EADA5 = vectordot(_id_DAD5E6255A5BF2AC, _id_9001DA663C7CDFEC);
  return _id_3777ECE6A73EADA5 <= 0;
}

_id_AF686E8A0657CE57(_id_F8D4ED108521E632) {
  self._id_B4C85F2BC7ABB407._id_2B1676BAB1BA8985 = "dual";
}

_id_8055622A418EBD4F(_id_F8D4ED108521E632) {}

_id_767FB54813708A82(_id_F8D4ED108521E632) {}

_id_64FCA4864613393F(_id_78FF943CA85E1279, _id_D78735C0A8459B07) {
  self endon("death");
  forward = anglesToForward(_id_D78735C0A8459B07);
  end = _id_78FF943CA85E1279 + forward * 32;
  id = self _meth_92435C7A6AE85C3C();
  _id_121A3ED8C85DB0D4 = _func_060D6151AF81A343(id, "breachtype");
  _id_36AA5BFAFC2E6678 = _func_BBFC94714C82788B(id);
  _id_B271F9FA9AA79B2F = anglesToForward(_func_785F60047ABCFA05(id));
  _id_DD4554FAB9CACFDF = _id_36AA5BFAFC2E6678 + _id_B271F9FA9AA79B2F * 32;
  scripts\engine\utility::draw_arrow_time(_id_36AA5BFAFC2E6678, _id_DD4554FAB9CACFDF, (150, 50, 150), 5);
  scripts\engine\utility::draw_arrow_time(_id_78FF943CA85E1279, end, (150, 50, 150), 5);
}