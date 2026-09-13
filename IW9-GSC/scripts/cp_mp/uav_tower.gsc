/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\uav_tower.gsc
***********************************************/

init(_id_07B60FA5A9F22356) {
  if(!_id_0FCD65DE73A5FD25() || isDefined(level._id_A1141D47AB94D2A1)) {
    return;
  }
  if(getdvarint("dvar_2B66F14A52279087", 0) && getdvarint("scr_ssc_enabled", 0)) {
    scripts\mp\flags::_id_1240434F4201AC9D("ssc_initialized");
    _id_067FB1233E876ED8::_id_4F7660CFD85CD517("uav_tower", ::_id_E6C1C35181A2870F);
    _id_067FB1233E876ED8::_id_412F527EF0863F0E("uav_tower", ::_id_DC8FD3D5775FE8BD);
    _id_067FB1233E876ED8::_id_EDED5B87F8F7BDFD("uav_tower", ::_id_B0CE2500FDBD63B1);
  }

  if(istrue(_id_07B60FA5A9F22356)) {
    level endon("game_ended");
    level waittill("prematch_done");
  }

  script_model_anims();
  level._id_CB86CA442250CA58 = getdvarfloat("dvar_401140680B9E3119", 3.0);
  level._id_6ACF91BBF5273E8F = getdvarint("dvar_BD581B3A13B81DB8", 5000);
  level._id_39F69F7DFC40A323 = getdvarint("dvar_E466D59282ECB790", 3000);
  level._id_AB2C4542C95656CB = getdvarint("dvar_D6193A209D3948A4", 3);
  level._id_20EBE48820FD70A2 = getdvarint("dvar_62BA9CF492C77F30", 120);
  level._id_C5BBB7914CB760CF = getdvarint("dvar_25AF310C5BC4BC7C", 3);
  level._id_EB56EA0BFDAA4011 = getdvarint("dvar_4704CC015DB60AD2", 3);
  level._id_174FE9ECCE8FB96B = randomintrange(level._id_C5BBB7914CB760CF, level._id_EB56EA0BFDAA4011 + 1);
  level._id_8703DF33A53750C6 = getdvarint("dvar_F741C76D2B72D5C5", 1);
  level._id_81018C8D037DA6C8 = getdvarint("dvar_D78433447211BC33", 1);
  level._id_79228B5606945E9F = getdvarint("dvar_2FD1561A14BC4D7D", 1);
  level._id_815479DA1DAFBDB0 = getdvarint("dvar_45F42BCB4E5D758D", 0);
  level._id_66BF5BFCA21A8D52 = getdvarint("dvar_0C7C9D45312DD7EC", 1);
  level._id_D507E35282B50614 = getdvarint("dvar_87EDEC4CE0D7B969", 0);
  level._id_DB9587440497015C = getdvarint("dvar_086826C94B10ECAB", 0);
  level._id_9F740C9281D0C7F4 = getdvarint("dvar_5569456C0EFF0D5B", 0);
  level._id_38C78BAB762BFFF6 = [];
  level._id_116A5F32AEB86391 = [];
  level._id_A1141D47AB94D2A1 = [];
  level._id_4414DBBF9D80D75D = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_uav_tower", ::_id_888A7CB98B23E26A);

  if(!getdvarint("dvar_2B66F14A52279087", 0) || !getdvarint("scr_ssc_enabled", 0))
    level thread _id_D45B1FDDB87CF6BC();

  thread _id_02A905DA0882C958();

  if(scripts\common\utility::ismp())
    scripts\cp_mp\utility\script_utility::registersharedfunc("uav_tower", "tower_disable", ::_id_CB5F7F3A47B6C95D);

  if(getdvarint("dvar_132AA99AE926C59C", 0))
    _id_2695A20D4011076D::_id_ECA79FA0F341EE08(14, ::dangercircletick, ::_id_1A1709943670772A);

  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_6BDC6F56944DC3AA);

  if(level._id_9F740C9281D0C7F4) {
    game["dialog"]["uav_tower_use_first_person"] = "uav1_wzan_klls";
    game["dialog"]["uav_tower_use_friendly"] = "uav1_wzan_ktla";
    game["dialog"]["uav_tower_use_enemy"] = "uav1_wzan_ktle";
  }
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["uav_tower"] = #animtree;
  level.scr_anim["uav_tower"]["use_uav_tower_enter"] = % dmz_uav_tower_enter;
  level.scr_animname["uav_tower"]["use_uav_tower_enter"] = "dmz_uav_tower_enter";
  level.scr_eventanim["uav_tower"]["use_uav_tower_enter"] = "use_uav_tower_enter";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_enter"] = "dmz_uav_tower_enter";
  level.scr_anim["uav_tower"]["use_uav_tower_idle"] = % dmz_uav_tower_idle;
  level.scr_animname["uav_tower"]["use_uav_tower_idle"] = "dmz_uav_tower_idle";
  level.scr_eventanim["uav_tower"]["use_uav_tower_idle"] = "use_uav_tower_idle";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_idle"] = "dmz_uav_tower_idle";
  level.scr_anim["uav_tower"]["use_uav_tower_exit"] = % dmz_uav_tower_exit;
  level.scr_animname["uav_tower"]["use_uav_tower_exit"] = "dmz_uav_tower_exit";
  level.scr_eventanim["uav_tower"]["use_uav_tower_exit"] = "use_uav_tower_exit";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_exit"] = "dmz_uav_tower_exit";
}

create_player_rig(animname, spawnpos, _id_B7850001037AA074) {
  self.animname = animname;

  if(!isDefined(spawnpos))
    spawnpos = (0, 0, 0);

  if(!isDefined(_id_B7850001037AA074))
    _id_B7850001037AA074 = (0, 0, 0);

  self _meth_B88C89BB7CD1AB8E(spawnpos);
  player_rig = spawn("script_arms", spawnpos, 0, 0, self);
  player_rig.angles = _id_B7850001037AA074;
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self playerlinktoabsolute(self.player_rig, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::_id_9897D143C3FEEE05();
  }

  if(isDefined(player_rig))
    player_rig delete();
}

_id_DC8FD3D5775FE8BD(_id_73BDEBBC7DA468A3) {
  if(!isDefined(level._id_D08063417D1D4DC7))
    level._id_D08063417D1D4DC7 = [];

  level._id_D08063417D1D4DC7[level._id_D08063417D1D4DC7.size] = _id_73BDEBBC7DA468A3;
  return _id_73BDEBBC7DA468A3;
}

_id_B0CE2500FDBD63B1() {
  level endon("game_ended");
  level waittill("prematch_done");
  waitframe();

  if(!isDefined(level._id_D08063417D1D4DC7) || level._id_D08063417D1D4DC7.size == 0) {
    return;
  }
  foreach(loc in level._id_D08063417D1D4DC7)
  _id_A517440C8FAA2939(loc);

  level._id_D08063417D1D4DC7 = undefined;
}

_id_A517440C8FAA2939(_id_73BDEBBC7DA468A3) {
  _id_B9AB8417F086258B = level._id_A1141D47AB94D2A1.size;
  _id_85BB401958C65B45 = _id_858AF52A8E277A68(_id_73BDEBBC7DA468A3, _id_B9AB8417F086258B);
  return _id_85BB401958C65B45;
}

_id_858AF52A8E277A68(_id_73BDEBBC7DA468A3, identifier) {
  if(!isDefined(_id_73BDEBBC7DA468A3.angles))
    _id_73BDEBBC7DA468A3.angles = (0, 0, 0);

  scriptable = spawnscriptable("dmz_uav_tower", _id_73BDEBBC7DA468A3.origin, _id_73BDEBBC7DA468A3.angles);
  scriptable setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
  scriptable setscriptablepartstate("objective", "inactive");

  if(level._id_D507E35282B50614 > 0)
    scriptable setscriptablepartstate("dmz_uav_tower", "usable_cost");

  _id_73BDEBBC7DA468A3._id_107D6E8FC82A82A8 = scriptable;
  scriptable._id_73BDEBBC7DA468A3 = _id_73BDEBBC7DA468A3;
  scriptable.identifier = identifier;
  scriptable._id_1DBFB72730034336 = 0;
  level._id_A1141D47AB94D2A1[level._id_A1141D47AB94D2A1.size] = _id_73BDEBBC7DA468A3;

  if(istrue(level._id_815479DA1DAFBDB0))
    scriptable._id_D265A28AC03ABC14 = [];

  return scriptable;
}

_id_FE7E4144E9133C3A() {
  if(!isDefined(level._id_FE7E4144E9133C3A))
    level._id_FE7E4144E9133C3A = getdvarint("dvar_7131733D65E51232", 0);

  return level._id_FE7E4144E9133C3A;
}

_id_E6C1C35181A2870F() {
  _id_B2C90DC03F470A24 = scripts\engine\utility::getStructArray("uav_tower", "targetname");

  if(!isDefined(_id_B2C90DC03F470A24) || _id_B2C90DC03F470A24.size < 1)
    _id_B2C90DC03F470A24 = scripts\engine\utility::getStructArray("dmz_uav_tower", "targetname");

  if(isDefined(level._id_3E175C0B6527751F))
    _id_B2C90DC03F470A24 = [[level._id_3E175C0B6527751F]]();

  return _id_B2C90DC03F470A24;
}

_id_D45B1FDDB87CF6BC() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_B2C90DC03F470A24 = _id_E6C1C35181A2870F();

  if(_id_B2C90DC03F470A24.size == 0) {
    return;
  }
  _id_57F36ABBEAC85747 = getdvarint("dvar_939AB4119A3DB356", 0);
  _id_FE7E4144E9133C3A = _id_FE7E4144E9133C3A();
  _id_B9AB8417F086258B = 0;

  if(!_id_57F36ABBEAC85747 && !_id_FE7E4144E9133C3A) {
    _id_1A7A45589889FD67 = [];
    _id_34965515AC54E0B5 = [];
    _id_371C833EBA04930E = scripts\cp_mp\utility\script_utility::issharedfuncdefined("poi", "poi_isPOIActive", 0);

    for(_id_33860CCEECB7379A = 0; _id_33860CCEECB7379A < _id_B2C90DC03F470A24.size; _id_33860CCEECB7379A++) {
      _id_D233486A875A4BA8 = _id_B2C90DC03F470A24[_id_33860CCEECB7379A];

      if(!isDefined(_id_D233486A875A4BA8._id_B205D90302DA2F07)) {
        continue;
      }
      if(!isDefined(_id_1A7A45589889FD67[_id_D233486A875A4BA8._id_B205D90302DA2F07])) {
        _id_1A7A45589889FD67[_id_D233486A875A4BA8._id_B205D90302DA2F07] = [];
        _id_34965515AC54E0B5[_id_34965515AC54E0B5.size] = _id_D233486A875A4BA8._id_B205D90302DA2F07;
      }

      _id_1A7A45589889FD67[_id_D233486A875A4BA8._id_B205D90302DA2F07][_id_1A7A45589889FD67[_id_D233486A875A4BA8._id_B205D90302DA2F07].size] = _id_D233486A875A4BA8;
    }

    _id_34965515AC54E0B5 = scripts\engine\utility::array_randomize(_id_34965515AC54E0B5);
    _id_4B30D157CDB30549 = 0;

    foreach(_id_7E5C3E3C0F4FB904 in _id_34965515AC54E0B5) {
      if(_id_4B30D157CDB30549 == level._id_174FE9ECCE8FB96B) {
        break;
      }

      if(_id_371C833EBA04930E && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("poi", "poi_isPOIActive")]](_id_7E5C3E3C0F4FB904)) {
        continue;
      }
      if(istrue(level._id_291B51C7AF8D1204) && _id_7E5C3E3C0F4FB904 == "saba_observatory") {
        continue;
      }
      _id_4B30D157CDB30549++;
      _id_DC97BA189A64519E = _id_1A7A45589889FD67[_id_7E5C3E3C0F4FB904];
      _id_8703DF33A53750C6 = getdvarint(_func_2EF675C13CA1C4AF("dvar_72DE7F7DBAE2D115", _id_7E5C3E3C0F4FB904), level._id_8703DF33A53750C6);
      _id_81018C8D037DA6C8 = getdvarint(_func_2EF675C13CA1C4AF("dvar_EA59C77E13B98A07", _id_7E5C3E3C0F4FB904), level._id_81018C8D037DA6C8);
      _id_B677145BCE94AEB6 = randomintrange(_id_8703DF33A53750C6, _id_81018C8D037DA6C8 + 1);

      if(_id_B677145BCE94AEB6 > _id_DC97BA189A64519E.size)
        _id_B677145BCE94AEB6 = _id_DC97BA189A64519E.size;

      _id_DC97BA189A64519E = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_DC97BA189A64519E), 0, _id_B677145BCE94AEB6);

      for(_id_33860CCEECB7379A = 0; _id_33860CCEECB7379A < _id_DC97BA189A64519E.size; _id_33860CCEECB7379A++) {
        _id_73BDEBBC7DA468A3 = _id_DC97BA189A64519E[_id_33860CCEECB7379A];
        _id_858AF52A8E277A68(_id_73BDEBBC7DA468A3, _id_B9AB8417F086258B);
        _id_B9AB8417F086258B++;
      }
    }

    return;
  } else if(!_id_FE7E4144E9133C3A) {
    _id_636432A951D1B72F = randomintrange(level._id_8703DF33A53750C6, level._id_81018C8D037DA6C8 + 1);

    if(_id_636432A951D1B72F < _id_B2C90DC03F470A24.size)
      _id_B2C90DC03F470A24 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_B2C90DC03F470A24), 0, _id_636432A951D1B72F);
  }

  for(_id_33860CCEECB7379A = 0; _id_33860CCEECB7379A < _id_B2C90DC03F470A24.size; _id_33860CCEECB7379A++) {
    _id_73BDEBBC7DA468A3 = _id_B2C90DC03F470A24[_id_33860CCEECB7379A];
    _id_858AF52A8E277A68(_id_73BDEBBC7DA468A3, _id_B9AB8417F086258B);
    _id_B9AB8417F086258B++;
  }
}

_id_444BBCC637C82FC2(scriptable, playerteam, _id_17B71F62DEAF8F29) {
  scriptable endon("death");
  scriptable endon("tower_disable");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    players = level.players;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
      players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](playerteam, "players");

    foreach(player in players)
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  radius = level._id_6ACF91BBF5273E8F * int(scripts\engine\utility::ter_op(_id_17B71F62DEAF8F29, getdvarfloat("dvar_BE8418001822E32E", 1.5), 1));

  for(;;) {
    triggerportableradarpingteam(scriptable.origin, playerteam, radius, level._id_39F69F7DFC40A323);
    wait(level._id_AB2C4542C95656CB);
  }
}

_id_CB5F7F3A47B6C95D(scriptable) {
  player = scriptable._id_27E49251BB3376EA;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap") && isDefined(player)) {
    players = level.players;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData"))
      players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](player.team, "players");

    foreach(_id_736D8D9188CCBD45 in players)
    _id_736D8D9188CCBD45[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
  }

  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("uav_tower_duration_ended", scriptable._id_DCC5F31EC71D6D8A);
  scriptable setscriptablepartstate("dmz_uav_tower_antenna", "active_end");
  scriptable setscriptablepartstate("objective", "inactive");
  scriptable._id_27E49251BB3376EA = undefined;
  scriptable._id_DCC5F31EC71D6D8A = undefined;
  level._id_116A5F32AEB86391 = scripts\engine\utility::array_remove(level._id_116A5F32AEB86391, scriptable);

  if(level._id_66BF5BFCA21A8D52)
    scriptable _id_C3476653BC728729();

  scriptable notify("tower_disable");
}

_id_C50A2EAC080FEF2D(scriptable, player, _id_17B71F62DEAF8F29) {
  _id_DE59F010026EC289 = scripts\engine\utility::ter_op(_id_17B71F62DEAF8F29, getdvarfloat("dvar_E2990A1622A30B28", 1.3), 1);
  _id_44805C8B4CD2E869 = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("instanceInventory", "getUpgradeCount", player, 25), 0);
  return level._id_20EBE48820FD70A2 * _id_DE59F010026EC289 + _id_44805C8B4CD2E869 * getdvarfloat("dvar_63D376B2633FD09F", 30);
}

_id_9A71DD352FE6DA4B(scriptable, _id_92740B3E2A2D79E3) {
  scriptable endon("death");
  scriptable endon("tower_disable");
  level endon("game_ended");
  wait(_id_92740B3E2A2D79E3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav_tower", "tower_disable"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav_tower", "tower_disable")]](scriptable);
}

_id_550DEEAC761AB7B9(scriptable, _id_92740B3E2A2D79E3) {
  scriptable endon("death");
  level endon("game_ended");

  if(!istrue(level._id_815479DA1DAFBDB0)) {
    level._id_38C78BAB762BFFF6[scriptable.index] = 1;
    wait(_id_92740B3E2A2D79E3 + level._id_79228B5606945E9F);
    level._id_38C78BAB762BFFF6[scriptable.index] = 0;
  } else {
    scriptable._id_D265A28AC03ABC14[self.team] = 1;
    scriptable scripts\engine\utility::waittill_any_timeout_1(_id_92740B3E2A2D79E3, "tower_disable");
    wait(level._id_79228B5606945E9F);
    scriptable._id_D265A28AC03ABC14[self.team] = 0;
  }
}

_id_888A7CB98B23E26A(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!_id_A9C1F9543F60E5C6(player)) {
    return;
  }
  canuse = !isDefined(level._id_38C78BAB762BFFF6[instance.index]) || !level._id_38C78BAB762BFFF6[instance.index];

  if(istrue(level._id_815479DA1DAFBDB0))
    canuse = !isDefined(instance._id_D265A28AC03ABC14[player.team]) || !instance._id_D265A28AC03ABC14[player.team];

  _id_4C63764D12ED5DEF = 1;

  if(level._id_D507E35282B50614 > 0) {
    _id_4C63764D12ED5DEF = istrue(player.plundercount >= level._id_D507E35282B50614);

    if(canuse && !_id_4C63764D12ED5DEF)
      canuse = 0;
  }

  if(canuse) {
    instance setscriptablepartstate("dmz_uav_tower", "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance _id_678EA4319B42DFED(player);
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);

    if(level._id_D507E35282B50614 > 0)
      instance setscriptablepartstate("dmz_uav_tower", "usable_cost");
    else
      instance setscriptablepartstate("dmz_uav_tower", "usable");

    if(level._id_D507E35282B50614 > 0) {
      _id_4C63764D12ED5DEF = istrue(player.plundercount >= level._id_D507E35282B50614);

      if(_id_4C63764D12ED5DEF && istrue(instance._id_B14A331BA425C286)) {
        players = level.players;
        instance thread _id_A301051F63FBBFF9(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, players);
      } else {
        if(_id_4C63764D12ED5DEF && !istrue(instance._id_B14A331BA425C286)) {
          return;
        }
        if(soundexists("ui_select_purchase_deny") && level._id_DB9587440497015C)
          player playlocalsound("ui_select_purchase_deny");

        if(isDefined(level.showerrormessagefunc))
          player[[level.showerrormessagefunc]]("DMZ/INSUFFICIENT_MONEY_UAV_TOWER");
        else {}
      }
    } else if(isDefined(instance._id_B14A331BA425C286) && instance._id_B14A331BA425C286) {
      players = level.players;
      instance thread _id_A301051F63FBBFF9(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, players);
    } else if(level._id_D507E35282B50614 > 0)
      instance setscriptablepartstate("dmz_uav_tower", "usable_cost");
    else
      instance setscriptablepartstate("dmz_uav_tower", "usable");
  } else if(!_id_4C63764D12ED5DEF) {
    if(soundexists("ui_select_purchase_deny") && level._id_DB9587440497015C)
      player playlocalsound("ui_select_purchase_deny");

    if(isDefined(level.showerrormessagefunc))
      player[[level.showerrormessagefunc]]("DMZ/INSUFFICIENT_MONEY_UAV_TOWER");
  } else {
    if(soundexists("br_pickup_deny") && level._id_DB9587440497015C)
      player playlocalsound("br_pickup_deny");

    if(isDefined(level.showerrormessagefunc))
      player[[level.showerrormessagefunc]]("DMZ/INACTIVE_UAV_TOWER");
  }
}

_id_678EA4319B42DFED(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player playlocalsound("uav_tower_foley", undefined, undefined, 1);
  player playSound("uav_tower_foley_npc", player, player);
  thread _id_796D1DA742E2A88A(player);
  _id_649D5137F5852321(player);
  player setclientomnvar("ui_dmz_uav_tower_screen", 1);
  thread _id_667FD79F2B5D6436(player);
  _id_E71D6089EBD93181(player);
  _id_B61464B3867D7BA3(player);
  player notify("interact_finished");
  waitframe();
  player _id_3C288BBDD4016FD4(1);

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(player))
    player notify("remove_rig");
}

_id_649D5137F5852321(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player _id_3C288BBDD4016FD4(0);
  player.linktoent = player scripts\engine\utility::spawn_tag_origin(player.origin, player getplayerangles(0));
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1);
  _id_9A2E0B6F009D8682 = self.angles + (0, -90, 0);
  goalpos = self.origin + rotatevector((55.632, -1.279, 0), _id_9A2E0B6F009D8682);
  forward = (0, 0, 0) - anglesToForward(_id_9A2E0B6F009D8682);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  _id_8003B0D4F9FBEE0E = axistoangles(forward, right, up);
  _id_57C87883AE437750 = 0.5;
  player.linktoent moveTo(goalpos, _id_57C87883AE437750, 0.1, 0.1);
  player.linktoent rotateTo(_id_8003B0D4F9FBEE0E, _id_57C87883AE437750, 0.1, 0.1);
  player setstance("crouch");
  _id_CD9982ADB17761A8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  _id_698CC218E4ADE75F = gettime();
  _id_218F64CB035D54BE = max(0, _id_57C87883AE437750 - (_id_698CC218E4ADE75F - _id_CD9982ADB17761A8) / 1000.0);
  wait(_id_218F64CB035D54BE);
  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(goalpos);
  player setplayerangles(_id_8003B0D4F9FBEE0E);
  animname = "use_uav_tower_enter";
  player thread create_player_rig("uav_tower", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);

  if(!isDefined(self.animstruct)) {
    animstruct = spawnStruct();
    animstruct.origin = self.origin;
    animstruct.angles = _id_9A2E0B6F009D8682;
    self.animstruct = animstruct;
  }

  self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, animname);
}

_id_667FD79F2B5D6436(player) {
  player endon("interact_interrupt");
  waitframe();
  player notifyonplayercommand("interact_cancelled", "+weapnext");
  self._id_A4CF15C49F3E9EEF = 0;
  msg = player scripts\engine\utility::waittill_any_timeout_1(level._id_CB86CA442250CA58, "interact_cancelled");
  self._id_A4CF15C49F3E9EEF = 1;
  player notifyonplayercommandremove("interact_cancelled", "+weapnext");

  if(msg == "interact_cancelled") {
    player stoplocalsound("uav_tower_foley");
    wait 0.25;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
  } else {
    self._id_B14A331BA425C286 = 1;
    player notify("interact_begin_exit");
  }
}

_id_796D1DA742E2A88A(player) {
  player endon("interact_cancelled");
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");

  if(!isDefined(player)) {
    return;
  }
  player notify("interact_interrupt");
  player stopanimscriptsceneevent();
  player stoplocalsound("uav_tower_foley");

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player _id_3C288BBDD4016FD4(1);
}

_id_E71D6089EBD93181(player, instance) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_begin_exit");
  player endon("interact_cancelled");

  while(scripts\mp\utility\player::isreallyalive(player))
    self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_idle");
}

_id_B61464B3867D7BA3(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");

  if(scripts\mp\utility\player::isreallyalive(player))
    self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_exit");
}

_id_3C288BBDD4016FD4(_id_BD138DE99B3B3507) {
  if(!_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::set("typing", "allow_jump", 0);
    _id_3B64EB40368C1450::set("typing", "gesture", 0);
    _id_3B64EB40368C1450::set("typing", "melee", 0);
    _id_3B64EB40368C1450::set("typing", "mantle", 0);
    _id_3B64EB40368C1450::set("typing", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("typing", "allow_movement", 0);
    _id_3B64EB40368C1450::set("typing", "sprint", 0);
    _id_3B64EB40368C1450::set("typing", "fire", 0);
    _id_3B64EB40368C1450::set("typing", "reload", 0);
    _id_3B64EB40368C1450::set("typing", "weapon_pickup", 0);
    _id_3B64EB40368C1450::set("typing", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("typing", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("typing", "execution_victim", 0);
    _id_3B64EB40368C1450::set("typing", "supers", 0);
    _id_3B64EB40368C1450::set("typing", "usability", 0);
    self setclientomnvar("ui_br_inventory_disabled", 1);
    self _meth_35501B42058D4DE9();
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("typing");
    self setclientomnvar("ui_br_inventory_disabled", 0);
    self _meth_BB04491D50D9E43E();
  }
}

_id_A301051F63FBBFF9(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61, streakinfo, players) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  level notify("uav_tower_activated", instance);

  if(isDefined(instance._id_27E49251BB3376EA)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav_tower", "tower_disable"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav_tower", "tower_disable")]](instance);
  }

  if(level._id_D507E35282B50614 > 0)
    player _id_1DD4B75D0A512FCC(level._id_D507E35282B50614);

  if(level._id_66BF5BFCA21A8D52)
    instance _id_86A96E658BBD0CBA(player.team);

  _id_17B71F62DEAF8F29 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](player.team, "players");

    foreach(player in players) {
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_pc_comms"))
          _id_17B71F62DEAF8F29 = 1;
      }
    }
  }

  _id_92740B3E2A2D79E3 = _id_C50A2EAC080FEF2D(instance, player, _id_17B71F62DEAF8F29);
  instance._id_B9C2A0C83178D652 = 1;
  instance setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  instance setscriptablepartstate("objective", "active");
  player thread _id_550DEEAC761AB7B9(instance, _id_92740B3E2A2D79E3);
  instance._id_27E49251BB3376EA = player;
  instance._id_DCC5F31EC71D6D8A = player.team;
  instance _meth_FCA5BDBE24070D20("objective", instance._id_DCC5F31EC71D6D8A);
  level._id_116A5F32AEB86391 = scripts\engine\utility::array_add(level._id_116A5F32AEB86391, instance);
  instance thread _id_449F829C0284B870(instance);
  thread _id_189B67B2735B981D::_id_952D1A246A3ECE86(player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onUAVTowerUsed"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onUAVTowerUsed")]](player, instance.identifier);

  instance thread _id_444BBCC637C82FC2(instance, player.team, _id_17B71F62DEAF8F29);
  instance thread _id_9A71DD352FE6DA4B(instance, _id_92740B3E2A2D79E3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getSquadmates")) {
    _id_607DA387F3617ED1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSquadmates")]](player.team, player._id_0FF97225579DE16A, 1);

    foreach(ent in _id_607DA387F3617ED1) {
      if(!isDefined(ent._id_C26450F6E6E47B84))
        ent._id_C26450F6E6E47B84 = 0;

      ent._id_C26450F6E6E47B84++;
      ent _id_098B53A7358927D9::_id_E800498086E36C29("stat_0541F0B57F321A27");
    }

    players = undefined;

    if(isDefined(instance._id_73BDEBBC7DA468A3._id_B205D90302DA2F07)) {
      players = level._id_B205D90302DA2F07[instance._id_73BDEBBC7DA468A3._id_B205D90302DA2F07]["players"];
      players = scripts\engine\utility::array_remove_array(players, _id_607DA387F3617ED1);
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("uav_tower_used_others", players);
    }

    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("uav_tower_used", _id_607DA387F3617ED1);

    if(level._id_DB9587440497015C && level._id_D507E35282B50614)
      wait 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showBrDMZSplash")) {
      if(isDefined(players))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_uav_tower_activated_others", players, instance._id_73BDEBBC7DA468A3._id_B205D90302DA2F07);

      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showBrDMZSplash")]]("dmz_uav_tower_activated_team", _id_607DA387F3617ED1, instance._id_73BDEBBC7DA468A3._id_B205D90302DA2F07);
    }

    if(level._id_9F740C9281D0C7F4) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("uav_tower_use_friendly", player.team, player, 1, undefined, 2);
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("uav_tower_use_first_person", player, 1, undefined, 2);
      _id_BBCF436A8958AC11 = scripts\mp\utility\teams::getteamdata(player.team, "players");
      _id_42CF18BB4B294DCE = scripts\mp\utility\player::getplayersinradius(instance.origin, level._id_6ACF91BBF5273E8F * 1.1, undefined, _id_BBCF436A8958AC11);

      foreach(player in _id_42CF18BB4B294DCE)
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("uav_tower_use_enemy", player, 1, undefined, 2);
    }
  }
}

_id_02A905DA0882C958() {
  level endon("game_ended");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_A1141D47AB94D2A1.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level._id_A1141D47AB94D2A1[_id_AC0E594AC96AA3A8]) && isDefined(level._id_A1141D47AB94D2A1[_id_AC0E594AC96AA3A8]._id_107D6E8FC82A82A8)) {
        instance = level._id_A1141D47AB94D2A1[_id_AC0E594AC96AA3A8]._id_107D6E8FC82A82A8;
        state = instance getscriptablepartstate("dmz_uav_tower_laptop");

        if(!istrue(instance._id_B9C2A0C83178D652) || state == "laptop_closed") {
          players = scripts\common\utility::playersnear(instance.origin, 400);

          if(isDefined(players) && players.size > 0) {
            if(state == "laptop_closed")
              instance setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
          } else if(state == "laptop_opened" && !istrue(instance._id_B9C2A0C83178D652))
            instance setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
        }
      }

      wait 0.25;
    }

    wait 0.25;
  }
}

_id_0FCD65DE73A5FD25() {
  return getdvarint("scr_enable_uav_towers", 1) == 1;
}

_id_A9C1F9543F60E5C6(player) {
  if(isDefined(player) && istrue(player._id_859654E0445A36D9)) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups._id_355CDDB773CB000D))
      player[[level.showerrormessagefunc]](level.br_pickups._id_355CDDB773CB000D);

    return 0;
  }

  if(player isthrowinggrenade() || player isswitchingweapon() || isDefined(player getheldoffhand()) && !isnullweapon(player getheldoffhand())) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups._id_0859F4BD204F1259))
      player[[level.showerrormessagefunc]](level.br_pickups._id_0859F4BD204F1259);

    return 0;
  }

  if(istrue(player._id_35DADE814E13D3CE)) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups._id_0859F4BD204F1259))
      player[[level.showerrormessagefunc]](level.br_pickups._id_0859F4BD204F1259);

    return 0;
  }

  return 1;
}

_id_449F829C0284B870(instance) {
  level endon("game_ended");
  wait 1;
  instance setscriptablepartstate("activated_oneshot_audio", "on");
  instance setscriptablepartstate("activated_alarm_tell", "on");
}

_id_1DD4B75D0A512FCC(amount, data) {
  _id_B44212E15FCE8588 = _id_6AFF3948CF4CCA03::playerplunderevent(amount, 4, undefined, data);

  if(isDefined(_id_B44212E15FCE8588)) {
    if(soundexists("ui_select_purchase_confirm") && level._id_DB9587440497015C && level._id_D507E35282B50614)
      self playlocalsound("ui_select_purchase_confirm");

    _id_B70C878DE3673730 = "highestPurchaseCost";

    if(!isDefined(self.pers[_id_B70C878DE3673730]) || self.pers[_id_B70C878DE3673730] < amount)
      self.pers[_id_B70C878DE3673730] = amount;
  }

  _id_6AFF3948CF4CCA03::_id_05A2284274D70F7D(4, amount);
  return _id_B44212E15FCE8588;
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  if(isDefined(level._id_A1141D47AB94D2A1)) {
    foreach(_id_C6CD9D2C6AD18DD6 in level._id_A1141D47AB94D2A1) {
      if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8.origin) && !_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336) {
        _id_CB5F7F3A47B6C95D(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8);
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "unusable");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("objective", "none");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336 = 1;
        level._id_4414DBBF9D80D75D[level._id_4414DBBF9D80D75D.size] = _id_C6CD9D2C6AD18DD6;
        continue;
      }

      if(_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8.origin) && _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336) {
        if(level._id_D507E35282B50614 > 0)
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable_cost");
        else
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable");

        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("objective", "inactive");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336 = 0;
        level._id_4414DBBF9D80D75D = scripts\engine\utility::array_remove(level._id_4414DBBF9D80D75D, _id_C6CD9D2C6AD18DD6);
      }
    }
  }
}

_id_1A1709943670772A() {
  if(isDefined(level._id_A1141D47AB94D2A1)) {
    foreach(_id_C6CD9D2C6AD18DD6 in level._id_A1141D47AB94D2A1) {
      if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8.origin) && !_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336) {
        _id_CB5F7F3A47B6C95D(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8);
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "unusable");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("objective", "none");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336 = 1;
        level._id_4414DBBF9D80D75D[level._id_4414DBBF9D80D75D.size] = _id_C6CD9D2C6AD18DD6;
        continue;
      }

      if(_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8.origin) && _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336) {
        if(level._id_D507E35282B50614 > 0)
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable_cost");
        else
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable");

        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("objective", "inactive");
        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336 = 0;
        level._id_4414DBBF9D80D75D = scripts\engine\utility::array_remove(level._id_4414DBBF9D80D75D, _id_C6CD9D2C6AD18DD6);
      }
    }
  }
}

_id_907613649C1C683D(_id_47CA96F0337924EF) {
  if(isDefined(level._id_A1141D47AB94D2A1)) {
    foreach(_id_C6CD9D2C6AD18DD6 in level._id_A1141D47AB94D2A1) {
      if(_id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336) {
        if(level._id_D507E35282B50614 > 0)
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable_cost");
        else
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("dmz_uav_tower", "usable");

        _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8 setscriptablepartstate("objective", "inactive");

        if(istrue(_id_47CA96F0337924EF))
          _id_C6CD9D2C6AD18DD6._id_107D6E8FC82A82A8._id_1DBFB72730034336 = 0;

        level._id_4414DBBF9D80D75D = scripts\engine\utility::array_remove(level._id_4414DBBF9D80D75D, _id_C6CD9D2C6AD18DD6);
      }
    }
  }
}

_id_86A96E658BBD0CBA(team) {
  scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("active_uav_tower_radius", self.origin, level._id_6ACF91BBF5273E8F);
  scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();

  if(isDefined(team)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
    scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  }
}

_id_C3476653BC728729() {
  if(scripts\cp_mp\utility\game_utility::_id_ACAA75CA8754452E())
    scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

_id_6BDC6F56944DC3AA(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(level._id_66BF5BFCA21A8D52) {
    foreach(_id_C6CD9D2C6AD18DD6 in level._id_116A5F32AEB86391) {
      if(isDefined(_id_C6CD9D2C6AD18DD6._id_DCC5F31EC71D6D8A)) {
        if(_id_C6CD9D2C6AD18DD6._id_DCC5F31EC71D6D8A == _id_8A04AA0E0755E7E3)
          _id_C6CD9D2C6AD18DD6 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);

        if(_id_C6CD9D2C6AD18DD6._id_DCC5F31EC71D6D8A == _id_EB06B338608EF354)
          _id_C6CD9D2C6AD18DD6 scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
      }
    }
  }
}