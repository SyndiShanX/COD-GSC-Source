/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_armory_trader.gsc
***********************************************/

init() {
  level.debug_trap_room = spawnStruct();
  level.debug_trap_room.scriptables = [];
  level.debug_trap_toggle = getdvarint("_encstr_9A0E15D05EF26F8AA2EE7FA590E0B20AE0E08A47F2C720", 0) != 0;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8460075C1E09B347FD"))
    level.debug_trap_toggle = 0;
  else {
    var_0 = registeraccesscardlocs();

    if(!isDefined(var_0) || var_0.size == 0)
      level.debug_trap_toggle = 0;
  }

  if(!level.debug_trap_toggle) {
    return;
  }
  scripts\engine\scriptable::_id_12F5B("_encstr_8B41117DCDD8F3E572603A9F51CB2A42D49DBA", ::camera_loadout_showcase_preview_large_sticker_alt1);
  level.debug_trap_room._id_11A20 = strtok(getDvar("_encstr_9ABE0B8CF2647108D00BD9D36B", "_encstr_B40101"), "_encstr_854C021F");
  level.debug_trap_room.play_lighting_sequence = strtok(getDvar("_encstr_A5301CF3D8256933FBAFC9D221604B28D7F86B2A08D39A8F1173DCECCD2B", "_encstr_BE51547A0248B7C5F4B9F075FD88D228AD16E3E070A1A06FF2D2EB8D3B2A39B3B34B4FA00CF38E9AF70F2340B9E8456E037AFDF6F02B4B53988B8B7923FBAB7F57DB77CBDB467F36D820788A35D7202BF075B2F81804"), "_encstr_854C021F");
  _encstr_8A8D10B9DF125DF8116FD1CB17F1C095EA03();
  tr_detectwinners();
  level.debug_trap_room.xp = [0, 100, 200, 300, 500];
  level.debug_trap_room._id_140A2 = [1, 2.5, 3, 3.5, 5];
  level.debug_trap_room._id_1409A = ["_encstr_A2CF12AB2AA97D9C5827961DCBF5D8DBD6B6DE73", "_encstr_AD6A14D545A9FAE40B274B8E5EF5EAE68DEDB5ADED9B", "_encstr_B49B10EAA835EBE42C4E2D472FD7392C932B", "_encstr_B2EE10F12127A9B359560114EBA6D72AFB1B", "_encstr_B2E215BA459ABE4E2CE4A5E8E5AF36563B56B9912CC95E"];
}

_encstr_8A8D10B9DF125DF8116FD1CB17F1C095EA03() {
  var_0 = getDvar("_encstr_A5301CF3D8256933FBAFC9D221604B28D7F86B2A08D39A8F1173DCECCD2B", "_encstr_9B5A121535EA6369C923B8A8FF1CC1AD421B011D");
  logstring("_encstr_8EE33831E4EB2C4EB5ED39CBFA479CB08CAC4E029B8D9CAF314EBEB0E4DAB7C9E57DA33985325639F5662D3647B24E0267C2D8572B01969B7480" + var_0);
  var_1 = "_encstr_B40101";

  foreach(var_3 in level.debug_trap_room.play_lighting_sequence)
  var_1 = var_1 + (var_3 + "_encstr_974C0246");

  logstring("_encstr_9A3B41E54E7E8AC23DDD4333C795D8D734E23BA9F0BD58E170AE76FB01075202DFD3EBFFE5622159CFAA0A6FC1E8133A8805E1F9D3358B976AD5133DEB490AD82795C9" + var_1);
}

tr_detectwinners() {
  level.debug_trap_room._id_13C65 = [];
  level.debug_trap_room._id_13C65["_encstr_8B1608EC43B8D647A113"] = tmtyl_bomber_squadafterspawnfunc(getDvar("_encstr_841B1D6EB139D71339AF8539B67B27F2D7E82758192BE4F5F638D12DBD73E6", "_encstr_9647172AE2677983BFDB4EFF2D020CFF3BA770282F5ACBE7C8"));
}

tmtyl_bomber_squadafterspawnfunc(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = undefined;
  var_4 = tablelookupgetnumrows(var_0);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = tablelookupbyrow(var_0, var_5, 0);

    if(!isDefined(var_6) || var_6 == "_encstr_B40101") {
      continue;
    }
    if(var_6 == "_encstr_A34C02BB") {
      if(!isDefined(var_3) || var_3 != var_6) {
        var_2 = spawnStruct();
        var_2._id_13A31 = [];
        var_2.entries = [];
        var_1 = scripts\engine\utility::array_add(var_1, var_2);
      }

      var_2._id_13A31[var_2._id_13A31.size] = tablelookupbyrow(var_0, var_5, 1);
    } else if(var_6 == "_encstr_A74C0222" && isDefined(var_2)) {
      var_7 = spawnStruct();
      var_7.weight = int(tablelookupbyrow(var_0, var_5, 1));
      var_8 = [];
      var_9 = 7;

      for(var_10 = 2; var_10 < var_9; var_10++) {
        var_6 = tablelookupbyrow(var_0, var_5, var_10);

        if(!isDefined(var_6) || var_6 == "_encstr_B40101") {
          continue;
        }
        var_8[var_8.size] = tablelookupbyrow(var_0, var_5, var_10);
      }

      var_7._id_12A7F = var_8;
      var_2.entries[var_2.entries.size] = var_7;
    } else
      continue;

    var_3 = var_6;
  }

  return var_1;
}

tr_entergulag() {
  return randomint(getdvarint("_encstr_961E20A2CE6571EAC3691F6BC058B25B67DD6A5E25E31B0F2B702B3BB87091B3FB76", 32767));
}

onprematchdone() {
  foreach(var_1 in level.debug_trap_room.scriptables) {
    var_1 setscriptablepartstate("_encstr_8B41117DCDD8F3E572603A9F51CB2A42D49DBA", "_encstr_BE8B08E323FB2BCD6268");
    var_1.visible = 1;
    var_1._id_13C6B = "_encstr_8B1608EC43B8D647A113";
    var_1.forceextractscriptable = tr_entergulag();
    var_1._id_11B72 = int(pow(2, 4)) - 1;
    var_1 toma_strike_trace_offset();
    var_1 _encstr_8FF20D0225F72009BEFF03478BDA95();
    var_1 thread x1ops7();
  }
}

toma_strike_trace_offset() {
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 500, 500);
  var_0.playersintrigger = [];
  var_0 thread _id_14500(self);
  var_0 thread _id_14501(self);
  var_0 thread _id_14369();
  self._id_1292C = var_0;
}

_id_14500(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_2 = var_1 getentitynumber();

    if(isDefined(self.playersintrigger[var_2])) {
      continue;
    }
    self.playersintrigger[var_2] = var_1;
    var_1 thread _id_12027(self, var_0);
  }
}

_id_14501(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_3, var_2 in self.playersintrigger) {
      if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && var_2 istouching(self)) {
        continue;
      }
      self.playersintrigger[var_3] = undefined;
      _id_12030(var_2, var_0);
    }

    waitframe();
  }
}

_id_14369() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  lb_mg_impulse_dmg_threshold_top();
}

lb_mg_impulse_dmg_threshold_top() {
  self delete();
}

_id_12027(var_0, var_1) {
  thread monitorweaponchange(var_1);
}

_id_12030(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 notify("_encstr_991D1EAF65F913151539FB93A069CF43965512398CC18F9A4FF0433A30B3473F" + var_1._id_1292C getentitynumber());
}

monitorweaponchange(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_991D1EAF65F913151539FB93A069CF43965512398CC18F9A4FF0433A30B3473F" + var_0._id_1292C getentitynumber());
  var_1 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::router_use_obj();

  for(;;) {
    if(!isDefined(var_1) || var_1.basename != "_encstr_B1FD1078CA47B0A67257F7DDC70BE5991D62" && var_1.basename != "_encstr_8BBA05185F8B99")
      var_0 _id_1400E(self, var_1);

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);
    waitframe();
  }
}

x1ops7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_921D09D9D9C0090D7275B4");

  for(;;) {
    level scripts\engine\utility::_id_143A5("_encstr_99DC1C70EB101DAFBEFE4A438137939968BB0AED7FA0A5474893533A0B65", "_encstr_AD111A71E516E8330F89D9A332E375B9AF41FDC38BBEB00DD7C2B0E9");
    self.playcrateimpactfx = [];
    _id_1400D();
  }
}

_id_1400D() {
  if(isDefined(self._id_1292C) && isDefined(self._id_1292C.playersintrigger)) {
    foreach(var_1 in self._id_1292C.playersintrigger) {
      var_2 = var_1.lastdroppableweaponobj;

      if(!isDefined(var_2) || var_2.basename != "_encstr_B1FD1078CA47B0A67257F7DDC70BE5991D62" && var_2.basename != "_encstr_8BBA05185F8B99")
        _id_1400E(var_1, var_2);
    }
  }
}

dangercircletick(var_0, var_1) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8460075C1E09B347FD") || getdvarint("_encstr_A15D1C8E5BF3D685DAB9F0C87277B3CBEFC91C88BF2B59B7C6A2D878BACF", 0) == 1) {
    return;
  }
  var_2 = var_1 * var_1;

  foreach(var_4 in level.debug_trap_room.scriptables) {
    if(isDefined(var_4.visible) && distance2dsquared(var_4.origin, var_0) > var_2)
      little_bird_mg_mp_ondeathrespawncallback(var_4);
  }
}

little_bird_mg_initspawning() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8460075C1E09B347FD")) {
    return;
  }
  foreach(var_1 in level.debug_trap_room.scriptables) {
    if(isDefined(var_1.visible))
      little_bird_mg_mp_ondeathrespawncallback(var_1);
  }
}

little_bird_mg_mp_ondeathrespawncallback(var_0) {
  var_0 setscriptablepartstate("_encstr_8B41117DCDD8F3E572603A9F51CB2A42D49DBA", "_encstr_921D09D9D9C0090D7275B4");
  var_0.visible = undefined;
  var_0.disabled = 1;

  if(var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::gethelispawns())
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();

  if(isDefined(var_0._id_1292C))
    var_0._id_1292C lb_mg_impulse_dmg_threshold_top();

  var_0 notify("_encstr_921D09D9D9C0090D7275B4");
}

registeraccesscardlocs() {
  if(!level.debug_trap_toggle) {
    return;
  }
  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AB0F0E1C36C21B56918A392C8C2B4EE6"))) {
    return;
  }
  var_0 = getentitylessscriptablearrayinradius("_encstr_A27E1C5F88DBF19B491736AD0D77F29206F0C3AF5073299191B6FEA76515", "_encstr_AC110A7F14873B5B3D073009");
  return var_0;
}

_id_131C0(var_0) {
  level.debug_trap_room.scriptables = var_0;
}

run_module_pause_funcs(var_0, var_1) {
  var_2 = var_0;

  if(updatecollectionuiforplayer(var_1))
    var_2 = 11;
  else if(var_0 == 5 || var_0 == 6)
    var_2 = 4;

  return var_2;
}

_id_1400E(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;

  if(var_0 vars_print(var_1))
    [var_2, var_3, var_4] = var_0 restore_ai_weapon(var_1);

  if(!isDefined(var_2)) {
    var_6 = _id_13FFE(0, undefined, 0, 4);
    var_0 setclientomnvar("_encstr_ADC52015B399FEA3C09B2A9283201B79182DB98C3398C9E37E7132DA4E8D5FEB1851", var_6);
    return;
  }

  var_7 = run_module_pause_funcs(var_2, var_0);
  var_8 = [];

  for(var_9 = 0; var_9 < 2; var_9++)
    var_8[var_9] = -1;

  if(!istrue(var_0.van_blocker_moves)) {
    var_10 = 134217728;
    var_10 = ~var_10;
    var_8[1] = var_8[1] &var_10;
  }

  var_11 = 0;
  var_8[var_11] = _id_13FFE(var_8[var_11], var_7, 0, 4);
  var_12 = run_maze_ai_common_function_stealth(var_0, level.debug_trap_room._id_13C65[self._id_13C6B], var_7);

  if(isDefined(var_12)) {
    var_13 = 4;
    var_8[var_11] = _id_13FFE(var_8[var_11], var_3, var_13, 4);
    var_13 = var_13 + 4;
    var_8[var_11] = _id_13FFE(var_8[var_11], var_4, var_13, 4);
    var_13 = var_13 + 4;

    foreach(var_15 in var_12) {
      var_16 = removenonvipteamlocations(var_15);
      var_8[var_11] = _id_13FFE(var_8[var_11], var_16, var_13, 9);
      var_13 = var_13 + 9;

      if(var_13 + 9 >= 32) {
        var_13 = 0;
        var_11++;
      }
    }
  }

  for(var_9 = 0; var_9 < var_8.size; var_9++)
    var_0 setclientomnvar("_encstr_A57E1F2BC3C75AF26E30071F2040D63139E6B6E7BDC5C13C13781B374159914BEB" + var_9, var_8[var_9]);
}

updatecollectionuiforplayer(var_0) {
  if(!_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::upload_station_interact_used_think(2))
    return 0;

  return !scripts\engine\utility::array_contains(self.playcrateimpactfx, var_0);
}

removenonvipteamlocations(var_0) {
  return level.br_pickups.br_itemrow[var_0];
}

relic_vampire_feedback(var_0) {
  if(isDefined(var_0) && isDefined(level.br_lootiteminfo[var_0]) && isDefined(level.br_lootiteminfo[var_0].playerstartbesttimeupdate))
    return level.br_lootiteminfo[var_0].playerstartbesttimeupdate;

  return undefined;
}

_id_13FFE(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = int(pow(2, var_3 + 1) - 1);

  var_4 = int(pow(2, var_3)) - 1;
  var_4 = var_4 << var_2;
  var_5 = ~var_4;
  var_0 = var_0 &var_5;
  var_6 = var_1 << var_2;
  var_0 = var_0 | var_6;
  return var_0;
}

get_car_stop_struct(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    return 0;

  if(istrue(level.gameended))
    return 0;

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_1.inlaststand))
    return 0;

  if(var_1 scripts\cp_mp\utility\player_utility::isusingremote())
    return 0;

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(var_1 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_99BF1329D1D1E75FE321F84309778B37879F3D33B2", var_0)))
    return 0;

  if(istrue(var_1.iscarrying) && !isDefined(var_1.get_search_turret_target_player)) {
    var_1 scripts\mp\hud_message::showerrormessage("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
    return 0;
  }

  if(!var_1 vars_print(var_2))
    return 0;

  return 1;
}

vars_print(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.inventorytype) || var_0 != self getcurrentweapon() && var_0 != self getcurrentprimaryweapon())
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108")
    return 0;

  return 1;
}

camera_loadout_showcase_preview_large_sticker_alt1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::router_use_obj();

  if(!get_car_stop_struct(var_0, var_3, var_5)) {
    return;
  }
  [var_7, var_8, var_9] = var_3 restore_ai_weapon(var_5);

  if(!isDefined(var_7)) {
    return;
  }
  var_0 notify("_encstr_A9C011A3E4858C5927BE57CD59D76EE8C2C9D1");
  var_0 thread _id_13C6C();

  if(var_2 == "_encstr_BE8B08E323FB2BCD6268") {
    var_0 setscriptablepartstate("_encstr_8B41117DCDD8F3E572603A9F51CB2A42D49DBA", "_encstr_93CF08C7684F60BBB372");
    var_0 thread _id_13C66();
  }

  if(istrue(var_3.tracking_max_health))
    var_3 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

  var_10 = var_0 run_module_pause_funcs(var_7, var_3);
  var_3.camera_character_preview_select_detail = spawnStruct();
  var_3.camera_character_preview_select_detail.curprogress = 0.0;
  var_3.camera_character_preview_select_detail.usetime = var_0 run_to_retreat_spot(var_3, var_10);
  var_3.camera_character_preview_select_detail._id_14099 = var_0 rooftop_crate_usefunc(var_3, var_10);
  var_3.camera_character_preview_select_detail._id_145A2 = var_5;
  _id_1387E(var_3, var_0, var_5);
  var_11 = _id_1448C(var_3, var_0);

  if(isDefined(var_3))
    _id_138F4(var_3, var_0, var_11);

  if(istrue(var_11)) {
    var_3 scripts\cp\vehicles\vehicle_compass_cp::_id_120A8("_encstr_8460075C1E09B347FD");
    var_3 thread advance_bomb_wire_list(var_0, var_5, var_7, var_10);
  }

  var_3.camera_character_preview_select_detail = undefined;
}

_id_13C6C() {
  self endon("_encstr_A9C011A3E4858C5927BE57CD59D76EE8C2C9D1");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  while(var_0 < 30) {
    wait 1.5;
    var_0 = var_0 + 1.5;
    var_1 = scripts\mp\utility\player::getplayersinradius(self.origin, 175);

    if(var_1.size > 0)
      var_0 = 0;
  }

  self setscriptablepartstate("_encstr_8B41117DCDD8F3E572603A9F51CB2A42D49DBA", "_encstr_BEE608BF50D84BAA9DF4");
  self.forceextractscriptable = tr_entergulag();
  _id_1400D();
  thread _id_13C67();
}

_id_13C67() {
  self endon("_encstr_A9C011A3E4858C5927BE57CD59D76EE8C2C9D1");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(var_0 = 1; var_0; var_0 = var_1.size > 0) {
    wait 2;
    var_1 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
  }

  heatcounter();
}

heatcounter() {
  wait 2;
  var_0 = getdvarfloat("_encstr_86CD0A710C4B7925595F8A3B", 128) + 16;
  var_1 = canceljoins(undefined, undefined, self.origin, var_0);

  if(getdvarint("_encstr_877A20CB5B0AD1D77A5020B8F071550AC2492F83E1CB90503F80CB97575117F39F0A", 1))
    var_1 = scripts\engine\utility::array_combine_unique(var_1, _encstr_8E0424BF6D73D0CF40C4483F43EBCB9309B0C0FBE3A6B3E7593C2298B8EFE30F3FB7C4BB5BC7());

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }
      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_3);
    }
  }
}

_id_1448C(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1.id = "_encstr_8F130D770F8AA7D8C6793BF39EB4F0";
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);
  playusesound(var_0, var_0.camera_character_preview_select_detail._id_14099);

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && get_aitypes_and_weights_from_call_counter(var_0, var_1) && var_0 useButtonPressed()) {
    var_0.camera_character_preview_select_detail.curprogress = var_0.camera_character_preview_select_detail.curprogress + level.framedurationseconds * var_1.userate;

    if(var_0.camera_character_preview_select_detail.curprogress >= var_0.camera_character_preview_select_detail.usetime) {
      var_0.camera_character_preview_select_detail.curprogress = 0.0;
      return 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1, var_0.camera_character_preview_select_detail);
    waitframe();
  }

  if(isDefined(var_0.camera_character_preview_select_detail) && isDefined(var_0.camera_character_preview_select_detail.curprogress))
    var_0.camera_character_preview_select_detail.curprogress = 0.0;

  return 0;
}

get_aitypes_and_weights_from_call_counter(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed())
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0 meleeButtonPressed())
    return 0;

  if(var_0 isinexecutionvictim())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(!isDefined(var_0.camera_character_preview_select_detail) || !var_0 hasweapon(var_0.camera_character_preview_select_detail._id_145A2))
    return 0;

  var_2 = getdvarfloat("_encstr_86CD0A710C4B7925595F8A3B", 128) + 16;
  var_3 = var_2 * var_2;

  if(distancesquared(var_0.origin, var_1.origin) > var_3)
    return 0;

  return 1;
}

_id_1387E(var_0, var_1, var_2) {
  var_0 thread camera_loadout_showcase_preview_charm_alt4(var_2);
  var_0 scripts\mp\playeractions::allowactionset("_encstr_828C09996A99584D51C7DB", 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.camera_character_preview_select_detail);
  var_0 setclientomnvarbit("_encstr_97C5203DE1F7C17541EB88A0B365153E33824F3D45FBAEB1F292B89839FFC393BF69", 27, 1);
  var_0.van_blocker_moves = 1;
}

_id_138F4(var_0, var_1, var_2) {
  var_0 scripts\mp\playeractions::allowactionset("_encstr_828C09996A99584D51C7DB", 1);

  if(isDefined(var_0.camera_character_preview_select_detail)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.camera_character_preview_select_detail);
    stopusesound(var_0, var_0.camera_character_preview_select_detail._id_14099);
  }

  var_0 setclientomnvarbit("_encstr_97C5203DE1F7C17541EB88A0B365153E33824F3D45FBAEB1F292B89839FFC393BF69", 27, 0);
  var_0 notify("_encstr_84D20F6BB8EB3FB753B8657B4D1E7F4519", var_2);
  var_0.van_blocker_moves = undefined;
}

playusesound(var_0, var_1) {
  var_0 playlocalsound(var_1);
}

stopusesound(var_0, var_1) {
  var_0 stoplocalsound(var_1);

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    var_0 playsoundonmovingent("_encstr_A31314996D2FE1B28597D25E186B93C325F3FF8835CB");
}

camera_loadout_showcase_preview_charm_alt4(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\weapon_utility::_id_12EB2();
  var_1 = getcompleteweaponname("_encstr_B1FD1078CA47B0A67257F7DDC70BE5991D62");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
  thread camera_loadout_showcase_preview_large_sticker(var_1, var_0);
  self switchtoweapon(var_1);
}

camera_loadout_showcase_preview_large_sticker(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_84D20F6BB8EB3FB753B8657B4D1E7F4519", var_2);

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

    if(!istrue(var_2) && isDefined(var_1)) {
      var_3 = scripts\cp_mp\utility\weapon_utility::_id_12CC7(var_1);
      self switchtoweapon(var_3);
      thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_3);
    }
  }
}

_id_13C66() {
  if(!getdvarint("_encstr_962720AF888B89A0729601B2FFCBE9B3670738A88F70937FBE451F2045684A22A317", 1)) {
    return;
  }
  var_0 = getdvarfloat("_encstr_8B0A276E8D4EBE134E7DA39316462B93AF66A5E1FA0EC9EDB995EB0EB12CF22B9CB9D7C9C2C8B4AEE6", 300);
  _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::player_give_intel_1_ks(var_0);
}

advance_bomb_wire_list(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }
  _id_121E6(var_2);

  if(var_3 == 11)
    var_0.playcrateimpactfx = scripts\engine\utility::array_add(var_0.playcrateimpactfx, self);

  self takeweapon(var_1);

  if(!self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"))
    self giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  self switchtoweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  var_4 = var_0 _id_13657(self, level.debug_trap_room._id_13C65[var_0._id_13C6B], var_3);

  if(level.debug_trap_toggle && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::turret_headicon())
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A7301580D017579BBD57CA299F547B1667B21BF0E0FA1F", undefined, safehouse_spawn(var_2));

  if(!isDefined(var_4))
    var_4 = [];

  var_5 = 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex))
    var_5 = level.br_circle.circleindex;

  self dlog_recordplayerevent("_encstr_A54B185D1CCF99C727E3A0E0DB7173F37FB7DE4B57CB63834F3A", ["_encstr_ADFE0EAB45E7DF0DE8872A7FAE72C3B1", var_2, "_encstr_95040DE8E416C82BEB93B0C94BE8BC", var_3, "_encstr_BAA70D43AB53970DDBF1921AD023C0", var_5, "_encstr_B17B0F1867017A4A6B47C9C0A243031D1B", var_4]);
}

run_to_retreat_spot(var_0, var_1) {
  if(!isDefined(var_1))
    return getdvarfloat("_encstr_814519334E65E14042CEC1ABCE29E1FB29FB36550F9399BF3B1020", level.debug_trap_room._id_140A2[0]);
  else if(var_1 == 11)
    return getdvarfloat("_encstr_A78820CDD8C9F52627FAA339B08C594EF566D239CAB90BD859D7EAB9ACAFE8965BB2", 3);

  var_1 = int(clamp(var_1, 0, 4));
  return getdvarfloat("_encstr_96F4182EFB5376653A591028D2D713AB8F75B6AD6F9378B32761" + var_1, level.debug_trap_room._id_140A2[var_1]);
}

rooftop_crate_usefunc(var_0, var_1) {
  if(!isDefined(var_1))
    return "_encstr_A2CF12AB2AA97D9C5827961DCBF5D8DBD6B6DE73";
  else if(var_1 == 11)
    return "_encstr_84871447B1BEE1620B4BA4EBC219BE5A867B6F1759DD";

  var_1 = int(clamp(var_1, 0, 4));
  return level.debug_trap_room._id_1409A[var_1];
}

safehouse_spawn(var_0) {
  if(!isDefined(var_0))
    return 0;
  else if(var_0 == 11)
    return 100;

  var_0 = int(clamp(var_0, 0, 4));
  return level.debug_trap_room.xp[var_0];
}

restore_ai_weapon(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = createheadicon(var_0 getnoaltweapon());

  if(isDefined(level.br_pickups.br_weapontoscriptable[var_5])) {
    var_6 = level.br_pickups.br_weapontoscriptable[var_5];

    if(isDefined(var_6)) {
      var_2 = level.br_pickups.delay_hide_player_clip[var_6];
      var_3 = original_health(var_0);
      var_7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_0.basename);
      var_4 = removespecialistbonuspickup(var_7);
    }
  } else if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::vandalize_attack_max_cooldown(var_0)) {
    var_2 = restorekillstreakplayerangles(var_5);

    if(!isDefined(var_2)) {
      var_3 = original_health(var_0);
      var_7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_0.basename);
      var_4 = removespecialistbonuspickup(var_7);
      var_2 = _encstr_9112169DAC8E36EACDD1BDB5DDAC2C07B79B2716939647BC(var_3, var_4);
    }
  }

  return [var_2, var_3, var_4];
}

_encstr_9112169DAC8E36EACDD1BDB5DDAC2C07B79B2716939647BC(var_0, var_1) {
  var_2 = 0;

  if(var_0 == var_1)
    var_2 = 5;
  else if(var_0 == 0)
    var_2 = 0;
  else if(var_1 == 0)
    var_2 = 0;
  else if(var_1 > 5) {
    var_3 = [3, 5, 6, 8, 10];

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_0 <= var_3[var_4]) {
        var_2 = var_4;
        break;
      }
    }
  } else {
    var_5 = float(var_0 - 1) / float(var_1);
    var_2 = int(var_5 / 0.2);
  }

  return var_2;
}

restorekillstreakplayerangles(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");

  if(var_1.size > 1) {
    if(var_1[1] == "_encstr_820703E04B")
      return 2;
    else if(var_1[1] == "_encstr_8707037C7F")
      return 2;
  }

  return undefined;
}

original_health(var_0) {
  var_1 = scripts\cp\vehicles\vehicle_compass_cp::runleadmarkers(var_0);
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4 != "_encstr_B40101")
      var_2++;
  }

  return var_2;
}

removespecialistbonuspickup(var_0) {
  var_1 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 5, var_0, 18);

  if(isDefined(var_1) && var_1 != "_encstr_B40101")
    var_1 = int(var_1);
  else
    var_1 = 0;

  return var_1;
}

_id_13C68(var_0, var_1) {
  var_2 = self.forceextractscriptable;

  if(var_1 != 0)
    var_2 = scripts\engine\utility::ter_op(var_2 > self._id_11B72, var_2 >> var_1, var_2 << var_1);

  return var_2 % var_0;
}

_id_13C69(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0)
  var_2 = var_2 + var_4.weight;

  if(var_2 == 0)
    return undefined;

  var_6 = _id_13C68(var_2, var_1);
  var_7 = 0;

  foreach(var_4 in var_0) {
    var_7 = var_7 + var_4.weight;

    if(var_7 >= var_6)
      return var_4._id_12A7F;
  }

  return undefined;
}

run_maze_ai_common_function_stealth(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return undefined;

  var_3 = run_lbravos_safehouse(var_2, var_1);
  var_4 = var_1[var_3];
  var_5 = _id_13C69(var_4.entries, 0);
  var_5 = vehicle_collision_update(var_5, var_2);
  return scripts\engine\utility::array_removeundefined(var_5);
}

registerbrgametypefunc(var_0) {
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  return _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawning(var_1, var_0);
}

battle_tracks_onentervehicle(var_0, var_1) {
  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      if(isDefined(level.br_lootiteminfo[var_3]) && isDefined(level.br_lootiteminfo[var_3].baseweapon))
        var_0[var_0.size] = registerbrgametypefunc(level.br_lootiteminfo[var_3].baseweapon);
    }
  }

  return var_0;
}

dialog_play_shieldstow(var_0, var_1) {
  if(_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::trial_vehicle(var_0)) {
    var_2 = getdvarint("_encstr_A2802F5F88DBC7BA4508F62A0917F3990658C39F089122919D3D7EE7631D5A4CAE683717B80E7B6B93C644115EC7131E13", 2);
    var_1 = var_1 * var_2;
  }

  return var_1;
}

_id_13657(var_0, var_1, var_2) {
  var_3 = run_maze_ai_common_function_stealth(var_0, var_1, var_2);

  if(!isDefined(var_3) || var_3.size == 0)
    return var_3;

  var_3 = battle_tracks_onentervehicle(var_3, var_2);
  var_4 = spawnStruct();
  var_5 = anglesToForward((0, self.angles[1], 0));
  var_4.origin = self.origin + var_5 * 25;
  var_4.angles = (0, self.angles[1], 0);
  var_4.itemsdropped = 0;
  var_4.intro_ride = ::dialog_reachnextcheckpoint;
  var_4.intro_moveplayercliphack = ::dialog_play_shieldstow;
  var_4._id_13A77 = var_0;
  var_4.intro_heli_add_player = 60;
  var_4._encstr_8460075C1E09B347FD = self;
  var_6 = var_4 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_3, 0, undefined);
  return var_3;
}

_encstr_825711B17BBDD19B1C85BB3723AC660BAB63A3(var_0, var_1) {
  var_2 = [0, 50, -50, 25, -25, 80, -80];
  var_3 = self._id_13A77.origin - var_0;
  var_4 = max(length2d(var_3) - 15, 30);
  var_5 = vectorcross(var_3, (0, 0, 1));
  var_5 = vectorNormalize(var_5);
  var_6 = randomfloatrange(-5, 5);
  var_7 = var_2[var_1.ml_p3_to_safehouse_transition % var_2.size] + var_6;
  var_8 = var_5 * var_7;
  var_8 = var_0 + var_3 + var_8;
  return [var_8, var_6, var_4];
}

_encstr_A5B61218D8E79DE713792818B5736888CA137939(var_0, var_1) {
  var_2 = 32.5;
  var_3 = 360.0 / var_1._encstr_8D970F25851BB021B4BA7059E76F885AB9 * var_1.ml_p3_to_safehouse_transition;
  var_4 = vectorNormalize(self._id_13A77.origin - var_0);
  var_4 = var_4 * var_2;
  var_4 = var_4 + var_0;
  self._encstr_B4C709494B72BFB0E2CC11 = _encstr_996315C770436413C7ABBD338E85DB3C48E85317D0D9AD(self._encstr_8460075C1E09B347FD._encstr_B4C709494B72BFB0E2CC11, var_4);
  var_5 = undefined;

  foreach(var_7 in self._encstr_B4C709494B72BFB0E2CC11) {
    var_8 = canceljoins(undefined, undefined, var_7, var_2);

    if(isDefined(var_8) && var_8.size == 0) {
      var_9 = scripts\mp\utility\player::getplayersinradius(var_7, var_2);

      if(var_9.size == 0 || var_9.size == 1 && var_9[0] == self._id_13A77) {
        var_5 = var_7;
        break;
      }
    }
  }

  if(!isDefined(var_5))
    var_5 = self._encstr_B4C709494B72BFB0E2CC11[0];

  if(var_1._encstr_8D970F25851BB021B4BA7059E76F885AB9 > 1) {
    var_11 = randomfloatrange(-15, 15);
    var_5 = var_5 + rotatevector((-20, 0, 0), (0, var_3 + var_11, 0));
  }

  var_12 = var_5 - var_0;
  var_13 = max(length2d(var_12), 30);
  return [var_5, 0, var_13];
}

dialog_reachnextcheckpoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(getdvarint("_encstr_877A20CB5B0AD1D77A5020B8F071550AC2492F83E1CB90503F80CB97575117F39F0A", 1))
    [var_9, var_10, var_11] = _encstr_A5B61218D8E79DE713792818B5736888CA137939(var_2, var_1);
  else
    [var_9, var_10, var_11] = _encstr_825711B17BBDD19B1C85BB3723AC660BAB63A3(var_2, var_1);

  var_13 = vectortoangles(var_9 - var_2);
  var_14 = var_13[1] - var_3[1];
  var_14 = scripts\engine\utility::ter_op(var_14 > 180, var_14 - 360, var_14);
  var_14 = scripts\engine\utility::ter_op(var_14 < -180, var_14 + 360, var_14);
  var_14 = clamp(var_14, var_10 - 90, 90 + var_10);
  return _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_2, var_3, var_7, var_14, var_11);
}

_encstr_996315C770436413C7ABBD338E85DB3C48E85317D0D9AD(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = spawnStruct();
    var_5.point = var_4;
    var_5.loot_choppers = distancesquared(var_4, var_1);
    var_2[var_2.size] = var_5;
  }

  var_2 = scripts\mp\utility\script::quicksort(var_2, ::_encstr_85BF155A10B37AE713E520278BF8FB07C398B3F2A007F7);
  var_7 = [];

  foreach(var_9 in var_2)
  var_7[var_7.size] = var_9.point;

  return var_7;
}

_encstr_85BF155A10B37AE713E520278BF8FB07C398B3F2A007F7(var_0, var_1) {
  return var_0.loot_choppers <= var_1.loot_choppers;
}

_encstr_8FF20D0225F72009BEFF03478BDA95() {
  var_0 = 32.5;
  var_1 = [];
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);

  for(var_4 = -3; var_4 < 3; var_4++) {
    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = var_5 * 65 + var_0 + 30;
      var_7 = var_4 * 65 + var_0;
      var_8 = self.origin + var_6 * var_2 + var_7 * var_3;

      if(scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, 20), var_8 + (0, 0, 20))) {
        var_1[var_1.size] = var_8;
        continue;
      }
    }
  }

  self._encstr_B4C709494B72BFB0E2CC11 = var_1;
}

_encstr_93DC117656473239DE0ED9C9D2C8B9A1160E2B() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = var_0 * 225;
  var_3 = var_1 * 195;
  var_4 = self.origin - var_3;
  var_5 = var_4 + var_2;
  var_6 = self.origin + var_3;
  var_7 = var_6 + var_2;
  return [var_4, var_5, var_7, var_6];
}

_encstr_8A66165ADC4BE637D23259464EB7E09DC95A8CCDA12C83B2(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = (var_2 + 1) % var_1.size;

    if(!use_nvg_think(var_0, var_1[var_2], var_1[var_3]))
      return 0;
  }

  return 1;
}

use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

_encstr_8E0424BF6D73D0CF40C4483F43EBCB9309B0C0FBE3A6B3E7593C2298B8EFE30F3FB7C4BB5BC7() {
  var_0 = _encstr_93DC117656473239DE0ED9C9D2C8B9A1160E2B();
  var_1 = var_0[1];
  var_2 = distance(var_1, self.origin);
  var_3 = canceljoins(undefined, undefined, self.origin, var_2);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(abs(var_6.origin[2] - self.origin[2]) < 30 && _encstr_8A66165ADC4BE637D23259464EB7E09DC95A8CCDA12C83B2(var_6.origin, var_0))
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

run_lbravos_safehouse(var_0, var_1) {
  var_2 = undefined;

  foreach(var_10, var_4 in var_1) {
    foreach(var_6 in var_4._id_13A31) {
      var_7 = risktokenstokeep(var_6);
      var_8 = isint(var_7) && isint(var_0);
      var_8 = var_8 | (isstring(var_7) && isstring(var_0));

      if(var_8 && var_7 == var_0)
        var_2 = var_10;
    }
  }

  return var_2;
}

risktokenstokeep(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0, "_encstr_BA4C02DF");

  if(var_2.size == 1)
    var_1 = var_2;
  else if(var_2.size == 2)
    var_1 = int(var_2[0]);

  return var_1;
}

get_bombzone_node_to_plant_on(var_0) {
  return !level.br_pickups.delay_give_lethal_grenade[var_0] && !scripts\engine\utility::array_contains(level.debug_trap_room._id_11A20, var_0) && !scripts\engine\utility::array_contains(level.debug_trap_room.play_lighting_sequence, var_0);
}

_id_12E83(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = 1;

    if(isDefined(level.br_lootiteminfo[var_3])) {
      var_5 = weaponclass(level.br_lootiteminfo[var_3].playerstartjailsetcontrols);
      var_4 = !isDefined(var_5) || var_5 != "_encstr_8D940738966ED1DB8D";
    }

    if(var_4 && get_bombzone_node_to_plant_on(var_3))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

_id_12E84(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(get_bombzone_node_to_plant_on(var_4))
      var_1[var_4] = var_3;
  }

  return var_1;
}

play_music_on_wave_reinforce(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(level.br_pickups.delay_hide_player_clip[var_5] == var_1)
      var_2[var_5] = var_4;
  }

  return var_2;
}

_encstr_928A242D4722DDC082EAD069D46DA09B7BDF83AD9FAB2F20A1C3DAE67C2EF8C372231B018772(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(level.br_pickups.delay_hide_player_clip[var_4] == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

vehicle_collision_update(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(level.br_pickups.br_itemtype[var_4])) {
      if(getdvarint("_encstr_881A2337B139AF3193F585C9B6ED9CF2BEA3278519B227BE0B368DBDEE7DE01BD5732359C9", 1) == 0 && isstartstr(var_4, "_encstr_A7C815397A79707791E169D84DB397421B391796274859")) {
        continue;
      }
      if(get_bombzone_node_to_plant_on(var_4))
        var_2[var_2.size] = var_4;

      continue;
    }

    var_5 = strtok(var_4, "_encstr_BA4C02DF");
    var_6 = int(var_5[0]);

    if(var_5.size > 1 && isnumber(var_6)) {
      if(var_5[1] == "_encstr_AC20072B9FA9487832") {
        var_7 = _id_12E83(level.br_pickups.delay_safe_spawn_chopper_boss[var_6]);
        var_2[var_2.size] = risk_flagspawnminactivetospawn(var_7, var_1);
      } else if(var_5[1] == "_encstr_BEB406F03B72BB3B") {
        var_7 = _id_12E84(level.br_pickups.br_superreference);
        var_7 = play_music_on_wave_reinforce(var_7, var_6);
        var_2[var_2.size] = risk_flagspawnmincount(var_7, var_1);

        if(!istrue(level.debug_trap_room._encstr_B8E9189EF525DABEB9F0732758F378D2D31DA29567BBA3EA4050) && getdvarint("_encstr_8F7B214E2ED34FC18C3BD0A047A5390FCB9247595E08DDC860EF70580FEA15B112FEB2", 1))
          _encstr_BD7E1F491DA9E8F4C263272363CBBD90503512C1C21F83258B0B071587A28D4013(var_7, var_2);
      } else if(var_5[1] == "_encstr_85CE0B9770B02C73A1760F06D2") {
        var_7 = _id_12E84(level.br_pickups.br_killstreakreference);
        var_7 = _id_12C29(var_7);
        var_7 = play_music_on_wave_reinforce(var_7, var_6);
        var_2[var_2.size] = risk_flagspawnmincount(var_7, var_1);
      } else if(var_5[1] == "_encstr_9A430AA072BAFF238F51087D") {
        var_7 = _id_12E83(level.br_pickups.br_perkpoints);
        var_7 = _encstr_928A242D4722DDC082EAD069D46DA09B7BDF83AD9FAB2F20A1C3DAE67C2EF8C372231B018772(var_7, var_6);
        var_2[var_2.size] = risk_flagspawnminactivetospawn(var_7, var_1);
      }
    } else if(var_5[0] == "_encstr_B116071BCAD186858D") {
      var_7 = _id_12E83(level.br_pickups.delay_push_player_clear_door_way);
      var_2[var_2.size] = risk_flagspawnminactivetospawn(var_7, var_1);
    } else if(var_5[0] == "_encstr_99C209E34FC743616118AB") {
      var_7 = _id_12E83(level.br_pickups.deletesoundents);
      var_2[var_2.size] = risk_flagspawnminactivetospawn(var_7, var_1);
    } else {}
  }

  return var_2;
}

_encstr_BD7E1F491DA9E8F4C263272363CBBD90503512C1C21F83258B0B071587A28D4013(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4 == "_encstr_A935120E5D9AA97D0177A390E88D93C7CC08C0F7" || var_4 == "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768") {
      var_2 = "_encstr_930852BD0AA17856DF92137AB9930E200775E5B18396C8B70FEAABE1369FEF789BD8438D17FAA8E77B5242AE5A3B70186637C133D3644AAE435ADBB042731CF09DF8158B74CBB8762F83D198EE6FE3D8E7505591" + level.debug_trap_room.play_lighting_sequence.size + "_encstr_8D0A0A0480802D8E56DA1D10" + var_4;
      break;
    }
  }

  var_6 = var_1[var_1.size - 1];

  if(var_6 == "_encstr_A935120E5D9AA97D0177A390E88D93C7CC08C0F7" || var_6 == "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768") {
    if(!isDefined(var_2))
      var_2 = "_encstr_B40101";

    var_2 = var_2 + ("_encstr_A1521D69F60289C75B3757757F519528A9CF49BB0E71B02F22CF6D4B0BBAF7" + var_6 + "_encstr_B6F812A61871C417989FFBE8C0C3D34F95026BFE");
  }

  if(isDefined(var_2)) {
    level.debug_trap_room._encstr_B8E9189EF525DABEB9F0732758F378D2D31DA29567BBA3EA4050 = 1;
    _encstr_8A8D10B9DF125DF8116FD1CB17F1C095EA03();
    scripts\mp\utility\script::laststand_dogtags(var_2);
  }
}

_id_12C29(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(var_4 != "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537")
      var_1[var_4] = var_3;
  }

  return var_1;
}

risk_flagspawnminactivetospawn(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && var_0.size > 0) {
    var_3 = _id_13C68(var_0.size, var_1);
    var_2 = var_0[var_3];
  }

  return var_2;
}

risk_flagspawnmincount(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && var_0.size > 0) {
    var_3 = _id_13C68(var_0.size, var_1);
    var_4 = 0;

    foreach(var_7, var_6 in var_0) {
      if(var_4 == var_3) {
        var_2 = var_7;
        break;
      }

      var_4++;
    }
  }

  return var_2;
}

_id_121E6(var_0) {
  if(var_0 == 4)
    scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_9222073ADDD7B159CE");
}