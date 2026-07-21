/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\gasmask.gsc
***********************************************/

init(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  if(var_2)
    var_3 = removestructfromlevelarray(var_1);
  else
    var_3 = 180;

  if(!isDefined(level.plundermusicfourth)) {
    if(var_2)
      level.plundermusicfourth = getdvarfloat("_encstr_A9EB16D2368B162AC279D7F3DBFD0BA660262209CF13D78C", 0);
    else
      level.plundermusicfourth = 0.2;
  }

  self.gasmaskhealth = var_3;
  self.plunderpads = var_3;
  self.plundersilentcountdownendtime = var_1;
  var_4 = 2;

  if(unlocked_escape_door(var_1))
    var_4 = 3;

  if(isDefined(var_0))
    self.gasmaskhealth = var_0;

  if(var_2)
    level.plunderonfirstpickup = self.gasmaskhealth / 6;

  level.plunderpads = var_3;
  self setclientomnvar("_encstr_A55C145862212951876CA0A551FF18A1996A0870BB42", var_4);
  self setclientomnvar("_encstr_A2E4127B2D80AF6EA09B29238F9977FF31B9D2E2", self.gasmaskhealth / var_3);
}

unlocked_escape_door(var_0) {
  return isDefined(var_0) && var_0 == "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253";
}

removestructfromlevelarray(var_0) {
  if(unlocked_escape_door(var_0))
    return level.br_pickups.counts["_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253"];
  else
    return level.br_pickups.counts["_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28"];
}

respawnplayers(var_0) {
  return floor(var_0 * 6 + 0.5);
}

processdamage(var_0) {
  var_1 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";
  var_2 = self.gasmaskhealth / self.plunderpads;
  self.gasmaskhealth = self.gasmaskhealth - var_0;
  self.gasmaskhealth = max(0, self.gasmaskhealth);
  var_3 = self.gasmaskhealth / self.plunderpads;
  self setclientomnvar("_encstr_A2E4127B2D80AF6EA09B29238F9977FF31B9D2E2", var_3);

  if(self.gasmaskhealth <= 0) {
    if(var_1 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88EA08EC2CCDDAB037B5", "_encstr_84160FF275B8CE373C899B60917E7F4E79"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88EA08EC2CCDDAB037B5", "_encstr_84160FF275B8CE373C899B60917E7F4E79")]]();
    else
      breakgasmask();
  } else if(var_1) {
    var_4 = respawnplayers(var_2);
    var_5 = respawnplayers(var_3);

    if(var_4 > var_5)
      self playsoundtoplayer("_encstr_BED616F65A310F91CBCFC0A857FB6EBF4B06FE8AF91BD1BB", self);
  }

  if(!isDefined(self.gasdamagebuffer))
    self.gasdamagebuffer = 0;

  self.gasdamagebuffer = self.gasdamagebuffer + var_0 * level.plundermusicfourth;
  var_6 = floor(self.gasdamagebuffer);

  if(var_6 >= 1) {
    self dodamage(var_6, self.origin, self, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
    self.gasdamagebuffer = self.gasdamagebuffer - var_6;
  }
}

lights_setup_plane(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  if(!var_2)
    return 0;

  if(!isDefined(self.plunderpads))
    self.plunderpads = removestructfromlevelarray(self.plundersilentcountdownendtime);

  var_3 = var_0 / self.plunderpads;
  var_4 = var_1 / self.plunderpads;
  var_5 = respawnplayers(var_3);
  var_6 = respawnplayers(var_4);
  return var_5 != var_6;
}

equipgasmask() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self playsoundtoplayer("_encstr_951A1378EA9958313787B04B678A715F60A9EB30A0", self);
  var_0 = getcompleteweaponname("_encstr_8BBA05185F8B99");
  var_1 = self getcurrentweapon();

  if(!isnullweapon(var_1, var_0))
    self forceplaygestureviewmodel("_encstr_82EB0F87EDAE67F32847483A3FF55F3C16");

  self.gasmaskswapinprogress = 1;
  wait 0.338;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  var_2 = "_encstr_910B0C2191F3115467EB78E1F317";

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_2 = "_encstr_A72210903B58299FB763C20A4B9A479E1007";

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage))
    self attach(var_2);

  createoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_956C0F5F17A32190D37C4679E7A5D8E9BA");
  else
    self _meth_87AA("_encstr_A54F0D51AA7701B872C31F43F19D50");
}

removegasmask() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self playsoundtoplayer("_encstr_9675140B106EEF9A7738C5FE166F31BF11D887CB7863", self);
  var_0 = getcompleteweaponname("_encstr_8BBA05185F8B99");
  var_1 = self getcurrentweapon();

  if(!isnullweapon(var_1, var_0))
    self forceplaygestureviewmodel("_encstr_91560DECCA9BBEB34BB97B277DABE0");

  self.gasmaskswapinprogress = 1;
  wait 0.521;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 0;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
  var_2 = "_encstr_910B0C2191F3115467EB78E1F317";

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_2 = "_encstr_A72210903B58299FB763C20A4B9A479E1007";

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage))
    self detach(var_2);

  destroyoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");
}

breakgasmask() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self.gasmaskequipped = 0;
  self playsoundtoplayer("_encstr_BED616F65A310F91CBCFC0A857FB6EBF4B06FE8AF91BD1BB", self);
  var_0 = "_encstr_910B0C2191F3115467EB78E1F317";

  if(scripts\cp_mp\utility\game_utility::_id_140AA())
    var_0 = "_encstr_A72210903B58299FB763C20A4B9A479E1007";

  if(istrue(self.operatorcustomization.spawn_carriables_from_prefabs_percentage))
    self detach(var_0);

  destroyoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  self playsoundtoplayer("_encstr_ADD619E2CD197F8727B1F897C67837F56F80D11314E21B21835985", self);
  self setclientomnvar("_encstr_A55C145862212951876CA0A551FF18A1996A0870BB42", 0);
  self setclientomnvar("_encstr_A2E4127B2D80AF6EA09B29238F9977FF31B9D2E2", 0);
}

createoverlay(var_0, var_1) {
  self.gasmaskoverlay = newclienthudelem(self);
  self.gasmaskoverlay.x = 0;
  self.gasmaskoverlay.y = 0;
  self.gasmaskoverlay.alignx = "_encstr_A5AD056A019C63";
  self.gasmaskoverlay.aligny = "_encstr_AC190479FF92";
  self.gasmaskoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.gasmaskoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.gasmaskoverlay setshader("_encstr_83D31764B91770233A5A09806357FDA8B739E06D15331B6B32", 640, 480);
  self.gasmaskoverlay.sort = -10;
  self.gasmaskoverlay.archived = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB") {
      self.gasmaskoverlay.alpha = 0.0;

      if(isDefined(var_0)) {
        if(isDefined(var_1))
          wait(var_1);

        if(isDefined(self.gasmaskoverlay))
          self.gasmaskoverlay fadeovertime(var_0);
      }
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay.alpha = 1.0;
    self.gasmaskoverlay.lowresbackground = 1;
  }
}

_id_1312F() {
  if(isDefined(self.gasmaskoverlay))
    self.gasmaskoverlay setshader("_encstr_994D1E5A20CF7DA773A24F67C45923C5130841E2B85973DF03807A7250A0270D", 640, 480);
}

patch_weapons_on_rack_cleararea(var_0) {
  self.gasmaskoverlay.alpha = 1.0;
  self.gasmaskoverlay fadeovertime(var_0);
  self.gasmaskoverlay.alpha = 0.0;
}

destroyoverlay(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(self.gasmaskoverlay)) {
    return;
  }
  if(isDefined(var_0)) {
    if(isDefined(var_1))
      wait(var_1);

    if(isDefined(self.gasmaskoverlay)) {
      patch_weapons_on_rack_cleararea(var_0);
      wait(var_0);
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay destroy();
    self.gasmaskoverlay = undefined;
  }
}

hasgasmask(var_0) {
  return isDefined(var_0.gasmaskhealth);
}