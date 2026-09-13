/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armory_trader.gsc
*****************************************************/

init() {
  level._id_90D5AC9F18D44A51 = spawnStruct();
  level._id_90D5AC9F18D44A51.scriptables = [];
  level._id_6254899BB2142D87 = getdvarint("scr_br_armory_trader", 0) != 0;

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("trader"))
    level._id_6254899BB2142D87 = 0;
  else {
    _id_7A96B62536EC3133 = getallspawninstances();

    if(!isDefined(_id_7A96B62536EC3133) || _id_7A96B62536EC3133.size == 0)
      level._id_6254899BB2142D87 = 0;
  }

  if(!level._id_6254899BB2142D87) {
    return;
  }
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_armory_trader", ::_id_C0972A3A09A99AB6);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("TraderUse", ["offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers"]);
  level._id_90D5AC9F18D44A51._id_3848126FC180B0F8 = strtok(getDvar("loot_table_filter", ""), "|");
  level._id_90D5AC9F18D44A51._id_D8DD94861DA28AFE = strtok(getDvar("dvar_A077A83EAD32F0C2", "brloot_offhand_advancedsupplydrop|brloot_plunder_extract|brloot_perk_point_overkill"), "|");
  _id_D09A84CDBF4FCDAB();
  _id_07C49BDB271D5CB0();
  thread _id_03C3A74C32ED3A62();
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(5, ::dangercircletick, ::_id_1A1709943670772A, ::_id_83C65466CC2272DD, ::_id_F58F16A632B7409D);
}

_id_D09A84CDBF4FCDAB() {
  _id_6686D1519FD59C8D = getDvar("dvar_A077A83EAD32F0C2", "undefined_default");
  logstring("br_armory_trader scr_br_armory_trader_filter value is: " + _id_6686D1519FD59C8D);
  _id_297D6CBB50675600 = "";

  foreach(item in level._id_90D5AC9F18D44A51._id_D8DD94861DA28AFE)
  _id_297D6CBB50675600 = _id_297D6CBB50675600 + (item + " ");

  logstring("br_armory_trader level.br_armory_trader.filteredItems value is: " + _id_297D6CBB50675600);
}

_id_07C49BDB271D5CB0() {
  _id_DF433E8B91D06E83 = getDvar("dvar_F2E5F0AF7E8689F3", "armory_trader_default");
  level._id_90D5AC9F18D44A51._id_25EA48876F86D21E = getscriptbundle(_func_2EF675C13CA1C4AF("enum_7A7811456F8710F2", _id_DF433E8B91D06E83));
}

_id_3953D88977707504() {
  return randomint(getdvarint("dvar_4D0B67ABA31EFB57", 32767));
}

_id_707D6CFAA04DBE98(position) {
  _id_C9CA3978216A1105 = undefined;
  _id_27C05912B904412B = undefined;

  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables) {
    distancesquared = distance2dsquared(_id_C6C707CCB258975F.origin, position);

    if(!isDefined(_id_C9CA3978216A1105) || distancesquared < _id_C9CA3978216A1105) {
      _id_C9CA3978216A1105 = distancesquared;
      _id_27C05912B904412B = _id_C6C707CCB258975F;
    }
  }

  return _id_27C05912B904412B;
}

onprematchdone() {
  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables)
  _id_83C65466CC2272DD(_id_C6C707CCB258975F);
}

_id_03C3A74C32ED3A62() {
  level waittill("game_ended");

  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables) {
    if(isDefined(_id_C6C707CCB258975F.visible))
      _id_807BB1D3855DEA79(_id_C6C707CCB258975F);
  }
}

_id_7F17056284FE39DB() {
  trigger = spawn("trigger_radius", self.origin, 0, 500, 500);
  trigger.playersintrigger = [];
  trigger thread _id_16C0442279696476(self);
  trigger thread _id_9164DCA6F310A9C0(self);
  self._id_AAC94CE6A0278A36 = trigger;
}

_id_48607351AA7C7174() {
  if(isDefined(self._id_AAC94CE6A0278A36))
    self._id_AAC94CE6A0278A36 _id_735C00DB82BFCB5F();
}

_id_16C0442279696476(_id_403543CEA77C7AB9) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    _id_2F5764B74AD4A6C6 = player getentitynumber();

    if(isDefined(self.playersintrigger[_id_2F5764B74AD4A6C6])) {
      continue;
    }
    self.playersintrigger[_id_2F5764B74AD4A6C6] = player;
    player thread _id_95C74B278F040FDA(self, _id_403543CEA77C7AB9);
  }
}

_id_9164DCA6F310A9C0(_id_403543CEA77C7AB9) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    foreach(_id_2F5764B74AD4A6C6, player in self.playersintrigger) {
      if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && player istouching(self)) {
        continue;
      }
      self.playersintrigger[_id_2F5764B74AD4A6C6] = undefined;
      _id_559F8134E44F1BB0(player, _id_403543CEA77C7AB9);
    }

    waitframe();
  }
}

_id_735C00DB82BFCB5F() {
  self delete();
}

_id_95C74B278F040FDA(trigger, _id_403543CEA77C7AB9) {}

_id_559F8134E44F1BB0(player, _id_403543CEA77C7AB9) {}

_id_C9064ACA910696FA() {
  self endon("disabled");
  self._id_06E365789695D215 = [];

  for(;;) {
    level scripts\engine\utility::waittill_any_2("public_event_firesale_start", "public_event_firesale_end");
    self._id_06E365789695D215 = [];
  }
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(!istrue(level._id_6254899BB2142D87) || getdvarint("dvar_C43C6D7961E72D40", 0) == 1) {
    return;
  }
  maxdistance = _id_E86632D645C137D0 + level._id_53C0FA66001CFF52;
  _id_9799F8752D4AE4BF = maxdistance * maxdistance;

  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables) {
    if(isDefined(_id_C6C707CCB258975F.visible) && distance2dsquared(_id_C6C707CCB258975F.origin, _id_819EDACDACB810E4) > _id_9799F8752D4AE4BF)
      _id_807BB1D3855DEA79(_id_C6C707CCB258975F);
  }
}

_id_1A1709943670772A() {
  if(!istrue(level._id_6254899BB2142D87) || getdvarint("dvar_C43C6D7961E72D40", 0) == 1) {
    return;
  }
  _id_B38FAD8ED86D1666 = [];

  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables) {
    if(isDefined(_id_C6C707CCB258975F.visible) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_C6C707CCB258975F.origin, level._id_53C0FA66001CFF52)) {
      _id_B38FAD8ED86D1666[_id_B38FAD8ED86D1666.size] = _id_C6C707CCB258975F;
      _id_807BB1D3855DEA79(_id_C6C707CCB258975F);
    }
  }

  return _id_B38FAD8ED86D1666;
}

_id_F58F16A632B7409D() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("trader")) {
    return;
  }
  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables) {
    if(isDefined(_id_C6C707CCB258975F.visible))
      _id_807BB1D3855DEA79(_id_C6C707CCB258975F);
  }
}

_id_D41E030D04BF2B79(_id_C6C707CCB258975F) {
  _id_C6C707CCB258975F._id_E74F678BE2FD0A6F = 1;
  _id_C6C707CCB258975F._id_A7D0A168E6C19C1F = _id_3953D88977707504();
  _id_C6C707CCB258975F._id_03A05365F8278DFF = int(pow(2, 4)) - 1;
  _id_C6C707CCB258975F _id_144CA1193F36516E();
}

_id_83C65466CC2272DD(_id_C6C707CCB258975F) {
  _id_C6C707CCB258975F setscriptablepartstate("br_armory_trader", "visible");
  _id_C6C707CCB258975F.visible = 1;
  _id_C6C707CCB258975F.disabled = undefined;
  _id_C6C707CCB258975F _id_7F17056284FE39DB();
  _id_C6C707CCB258975F thread _id_C9064ACA910696FA();
}

_id_807BB1D3855DEA79(_id_C6C707CCB258975F) {
  _id_C6C707CCB258975F setscriptablepartstate("br_armory_trader", "disabled");
  _id_C6C707CCB258975F.visible = undefined;
  _id_C6C707CCB258975F.disabled = 1;
  _id_C6C707CCB258975F _id_48607351AA7C7174();
  _id_C6C707CCB258975F notify("disabled");
}

getallspawninstances() {
  if(!level._id_6254899BB2142D87) {
    return;
  }
  if(istrue(_id_362C58E8BB39BCDA::isfeaturedisabled("placedTraders"))) {
    return;
  }
  _id_1EB07A39FF244CD5 = getentitylessscriptablearray("scriptable_br_armory_trader", "classname");
  return _id_1EB07A39FF244CD5;
}

setspawninstances(instances) {
  level._id_90D5AC9F18D44A51.scriptables = instances;

  foreach(_id_C6C707CCB258975F in level._id_90D5AC9F18D44A51.scriptables)
  _id_D41E030D04BF2B79(_id_C6C707CCB258975F);
}

_id_4A8CC2BE66F163E3(player) {
  if(!_id_337BD370F7C5E6F9::ispubliceventoftypeactive(2))
    return 0;

  return !scripts\engine\utility::array_contains(self._id_06E365789695D215, player);
}

_id_D09F8444B6D5545D(item) {
  if(isDefined(item) && isDefined(level.br_lootiteminfo[item]) && isDefined(level.br_lootiteminfo[item].fullweaponname))
    return level.br_lootiteminfo[item].fullweaponname;

  return undefined;
}

_id_7A52C9A581D2F2EB(instance, player, _id_BD2CEE13DB54664A) {
  if(!isDefined(_id_BD2CEE13DB54664A))
    return 0;

  if(istrue(level.gameended))
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand))
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(player _id_362C58E8BB39BCDA::runbrgametypefunc("playerSkipKioskUse", instance)))
    return 0;

  if(istrue(player.iscarrying) && !isDefined(player._id_F9351AE943EDDD0C)) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return 0;
  }

  if(!player _id_F70CFFAC5C2B680D(_id_BD2CEE13DB54664A))
    return 0;

  return 1;
}

_id_F70CFFAC5C2B680D(_id_BD2CEE13DB54664A) {
  if(!isDefined(_id_BD2CEE13DB54664A) || !isDefined(_id_BD2CEE13DB54664A.inventorytype) || _id_BD2CEE13DB54664A != self getcurrentweapon() && _id_BD2CEE13DB54664A != self getcurrentprimaryweapon())
    return 0;

  if(_id_BD2CEE13DB54664A.inventorytype != "primary" && _id_BD2CEE13DB54664A.inventorytype != "altmode")
    return 0;

  weaponname = getcompleteweaponname(_id_BD2CEE13DB54664A getnoaltweapon());
  _id_F87039BA7EC40273 = isDefined(level.br_pickups.br_weapontoscriptable[weaponname]);
  isvalidcustomweapon = _id_724736FCF0FB6604::isvalidcustomweapon(_id_BD2CEE13DB54664A);

  if(!_id_F87039BA7EC40273 && !isvalidcustomweapon)
    return 0;

  return 1;
}

_id_C0972A3A09A99AB6(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_754F5690A852CFEB = isDefined(player._id_FA227CD07E38F2DC);

  if(!_id_754F5690A852CFEB)
    thread _id_AFAFCB5597AC7F8B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_AFAFCB5597AC7F8B(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_BD2CEE13DB54664A = player _id_724736FCF0FB6604::_id_27EF2C36EB95D796();

  if(!_id_7A52C9A581D2F2EB(instance, player, _id_BD2CEE13DB54664A)) {
    return;
  }
  _id_423E7C9070306589 = instance _id_1062E631E88CC4DF(_id_BD2CEE13DB54664A, player);

  if(!isDefined(_id_423E7C9070306589)) {
    return;
  }
  _id_0DF1921B36D4787C = _id_E6890F166A5E1EC6(_id_423E7C9070306589, level._id_90D5AC9F18D44A51._id_25EA48876F86D21E._id_8C078B2449437A35);

  if(!isDefined(_id_0DF1921B36D4787C)) {
    return;
  }
  _id_69351C74782C3984 = level._id_90D5AC9F18D44A51._id_25EA48876F86D21E._id_8C078B2449437A35[_id_0DF1921B36D4787C];
  player._id_FA227CD07E38F2DC = spawnStruct();
  player._id_FA227CD07E38F2DC.curprogress = 0.0;
  player._id_FA227CD07E38F2DC.usetime = scripts\engine\utility::_id_53C4C53197386572(_id_69351C74782C3984.usetime, 0);
  player._id_FA227CD07E38F2DC._id_45E9E3C4DD8256D7 = scripts\engine\utility::_id_53C4C53197386572(_id_69351C74782C3984._id_45E9E3C4DD8256D7, "");
  player._id_FA227CD07E38F2DC._id_2E2845FB5118E744 = scripts\engine\utility::_id_53C4C53197386572(_id_69351C74782C3984._id_2E2845FB5118E744, "");
  player._id_FA227CD07E38F2DC._id_BD2CEE13DB54664A = _id_BD2CEE13DB54664A;
  instance notify("trader_use_start");
  instance thread _id_4C930F9F8B0A20A6();

  if(state == "visible")
    instance setscriptablepartstate("br_armory_trader", "opening");

  if(istrue(player.insertingarmorplate))
    player notify("br_try_armor_cancel");

  _id_5AA96CA0F982567B(player, instance, _id_BD2CEE13DB54664A);
  result = _id_4508AB88CD83CE00(player, instance);

  if(isDefined(player))
    _id_5177159216B39DC5(player, instance, result);

  if(istrue(result))
    player thread _id_83ADDB0FAF58B833(instance, _id_BD2CEE13DB54664A, _id_423E7C9070306589, _id_69351C74782C3984);

  player._id_FA227CD07E38F2DC = undefined;
}

_id_4C930F9F8B0A20A6() {
  self endon("trader_use_start");
  self endon("disabled");
  _id_A8ED193E84F970CC = 0;

  while(_id_A8ED193E84F970CC < 30) {
    wait 1.5;
    _id_A8ED193E84F970CC = _id_A8ED193E84F970CC + 1.5;
    _id_F47DD9D668CC52E2 = scripts\mp\utility\player::getplayersinradius(self.origin, 175);

    if(_id_F47DD9D668CC52E2.size > 0)
      _id_A8ED193E84F970CC = 0;
  }

  self setscriptablepartstate("br_armory_trader", "closing");
  self._id_A7D0A168E6C19C1F = _id_3953D88977707504();
  thread _id_2CB33B237D4FDE89();
}

_id_2CB33B237D4FDE89() {
  self endon("trader_use_start");
  self endon("disabled");

  for(_id_9AB9272AAF73E6AE = 1; _id_9AB9272AAF73E6AE; _id_9AB9272AAF73E6AE = _id_F47DD9D668CC52E2.size > 0) {
    wait 2;
    _id_F47DD9D668CC52E2 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
  }

  _id_247EA20A2CF9823B();
}

_id_247EA20A2CF9823B() {
  wait 2;
  _id_70364F7387A6A722 = getdvarfloat("player_itemuseradius", 128) + 16;
  _id_A679C918818FA808 = getlootscriptablearrayinradius(undefined, undefined, self.origin, _id_70364F7387A6A722);

  if(getdvarint("dvar_A57429B2602E1687", 1))
    _id_A679C918818FA808 = scripts\engine\utility::array_combine_unique(_id_A679C918818FA808, _id_F0588926F68D998B());

  if(isDefined(_id_A679C918818FA808)) {
    foreach(loot in _id_A679C918818FA808) {
      if(!_id_7E52B56769FA7774::_id_2AE5E94BD6518AB5(loot, 0)) {
        continue;
      }
      if(loot getscriptableisreserved() && !isDefined(loot.brpickupscriptableid)) {
        continue;
      }
      _id_7E52B56769FA7774::loothide(loot);
    }
  }
}

_id_4508AB88CD83CE00(player, instance) {
  player endon("disconnect");
  level endon("game_ended");
  instance.id = "weapon_trade";
  instance.userate = scripts\engine\utility::ter_op(isDefined(player.objectivescaler), player.objectivescaler, 1);

  while(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && _id_97B25951938C27E6(player, instance) && player useButtonPressed()) {
    player._id_FA227CD07E38F2DC.curprogress = player._id_FA227CD07E38F2DC.curprogress + level.framedurationseconds * instance.userate;

    if(player._id_FA227CD07E38F2DC.curprogress >= player._id_FA227CD07E38F2DC.usetime) {
      player._id_FA227CD07E38F2DC.curprogress = 0.0;
      return 1;
    }

    player scripts\mp\gameobjects::updateuiprogress(instance, 1, player._id_FA227CD07E38F2DC);
    waitframe();
  }

  if(isDefined(player) && isDefined(player._id_FA227CD07E38F2DC) && isDefined(player._id_FA227CD07E38F2DC.curprogress))
    player._id_FA227CD07E38F2DC.curprogress = 0.0;

  return 0;
}

_id_97B25951938C27E6(player, instance) {
  if(!isDefined(instance) || !istrue(instance.visible))
    return 0;

  _id_0A58DA72618976A9 = player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("crate_use");

  if(!_id_0A58DA72618976A9)
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(player meleeButtonPressed())
    return 0;

  if(player isinexecutionvictim())
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  if(!isDefined(player._id_FA227CD07E38F2DC) || !player hasweapon(player._id_FA227CD07E38F2DC._id_BD2CEE13DB54664A))
    return 0;

  _id_AC24E698C84063C5 = getdvarfloat("player_itemuseradius", 128) + 16;
  _id_7E8ACBB6E945F44A = _id_AC24E698C84063C5 * _id_AC24E698C84063C5;

  if(distancesquared(player.origin, instance.origin) > _id_7E8ACBB6E945F44A)
    return 0;

  return 1;
}

_id_5AA96CA0F982567B(player, instance, _id_BD2CEE13DB54664A) {
  player thread _id_16CE7D3E6D041977(_id_BD2CEE13DB54664A);
  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("TraderUse", 0);
  instance.id = "weapon_trade";
  player scripts\mp\gameobjects::updateuiprogress(instance, 0, player._id_FA227CD07E38F2DC);
  playusesound(player, player._id_FA227CD07E38F2DC._id_45E9E3C4DD8256D7);
  player._id_71B9E25D863AB555 = 1;
}

_id_5177159216B39DC5(player, instance, result) {
  player _id_3B64EB40368C1450::_id_588F2307A3040610("TraderUse");

  if(isDefined(instance)) {
    player scripts\mp\gameobjects::updateuiprogress(instance, 0, player._id_FA227CD07E38F2DC);
    stopusesound(player, player._id_FA227CD07E38F2DC._id_45E9E3C4DD8256D7, player._id_FA227CD07E38F2DC._id_2E2845FB5118E744);
  }

  player notify("trader_use_end", result);
  player._id_71B9E25D863AB555 = undefined;
}

playusesound(player, _id_45E9E3C4DD8256D7) {
  if(_id_45E9E3C4DD8256D7 != "")
    player playlocalsound(_id_45E9E3C4DD8256D7);
}

stopusesound(player, _id_45E9E3C4DD8256D7, _id_2E2845FB5118E744) {
  if(_id_45E9E3C4DD8256D7 != "")
    player stoplocalsound(_id_45E9E3C4DD8256D7);

  if(_id_2E2845FB5118E744 != "" && player scripts\cp_mp\utility\player_utility::_isalive())
    player playsoundonmovingent(_id_2E2845FB5118E744);
}

_id_16CE7D3E6D041977(_id_BD2CEE13DB54664A) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  _id_FF937324B8D5708D = makeweapon("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_FF937324B8D5708D);
  thread _id_DBDF115B85A17CD1(_id_FF937324B8D5708D, _id_BD2CEE13DB54664A);
  self switchtoweapon(_id_FF937324B8D5708D);
}

_id_DBDF115B85A17CD1(_id_FF937324B8D5708D, _id_BD2CEE13DB54664A) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("trader_use_end", result);

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(_id_FF937324B8D5708D))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(_id_FF937324B8D5708D);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_FF937324B8D5708D);

    if(!istrue(result) && isDefined(_id_BD2CEE13DB54664A)) {
      lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(_id_BD2CEE13DB54664A);
      self switchtoweapon(lastweaponobj);
      thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(lastweaponobj);
    }
  }
}

_id_83ADDB0FAF58B833(_id_7AAC6B8174790EC5, _id_BD2CEE13DB54664A, _id_423E7C9070306589, _id_69351C74782C3984) {
  if(_id_423E7C9070306589 == "FireSaleSpecialDeal")
    _id_7AAC6B8174790EC5._id_06E365789695D215 = scripts\engine\utility::array_add(_id_7AAC6B8174790EC5._id_06E365789695D215, self);

  self takeweapon(_id_BD2CEE13DB54664A);

  if(!self hasweapon("iw9_me_fists_mp"))
    self giveweapon("iw9_me_fists_mp");

  self switchtoweapon("iw9_me_fists_mp");
  _id_39DF2E8641D0C69F = _id_7AAC6B8174790EC5 _id_384F61E478B75347(self, _id_423E7C9070306589, _id_69351C74782C3984);

  if(!_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch()) {
    xp = scripts\engine\utility::_id_53C4C53197386572(_id_69351C74782C3984.xp, 0);

    if(istrue(_id_69351C74782C3984._id_29D9778F720A13A9))
      thread scripts\mp\utility\points::giveunifiedpoints(_id_69351C74782C3984.scoreeventref);
  }

  if(!isDefined(_id_39DF2E8641D0C69F))
    _id_39DF2E8641D0C69F = [];

  circleindex = 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    circleindex = level.br_circle.circleindex;

  self dlog_recordplayerevent("dlog_event_armory_trader", ["receiving_weapon_category", _id_423E7C9070306589, "circle_index", circleindex, "received_items", _id_39DF2E8641D0C69F]);
}

_id_1062E631E88CC4DF(currentweapon, player) {
  _id_423E7C9070306589 = undefined;
  _id_55EF6C1F428AC567 = currentweapon.ismelee;
  _id_102D677621400199 = weaponclass(currentweapon.basename) == "rocketlauncher";

  if(_id_4A8CC2BE66F163E3(player))
    _id_423E7C9070306589 = "FireSaleSpecialDeal";
  else if(_id_55EF6C1F428AC567)
    _id_423E7C9070306589 = "Melee";
  else if(_id_102D677621400199)
    _id_423E7C9070306589 = "Launcher";
  else {
    weaponname = getcompleteweaponname(currentweapon getnoaltweapon());
    _id_A61B8EF0E4D4E764 = _id_2B8010C382F13EAE(currentweapon);

    switch (_id_A61B8EF0E4D4E764) {
      case 0:
        _id_423E7C9070306589 = "0_Attachments";
        break;
      case 1:
        _id_423E7C9070306589 = "1_Attachment";
        break;
      case 2:
        _id_423E7C9070306589 = "2_Attachments";
        break;
      case 3:
        _id_423E7C9070306589 = "3_Attachments";
        break;
      case 4:
        _id_423E7C9070306589 = "4_Attachments";
        break;
      case 5:
        _id_423E7C9070306589 = "5_Attachments";
        break;
      default:
        _id_423E7C9070306589 = "5_Attachments";
        break;
    }
  }

  return _id_423E7C9070306589;
}

_id_2B8010C382F13EAE(objweapon) {
  _id_18F0A5759A8E40D9 = scripts\cp_mp\challenges::findgunsmithattachments(objweapon);
  _id_A28F4E760500001B = 0;

  foreach(attachment in _id_18F0A5759A8E40D9) {
    if(attachment != 0)
      _id_A28F4E760500001B++;
  }

  return _id_A28F4E760500001B;
}

_id_A54A080EDCE0A822(max, _id_1FF427B6DE9CA76B) {
  _id_25DB57876379661A = self._id_A7D0A168E6C19C1F;

  if(_id_1FF427B6DE9CA76B != 0)
    _id_25DB57876379661A = scripts\engine\utility::ter_op(_id_25DB57876379661A > self._id_03A05365F8278DFF, _id_25DB57876379661A >> _id_1FF427B6DE9CA76B, _id_25DB57876379661A << _id_1FF427B6DE9CA76B);

  return _id_25DB57876379661A % max;
}

_id_13044E8BFFE2BE86(_id_BB80E63548333927, _id_1FF427B6DE9CA76B) {
  _id_5E5EB7A3CFE768DC = 0;

  foreach(_id_F90358454413407F in _id_BB80E63548333927)
  _id_5E5EB7A3CFE768DC = _id_5E5EB7A3CFE768DC + _id_F90358454413407F.weight;

  if(_id_5E5EB7A3CFE768DC == 0)
    return undefined;

  _id_D0C6C63850505514 = _id_A54A080EDCE0A822(_id_5E5EB7A3CFE768DC, _id_1FF427B6DE9CA76B);
  _id_C80ACE2362CC1776 = 0;

  foreach(_id_F90358454413407F in _id_BB80E63548333927) {
    _id_C80ACE2362CC1776 = _id_C80ACE2362CC1776 + _id_F90358454413407F.weight;

    if(_id_C80ACE2362CC1776 >= _id_D0C6C63850505514)
      return _id_F90358454413407F;
  }

  return undefined;
}

_id_6C40CEEB0FB0B8E9(_id_423E7C9070306589, _id_69351C74782C3984) {
  _id_7D239A878DF603E4 = _id_13044E8BFFE2BE86(_id_69351C74782C3984.entries, 0);
  _id_C4CD691657517BB9 = _id_FD6545E977B212EC(_id_7D239A878DF603E4, 0);
  return scripts\engine\utility::array_removeundefined(_id_C4CD691657517BB9);
}

_id_2987AA72031C4E08(_id_5C3F9357F11D2223) {
  _id_0DD6BF5F9DBA888C = scripts\mp\utility\weapon::getweapongroup(_id_5C3F9357F11D2223);
  return _id_724736FCF0FB6604::_id_A2FA56C4E1C77BA9(_id_0DD6BF5F9DBA888C);
}

_id_A3E0DC844A006178(itemlist) {
  foreach(item in itemlist) {
    if(isDefined(level.br_lootiteminfo[item]) && isDefined(level.br_lootiteminfo[item].baseweapon))
      itemlist[itemlist.size] = _id_2987AA72031C4E08(level.br_lootiteminfo[item].baseweapon);
  }

  return itemlist;
}

_id_5404608E3042633A(itemname, dropcount) {
  if(_id_724736FCF0FB6604::_id_09E44F8D2E11EF1A(itemname)) {
    _id_157B4641EF6FE484 = getdvarint("dvar_2BC596F53D1A3869", 2);
    dropcount = dropcount * _id_157B4641EF6FE484;
  }

  return dropcount;
}

_id_384F61E478B75347(player, _id_423E7C9070306589, _id_69351C74782C3984) {
  _id_C4CD691657517BB9 = _id_6C40CEEB0FB0B8E9(_id_423E7C9070306589, _id_69351C74782C3984);

  if(!isDefined(_id_C4CD691657517BB9) || _id_C4CD691657517BB9.size == 0)
    return _id_C4CD691657517BB9;

  if(istrue(_id_69351C74782C3984._id_A3E0DC844A006178))
    _id_C4CD691657517BB9 = _id_A3E0DC844A006178(_id_C4CD691657517BB9);

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_60821BAF8BE402D9 = spawnStruct();
  fwd = anglesToForward((0, self.angles[1], 0));
  _id_60821BAF8BE402D9.origin = self.origin + fwd * 25 + (0, 0, 55);
  _id_60821BAF8BE402D9.angles = (0, self.angles[1], 0);
  _id_60821BAF8BE402D9.itemsdropped = 0;
  _id_60821BAF8BE402D9._id_0D02A80ABBDD18FE = ::_id_C81898198DCC148B;
  _id_60821BAF8BE402D9._id_50DA9E9C166E5CE9 = ::_id_5404608E3042633A;
  _id_60821BAF8BE402D9._id_B3AEFAFBA795117F = player;
  _id_60821BAF8BE402D9._id_270E3D712E193E4F = 60;
  _id_60821BAF8BE402D9._id_7AAC6B8174790EC5 = self;
  _id_E05413A53B5D9167 = _id_60821BAF8BE402D9 _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, _id_C4CD691657517BB9, 0, undefined);
  return _id_C4CD691657517BB9;
}

_id_D72CB5BCD04D925B(origin, dropstruct) {
  _id_055D0FAE510B3813 = [0, 50, -50, 25, -25, 80, -80];
  _id_4573A8725DD3748E = self._id_B3AEFAFBA795117F.origin - origin;
  dist = max(length2d(_id_4573A8725DD3748E) - 15, 30);
  right = vectorcross(_id_4573A8725DD3748E, (0, 0, 1));
  right = vectorNormalize(right);
  _id_F7B5065A48A75B79 = randomfloatrange(-5, 5);
  _id_76044267DB696016 = _id_055D0FAE510B3813[dropstruct._id_DFBA5A2C3C6F0A07 % _id_055D0FAE510B3813.size] + _id_F7B5065A48A75B79;
  offset = right * _id_76044267DB696016;
  offset = origin + _id_4573A8725DD3748E + offset;
  return [offset, _id_F7B5065A48A75B79, dist];
}

_id_D08EBA54C53B4FAF(origin, dropstruct) {
  _id_1A94CFD339B37230 = 32.5;
  _id_AAEBBE102A24C0FF = 360.0 / dropstruct._id_FCE3CA815A6C5C67 * dropstruct._id_DFBA5A2C3C6F0A07;
  targetpos = vectorNormalize(self._id_B3AEFAFBA795117F.origin - origin);
  targetpos = targetpos * _id_1A94CFD339B37230;
  targetpos = targetpos + origin;
  self._id_A65C2F8BA927F538 = _id_0F97E96617321A00(self._id_7AAC6B8174790EC5._id_A65C2F8BA927F538, targetpos);
  _id_5BF3E22BDB650432 = undefined;

  foreach(point in self._id_A65C2F8BA927F538) {
    _id_A679C918818FA808 = getlootscriptablearrayinradius(undefined, undefined, point, _id_1A94CFD339B37230);

    if(isDefined(_id_A679C918818FA808) && _id_A679C918818FA808.size == 0) {
      _id_E965BCE0774276B4 = scripts\mp\utility\player::getplayersinradius(point, _id_1A94CFD339B37230);

      if(_id_E965BCE0774276B4.size == 0 || _id_E965BCE0774276B4.size == 1 && _id_E965BCE0774276B4[0] == self._id_B3AEFAFBA795117F) {
        _id_5BF3E22BDB650432 = point;
        break;
      }
    }
  }

  if(!isDefined(_id_5BF3E22BDB650432))
    _id_5BF3E22BDB650432 = self._id_A65C2F8BA927F538[0];

  if(dropstruct._id_FCE3CA815A6C5C67 > 1) {
    _id_F7B5065A48A75B79 = randomfloatrange(-15, 15);
    _id_5BF3E22BDB650432 = _id_5BF3E22BDB650432 + rotatevector((-20, 0, 0), (0, _id_AAEBBE102A24C0FF + _id_F7B5065A48A75B79, 0));
  }

  _id_4573A8725DD3748E = _id_5BF3E22BDB650432 - origin;
  dist = max(length2d(_id_4573A8725DD3748E), 30);
  return [_id_5BF3E22BDB650432, 0, dist];
}

_id_C81898198DCC148B(itemname, dropstruct, origin, angles, _id_4EDDEDC3311EDE0D, _id_3F237137640BEDCE, _id_4E6D8D712BB5D832, _id_447F40C814B97CDC) {
  if(getdvarint("dvar_A57429B2602E1687", 1))
    [_id_5BF3E22BDB650432, _id_F7B5065A48A75B79, dist] = _id_D08EBA54C53B4FAF(origin, dropstruct);
  else
    [_id_5BF3E22BDB650432, _id_F7B5065A48A75B79, dist] = _id_D72CB5BCD04D925B(origin, dropstruct);

  anglesoffset = vectortoangles(_id_5BF3E22BDB650432 - origin);
  yaw = anglesoffset[1] - angles[1];
  yaw = scripts\engine\utility::ter_op(yaw > 180, yaw - 360, yaw);
  yaw = scripts\engine\utility::ter_op(yaw < -180, yaw + 360, yaw);
  yaw = clamp(yaw, _id_F7B5065A48A75B79 - 90, 90 + _id_F7B5065A48A75B79);
  return _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, angles, _id_447F40C814B97CDC, yaw, dist);
}

_id_0F97E96617321A00(_id_15556BCBD050DD2E, origin) {
  _id_268B07C5C2DE1398 = [];

  foreach(point in _id_15556BCBD050DD2E) {
    _id_F90358454413407F = spawnStruct();
    _id_F90358454413407F.point = point;
    _id_F90358454413407F.distance = distancesquared(point, origin);
    _id_268B07C5C2DE1398[_id_268B07C5C2DE1398.size] = _id_F90358454413407F;
  }

  _id_268B07C5C2DE1398 = scripts\mp\utility\script::quicksort(_id_268B07C5C2DE1398, ::_id_175E7C4033244AFD);
  _id_8201C2D395D279D9 = [];

  foreach(_id_8C5B4576888D8A0A in _id_268B07C5C2DE1398)
  _id_8201C2D395D279D9[_id_8201C2D395D279D9.size] = _id_8C5B4576888D8A0A.point;

  return _id_8201C2D395D279D9;
}

_id_175E7C4033244AFD(left, right) {
  return left.distance <= right.distance;
}

_id_144CA1193F36516E() {
  _id_1A94CFD339B37230 = 32.5;
  _id_A65C2F8BA927F538 = [];
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);

  for(_id_AC0E594AC96AA3A8 = -3; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    for(y = 0; y < 3; y++) {
      _id_F945F5534FFEDF42 = y * 65 + _id_1A94CFD339B37230 + 30;
      _id_9E28554870F49B4D = _id_AC0E594AC96AA3A8 * 65 + _id_1A94CFD339B37230;
      _id_339F7F5021F8C048 = self.origin + _id_F945F5534FFEDF42 * forward + _id_9E28554870F49B4D * right;

      if(scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, 20), _id_339F7F5021F8C048 + (0, 0, 20))) {
        _id_A65C2F8BA927F538[_id_A65C2F8BA927F538.size] = _id_339F7F5021F8C048;
        continue;
      }
    }
  }

  self._id_A65C2F8BA927F538 = _id_A65C2F8BA927F538;
}

_id_4BB5ACC222D109BF() {
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  offsety = forward * 225;
  offsetx = right * 195;
  _id_7BA4DFE5CC4C1FFF = self.origin - offsetx;
  _id_7BA4E0E5CC4C2232 = _id_7BA4DFE5CC4C1FFF + offsety;
  _id_7BA4DAE5CC4C1500 = self.origin + offsetx;
  _id_7BA4E1E5CC4C2465 = _id_7BA4DAE5CC4C1500 + offsety;
  return [_id_7BA4DFE5CC4C1FFF, _id_7BA4E0E5CC4C2232, _id_7BA4E1E5CC4C2465, _id_7BA4DAE5CC4C1500];
}

_id_D791856A2F7A58ED(point, _id_ADD316EE840095A2) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_ADD316EE840095A2.size; _id_AC0E594AC96AA3A8++) {
    next = (_id_AC0E594AC96AA3A8 + 1) % _id_ADD316EE840095A2.size;

    if(!_id_E3125712731D02F9(point, _id_ADD316EE840095A2[_id_AC0E594AC96AA3A8], _id_ADD316EE840095A2[next]))
      return 0;
  }

  return 1;
}

_id_E3125712731D02F9(point, start, end) {
  return (end[0] - start[0]) * (point[1] - start[1]) - (point[0] - start[0]) * (end[1] - start[1]) < 0;
}

_id_F0588926F68D998B() {
  _id_70B103AFF325A86D = _id_4BB5ACC222D109BF();
  _id_5CFDEA376BD6406B = _id_70B103AFF325A86D[1];
  _id_F9D5FB13C2CB8857 = distance(_id_5CFDEA376BD6406B, self.origin);
  _id_8D6DA071C49CB986 = getlootscriptablearrayinradius(undefined, undefined, self.origin, _id_F9D5FB13C2CB8857);
  _id_AD4E9EF67CF48B35 = [];

  foreach(loot in _id_8D6DA071C49CB986) {
    if(abs(loot.origin[2] - self.origin[2]) < 35 && _id_D791856A2F7A58ED(loot.origin, _id_70B103AFF325A86D))
      _id_AD4E9EF67CF48B35[_id_AD4E9EF67CF48B35.size] = loot;
  }

  return _id_AD4E9EF67CF48B35;
}

_id_E6890F166A5E1EC6(_id_423E7C9070306589, _id_8C078B2449437A35) {
  foreach(index, _id_414EEC2F131C45C0 in _id_8C078B2449437A35) {
    foreach(_id_46594395EF9FF348 in _id_414EEC2F131C45C0._id_5642DDBDFCC3EAC1) {
      _id_A6EFCD61DD8C4E20 = _id_46594395EF9FF348._id_7580DFF7E9D8D111;

      if(_id_A6EFCD61DD8C4E20 == _id_423E7C9070306589)
        return index;
    }
  }

  return undefined;
}

_id_4ED75563576B91E8(itemname) {
  rarity = undefined;
  _id_11EE01EF1BB4A874 = strtok(itemname, "_");

  if(_id_11EE01EF1BB4A874.size == 2)
    rarity = int(_id_11EE01EF1BB4A874[0]);

  return rarity;
}

_id_732C56263DA70F33(item) {
  return !level.br_pickups._id_C4B4B56C76765330[item] && !scripts\engine\utility::array_contains(level._id_90D5AC9F18D44A51._id_3848126FC180B0F8, item) && !scripts\engine\utility::array_contains(level._id_90D5AC9F18D44A51._id_D8DD94861DA28AFE, item);
}

_id_A38FE5FC1FAF7983(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(item in array) {
    _id_4BC0473B682CDDC5 = 1;

    if(isDefined(level.br_lootiteminfo[item])) {
      weapontype = weaponclass(level.br_lootiteminfo[item].fullweaponobj);
      _id_4BC0473B682CDDC5 = !isDefined(weapontype) || weapontype != "pistol";
    }

    if(_id_4BC0473B682CDDC5 && _id_732C56263DA70F33(item))
      _id_BFC65A378A6D8EFE = scripts\engine\utility::array_add(_id_BFC65A378A6D8EFE, item);
  }

  return _id_BFC65A378A6D8EFE;
}

_id_3A3092E47D045E2D(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(name, item in array) {
    if(_id_732C56263DA70F33(name))
      _id_BFC65A378A6D8EFE[name] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_B3F97A87DD92BB57(array, value) {
  _id_BFC65A378A6D8EFE = [];

  foreach(name, item in array) {
    if(level.br_pickups.br_itemrarity[name] == value)
      _id_BFC65A378A6D8EFE[name] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_139818C4A8162B51(array, value) {
  _id_BFC65A378A6D8EFE = [];

  foreach(item in array) {
    if(level.br_pickups.br_itemrarity[item] == value)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_FD6545E977B212EC(_id_194E8ADF52AB0B06, _id_1FF427B6DE9CA76B) {
  _id_D4B5E075AD51A668 = [];

  if(!isDefined(_id_194E8ADF52AB0B06))
    return _id_D4B5E075AD51A668;

  foreach(item in _id_194E8ADF52AB0B06._id_74B0328B6595AF05) {
    _id_5D8DCBF3CC5D17A4 = isDefined(item._id_6180DA62AD446599) && isDefined(level.br_pickups.br_itemtype[item._id_6180DA62AD446599]);

    if(_id_5D8DCBF3CC5D17A4) {
      if(getdvarint("dvar_432B2E0461E83498", 1) == 0 && isstartstr(item._id_6180DA62AD446599, "brloot_plunder_cash_")) {
        continue;
      }
      if(_id_732C56263DA70F33(item._id_6180DA62AD446599))
        _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = item._id_6180DA62AD446599;
    }
  }

  _id_1306AD638CEDC772 = _id_4ED75563576B91E8(_id_194E8ADF52AB0B06._id_1306AD638CEDC772);

  if(isDefined(_id_1306AD638CEDC772)) {
    _id_6FA9DD7368FE4D0F = _id_A38FE5FC1FAF7983(level.br_pickups._id_692E058F97BCC055[_id_1306AD638CEDC772]);
    _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = _id_65DDE5B8D2A168DB(_id_6FA9DD7368FE4D0F, _id_1FF427B6DE9CA76B);
  }

  _id_0724449E842CF383 = _id_4ED75563576B91E8(_id_194E8ADF52AB0B06._id_0724449E842CF383);

  if(isDefined(_id_0724449E842CF383)) {
    _id_6FA9DD7368FE4D0F = _id_3A3092E47D045E2D(level.br_pickups.br_superreference);
    _id_6FA9DD7368FE4D0F = _id_B3F97A87DD92BB57(_id_6FA9DD7368FE4D0F, _id_0724449E842CF383);
    _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = _id_6FA158340BB503C5(_id_6FA9DD7368FE4D0F, _id_1FF427B6DE9CA76B);

    if(!istrue(level._id_90D5AC9F18D44A51._id_B9E3706B578B5E65) && getdvarint("dvar_D6CCA37494336C45", 1))
      _id_0EF2B9986DA96D56(_id_6FA9DD7368FE4D0F, _id_D4B5E075AD51A668);
  }

  _id_37318ADC176F0BB8 = _id_4ED75563576B91E8(_id_194E8ADF52AB0B06._id_37318ADC176F0BB8);

  if(isDefined(_id_37318ADC176F0BB8)) {
    _id_6FA9DD7368FE4D0F = _id_3A3092E47D045E2D(level.br_pickups.br_killstreakreference);
    _id_6FA9DD7368FE4D0F = _id_E78C57A96C3E5C8A(_id_6FA9DD7368FE4D0F);
    _id_6FA9DD7368FE4D0F = _id_B3F97A87DD92BB57(_id_6FA9DD7368FE4D0F, _id_37318ADC176F0BB8);
    _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = _id_6FA158340BB503C5(_id_6FA9DD7368FE4D0F, _id_1FF427B6DE9CA76B);
  }

  if(istrue(_id_194E8ADF52AB0B06._id_8E27D0E923E9F41D)) {
    _id_6FA9DD7368FE4D0F = _id_A38FE5FC1FAF7983(level.br_pickups._id_1E6C5E03170CF425);
    _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = _id_65DDE5B8D2A168DB(_id_6FA9DD7368FE4D0F, _id_1FF427B6DE9CA76B);
  }

  if(istrue(_id_194E8ADF52AB0B06._id_A89B7DDF6A1DFCFE)) {
    _id_6FA9DD7368FE4D0F = _id_A38FE5FC1FAF7983(level.br_pickups._id_EB7725A8A6F2C64C);
    _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size] = _id_65DDE5B8D2A168DB(_id_6FA9DD7368FE4D0F, _id_1FF427B6DE9CA76B);
  }

  return _id_D4B5E075AD51A668;
}

_id_0EF2B9986DA96D56(_id_6FA9DD7368FE4D0F, _id_D4B5E075AD51A668) {
  error = undefined;

  foreach(item in _id_6FA9DD7368FE4D0F) {
    if(item == "super_supply_drop" || item == "brloot_offhand_advancedsupplydrop") {
      error = "br_armory_trader can give a super_supply_drop which shouldn't. FilterItem size : " + level._id_90D5AC9F18D44A51._id_D8DD94861DA28AFE.size + " item: " + item;
      break;
    }
  }

  _id_3FAC5DC2E386BAA6 = _id_D4B5E075AD51A668[_id_D4B5E075AD51A668.size - 1];

  if(_id_3FAC5DC2E386BAA6 == "super_supply_drop" || _id_3FAC5DC2E386BAA6 == "brloot_offhand_advancedsupplydrop") {
    if(!isDefined(error))
      error = "";

    error = error + (" br_armory_trader is giving " + _id_3FAC5DC2E386BAA6 + " which shouldn't.");
  }

  if(isDefined(error)) {
    level._id_90D5AC9F18D44A51._id_B9E3706B578B5E65 = 1;
    _id_D09A84CDBF4FCDAB();
    scripts\mp\utility\script::demoforcesre(error);
  }
}

_id_E78C57A96C3E5C8A(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(name, item in array) {
    if(name != "brloot_specialist_bonus")
      _id_BFC65A378A6D8EFE[name] = item;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_65DDE5B8D2A168DB(list, _id_1FF427B6DE9CA76B) {
  _id_C0840EBB01F8FF6D = undefined;

  if(isDefined(list) && list.size > 0) {
    _id_F26451879315CADC = _id_A54A080EDCE0A822(list.size, _id_1FF427B6DE9CA76B);
    _id_C0840EBB01F8FF6D = list[_id_F26451879315CADC];
  }

  return _id_C0840EBB01F8FF6D;
}

_id_6FA158340BB503C5(list, _id_1FF427B6DE9CA76B) {
  _id_C0840EBB01F8FF6D = undefined;

  if(isDefined(list) && list.size > 0) {
    _id_F26451879315CADC = _id_A54A080EDCE0A822(list.size, _id_1FF427B6DE9CA76B);
    _id_E1A48B5D64CC4ACB = 0;

    foreach(index, _id_F7806D4CF24AACD3 in list) {
      if(_id_E1A48B5D64CC4ACB == _id_F26451879315CADC) {
        _id_C0840EBB01F8FF6D = index;
        break;
      }

      _id_E1A48B5D64CC4ACB++;
    }
  }

  return _id_C0840EBB01F8FF6D;
}