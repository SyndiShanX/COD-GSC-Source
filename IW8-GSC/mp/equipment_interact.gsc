/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment_interact.gsc
***********************************************/

equipmentinteract_init() {
  level.useobjs = [];
  scripts\engine\scriptable::_id_12F5B("_encstr_88DD0C8047A3D007E37217AE8DDA", ::numrequireddestinations);
  thread _updateuseobjs();
}

numrequireddestinations(var_0, var_1, var_2, var_3, var_4) {
  numsiegeflags(var_0.entity, var_3);
}

numsiegeflags(var_0, var_1) {
  var_2 = var_0;
  var_2.isbeingused = 1;

  if(isDefined(var_1)) {
    var_1.iscapturingcrate = 0;
    var_1.ishacking = 1;
    var_1 thread _deployhacktablet(var_2, 0);
  }
}

_updateuseobjs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.2;

    foreach(var_1 in level.useobjs) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = scripts\common\utility::playersnear(var_1.origin, 300);

      foreach(var_4 in var_2) {
        if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_4, var_1.owner)) || istrue(var_1.isbeingused) || !var_4 scripts\mp\utility\perk::_hasperk("_encstr_B86B0F0F88EB3F6A91A01141914B12E24B") || var_4 scripts\cp_mp\emp_debuff::is_empd() || level.gameended) {
          var_1 disablescriptableplayeruse(var_4);
          continue;
        }

        var_1 enablescriptableplayeruse(var_4);
      }
    }
  }
}

remoteinteractsetup(var_0, var_1, var_2) {
  if(isDefined(var_2) || var_2)
    thread _hacksetup(var_0);
}

_hacksetup(var_0) {
  level.useobjs[self getentitynumber()] = self;
  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_AB0703DBB9");

  foreach(var_2 in level.players)
  self disablescriptableplayeruse(var_2);
}

_processusethink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_92800CAD71CBBF6251B88BE3B059");
  var_1 = (getdvarfloat("_encstr_A1731913B92EB7C960EB5353FF600AB7DB735ACA6085AFFBB0CB4D", 3.0) - getdvarfloat("_encstr_921721A09BD3301193B132CAE105D323382B508A120939669B014F11FB0290C11A0AA9", 0.5)) * 1000;
  var_2 = gettime() + var_1;

  while(var_2 > gettime()) {
    if(!self useButtonPressed())
      return 0;

    waitframe();
  }

  return 1;
}

_startusethink(var_0, var_1) {
  var_0.isbeingused = 1;
  self.iscapturingcrate = 1;
  self.ishacking = 1;
  var_1.interactstate = 0;
  self notify("_encstr_ACF01193F09C1382B257ABA69E8B7863486DCD");
  var_2 = istrue(_processusethink(var_0));

  if(var_2)
    var_1.interactstate = 2;
  else
    self notify("_encstr_868413A5731DB2932C8D8EFAB15837362B1B1BCA19");

  self notify("_encstr_A3E5125120589ABE29415329F69B48582E08DDE9");

  if(isDefined(var_0))
    var_0.isbeingused = 0;

  if(isDefined(self)) {
    self.iscapturingcrate = 0;
    self.ishacking = undefined;

    if(!istrue(var_2)) {
      return;
    }
    if(isDefined(var_0))
      var_0 scripts\mp\equipment::hackequipment(self);
  }
}

_deployhacktablet(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = getcompleteweaponname("_encstr_B4CB12574F71BEA0FD4D130979D0C87E6A9723E9");
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B40101", self);
  var_3.interactstate = var_1;
  thread _updatehackomnvars(var_0, var_1);
  var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_2, var_3, ::_waituntilinteractfinished, ::allowednormaldemeanor, undefined, undefined, ::_ontabletputaway);

  if(istrue(var_4) && isDefined(var_0))
    thread _startusethink(var_0, var_3);
  else {
    self notify("_encstr_868413A5731DB2932C8D8EFAB15837362B1B1BCA19");

    if(isDefined(var_0))
      var_0.isbeingused = 0;
  }
}

_updatehackomnvars(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = -1;

  if(isDefined(var_0.equipmentref))
    var_2 = scripts\mp\equipment::getequipmenttableinfo(var_0.equipmentref).id;
  else if(isDefined(var_0.streakinfo)) {
    var_2 = scripts\mp\utility\killstreak::getkillstreakindex(var_0.streakinfo.streakname);
    var_2 = var_2 + 100;
  }

  self setclientomnvar("_encstr_B80E0EC3DFC19858DE434F996B03BDF3", var_2);
  self playlocalsound("_encstr_868212126B9BF7D7E851FFDC73A8DD47E506AB9A");
  _updatehackprogressomnvar(var_0);

  if(var_1 == 2) {
    self setclientomnvar("_encstr_AD6C11BA5AF54316C6D67D3893DED93956CD37", 1);
    var_3 = getdvarfloat("_encstr_921721A09BD3301193B132CAE105D323382B508A120939669B014F11FB0290C11A0AA9", 0.5);
    wait(var_3);
  } else {
    self stoplocalsound("_encstr_868212126B9BF7D7E851FFDC73A8DD47E506AB9A");
    self setclientomnvar("_encstr_AD6C11BA5AF54316C6D67D3893DED93956CD37", 0);
  }

  wait 0.1;
  self setclientomnvar("_encstr_B80E0EC3DFC19858DE434F996B03BDF3", 0);
}

_updatehackprogressomnvar(var_0) {
  self endon("_encstr_868413A5731DB2932C8D8EFAB15837362B1B1BCA19");
  self waittill("_encstr_ACF01193F09C1382B257ABA69E8B7863486DCD");
  var_1 = 1000.0;
  var_2 = 500.0;
  var_3 = getdvarfloat("_encstr_A1731913B92EB7C960EB5353FF600AB7DB735ACA6085AFFBB0CB4D", 3.0) * 1000;
  var_4 = getdvarfloat("_encstr_921721A09BD3301193B132CAE105D323382B508A120939669B014F11FB0290C11A0AA9", 0.5) * 1000;
  var_5 = var_3 - var_1 - var_4;
  var_6 = gettime() + var_3 + var_2;
  var_7 = gettime() + var_1;

  for(;;) {
    var_8 = (gettime() - var_7) / var_5;
    var_8 = clamp(var_8, 0, 1);
    self setclientomnvar("_encstr_AD6C11BA5AF54316C6D67D3893DED93956CD37", var_8);
    wait 0.05;

    if(gettime() > var_6) {
      break;
    }
  }
}

allowednormaldemeanor(var_0, var_1) {
  _toggletabletallows(1);
  thread addtolittlebirdmglist();
  thread addspecialistbonus(var_0);
  return 1;
}

addspecialistbonus(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_85931B9F35694AFFBA617F3FB8B3A7325F56235425F7C207C1F00B27E8");

  for(;;) {
    if(!self useButtonPressed()) {
      break;
    }

    waitframe();
  }

  self notify("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");
}

_ontabletputaway(var_0) {
  self notify("_encstr_8EA90ED159AE509DFB21B39B18DF4720");
}

_waituntilinteractfinished(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_868413A5731DB2932C8D8EFAB15837362B1B1BCA19");

  if(var_0.interactstate != 0) {
    return;
  }
  self waittill("_encstr_A3E5125120589ABE29415329F69B48582E08DDE9");

  if(var_0.interactstate == 2) {
    var_1 = getdvarfloat("_encstr_921721A09BD3301193B132CAE105D323382B508A120939669B014F11FB0290C11A0AA9", 0.5);
    wait(var_1);
  }
}

addtolittlebirdmglist() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8EA90ED159AE509DFB21B39B18DF4720");
  _toggletabletallows(0);
}

_toggletabletallows(var_0) {
  scripts\mp\utility\player::_freezelookcontrols(var_0);

  if(isalive(self)) {
    scripts\common\utility::allow_movement(!var_0);
    scripts\common\utility::allow_jump(!var_0);
    scripts\common\utility::allow_usability(!var_0);
    scripts\common\utility::allow_melee(!var_0);
    scripts\common\utility::allow_offhand_weapons(!var_0);
  }
}