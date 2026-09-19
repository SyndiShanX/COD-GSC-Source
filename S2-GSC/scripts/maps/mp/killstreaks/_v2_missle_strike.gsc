/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_v2_missle_strike.gsc
*************************************************************/

_id_52F5() {}

_id_9303(var_0, var_1, var_2, var_3, var_4) {
  self notify("used");

  if(!common_scripts\utility::_id_562E(var_3)) {
    thread _id_6B57(var_2);
    wait(_id_46DF(var_2));
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];
    var_6 = (var_6[0], var_6[1], 0);

    if(isDefined(var_4))
      thread _id_3216(var_0, var_6, undefined, var_4, var_2, var_4);
    else
      thread _id_3216(var_0, var_6, self, self.pers["team"], var_2);

    wait(_id_46E0(var_2));
  }
}

_id_3216(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2))
    var_2 endon("disconnect");

  if(!isDefined(var_1)) {
    return;
  }
  var_7 = maps\mp\_utility::_id_579B() && isDefined(var_5);
  var_8 = getEntArray("mp_artillery", "classname");

  if(var_7) {
    var_9 = "";

    if(var_5 == game["attackers"])
      var_9 = "allies";
    else if(var_5 == game["defenders"])
      var_9 = "axis";

    for(var_10 = 0; var_10 < var_8.size; var_10++) {
      if(var_8[var_10]._id_0165 != var_9) {
        var_8[var_10] = var_8[var_8.size - 1];
        var_8[var_8.size - 1] = undefined;
        var_10--;
      }
    }
  }

  var_11 = 99999999;
  var_12 = level._id_5FEB + (10000, 10000, 1000);

  foreach(var_14 in var_8) {
    var_15 = _func_0E1(var_14.origin, var_1);

    if(var_15 < var_11) {
      var_12 = var_14.origin;
      var_11 = var_15;
    }
  }

  var_17 = 1;

  if(maps\mp\_utility::_id_579B() && isDefined(var_5) && isDefined(level._id_79C2._id_80B0) && common_scripts\utility::_id_562E(level._id_79C2._id_80B0._id_4D10))
    var_17 = 0;

  var_18 = undefined;
  var_19 = undefined;

  if(var_17) {
    var_18 = _func_190("script_model", var_1);
    var_19 = _func_190("script_model", var_1);
    thread _id_8C0B(var_4, var_2, var_18, var_19, var_5);

    if(isDefined(var_2))
      var_2 thread _id_624C(var_18, var_19);
  }

  _id_0526::_id_280E(var_1, 0, var_4, var_3);
  thread _id_0526::_id_5FCB(var_1, var_4);
  var_20 = 0;

  if(isDefined(var_2))
    var_20 = var_2 maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  var_21 = _id_45C0(var_4, var_7, var_20);
  var_22 = [];

  for(var_10 = 0; var_10 < var_21; var_10++) {
    if(var_20) {
      var_22[var_10] = 0.75;
      continue;
    }

    var_22[var_10] = 0.8;
  }

  for(var_10 = 0; var_10 < var_21; var_10++) {
    var_23 = _func_0A3(0.7);
    var_22[var_10] = var_22[var_10] - var_23;
    var_24 = randomint(var_21);
    var_22[var_24] = var_22[var_24] + var_23;
  }

  for(var_10 = 0; var_10 < var_21; var_10++) {
    var_25 = _id_458A(var_4);
    var_26 = _id_458A(var_4);
    var_27 = _id_3B99(var_1[0] + var_25, var_1[1] + var_26);
    var_28 = var_12;

    if(isDefined(var_6))
      var_29 = var_6;
    else
      var_29 = _id_458D(var_4, var_3);

    var_30 = 2.5;

    if(var_20 && var_4 == "mortar_strike")
      var_30 = 1.5;

    var_31 = _func_1B6(var_29, var_28, var_27, var_30, _id_4578(), var_2, getdiveheightformap());

    if(isDefined(var_5))
      var_31.team = var_3;

    if(isDefined(var_6) && var_6 == "mortar_strike_projectile_d_day_mp")
      var_31 _id_0378::_id_8D74("aud_beach_mortar");
    else
      var_31 thread _id_4A1F(var_4);

    if(var_10 + 1 >= var_21)
      var_31 thread _id_7EBD(var_4, var_18, var_19);

    if(isDefined(var_2))
      var_31 thread _id_624F(var_2);

    wait(var_22[var_10]);
  }

  if(isDefined(var_2))
    var_2 notify("missileStrikeComplete");
}

_id_4A1F(var_0) {
  level endon("game_ended");
  self endon("death");
  _id_0378::_id_8D74("ks_projectile_fired", var_0);
  var_1 = 2.2;

  if(var_1 > 0)
    wait(var_1);

  _id_0378::_id_8D74("ks_incoming_projectile", var_0);
}

_id_3B99(var_0, var_1) {
  var_2 = (var_0, var_1, _id_4578());
  var_3 = var_2 + (0, 0, -10000);
  var_4 = bulletTrace(var_2, var_3, 0);

  for(var_5 = var_4["entity"]; isDefined(var_5) && isDefined(var_5._id_01C8); var_5 = var_4["entity"]) {
    var_2 = var_4["position"];
    var_4 = bulletTrace(var_2, var_3, 0, var_5);
  }

  return var_4["position"];
}

_id_8C0B(var_0, var_1, var_2, var_3, var_4) {
  wait 0.35;
  var_5 = _id_458D(var_0);
  var_6 = _id_458B(var_0);
  var_7 = 1;
  var_8 = 0;
  var_9 = 100;
  var_10 = 1;
  var_11 = 0;
  var_12 = 1;
  var_13 = var_1;

  if(isDefined(var_4))
    var_13 = var_4;

  if(isDefined(var_2)) {
    var_14 = _func_1FE(var_5);
    var_15 = (var_14 + var_6) * 2;
    var_2 _meth_8351(var_13, _id_458C(var_0, 0, !var_7), var_15, var_15, var_12, var_11, "", _id_458C(var_0, 1, !var_7));
    var_2 _meth_8352(100, var_10);
  }

  if(isDefined(var_3)) {
    var_16 = _func_1FF(var_5, var_8, var_9);
    var_17 = (var_16 + var_6) * 2;
    var_3 _meth_8351(var_13, _id_458C(var_0, 0, var_7), var_17, var_17, var_12, var_11, "", _id_458C(var_0, 1, var_7));
    var_3 _meth_8352(100, var_10);
  }
}

_id_624C(var_0, var_1) {
  self endon("missileStrikeComplete");
  self waittill("disconnect");
  _id_238B(var_0, var_1);
}

_id_624F(var_0) {
  self endon("death");
  var_0 endon("missileStrikeComplete");
  var_0 waittill("disconnect");
  self notify("killstreakOwnerDisconnect");
  self delete();
}

_id_238B(var_0, var_1) {
  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();
}

_id_7EBD(var_0, var_1, var_2) {
  self endon("killstreakOwnerDisconnect");
  self waittill("death");

  switch (var_0) {
    case "v2_rocket":
    default:
      break;
  }

  if(isDefined(var_1))
    var_1 _meth_8352(80, 0);

  if(isDefined(var_2))
    var_2 _meth_8352(80, 0);

  wait 0.08;
  _id_238B(var_1, var_2);
}

_id_6B57(var_0) {
  switch (var_0) {
    case "missile_strike":
    case "mortar_strike":
      break;
  }
}

_id_458D(var_0, var_1) {
  switch (var_0) {
    case "missile_strike":
      if(isDefined(var_1) && var_1 == "allies")
        return "missile_strike_projectile_mp";
      else
        return "missile_strike_projectile_axis_mp";
    case "mortar_strike":
      if(isDefined(var_1) && var_1 == "allies")
        return "mortar_strike_projectile_mp";
      else
        return "mortar_strike_projectile_axis_mp";
    case "v2_rocket":
      return "v2_rocket_mp";
  }
}

_id_458A(var_0) {
  switch (var_0) {
    case "missile_strike":
      return _func_0A5(-250, 250);
    case "mortar_strike":
      return 0;
    case "v2_rocket":
      return _func_0A5(-100, 100);
  }
}

_id_458B(var_0) {
  switch (var_0) {
    case "missile_strike":
      return 250;
    case "mortar_strike":
      return 0;
    case "v2_rocket":
      return 100;
  }
}

_id_458C(var_0, var_1, var_2) {
  switch (var_0) {
    case "missile_strike":
      if(var_1) {
        if(var_2)
          return "scorestreak_minimap_artillery_barrage_kill_fullscreen";
        else
          return "scorestreak_minimap_artillery_barrage_damage_fullscreen";
      } else if(var_2)
        return "scorestreak_minimap_artillery_barrage_kill";
      else
        return "scorestreak_minimap_artillery_barrage_damage";
    case "mortar_strike":
      if(var_1) {
        if(var_2)
          return "scorestreak_minimap_mortar_strike_kill_fullscreen";
        else
          return "scorestreak_minimap_mortar_strike_damage_fullscreen";
      } else if(var_2)
        return "scorestreak_minimap_mortar_strike_kill";
      else
        return "scorestreak_minimap_mortar_strike_damage";
    case "v2_rocket":
      return "";
  }
}

_id_46DF(var_0) {
  switch (var_0) {
    case "missile_strike":
      return 0;
    case "mortar_strike":
      return 0;
    case "v2_rocket":
      return 5;
  }
}

_id_46E0(var_0) {
  switch (var_0) {
    case "missile_strike":
      return 1.0;
    case "mortar_strike":
      return _func_0A5(0.2, 1.0);
    case "v2_rocket":
      return 0.0;
  }
}

_id_45C0(var_0, var_1, var_2) {
  if(!var_1 && isDefined(var_2) && var_2) {
    switch (var_0) {
      case "missile_strike":
        return 23;
      case "mortar_strike":
        return 1;
      case "v2_rocket":
        return 1;
    }
  } else {
    switch (var_0) {
      case "missile_strike":
        if(var_1 && isDefined(level._id_79C2._id_80B0) && isDefined(level._id_79C2._id_80B0._id_624A))
          return int(_func_0D6(18 * level._id_79C2._id_80B0._id_624A));
        else
          return 18;
      case "mortar_strike":
        return 1;
      case "v2_rocket":
        return 1;
    }
  }
}

_id_4578() {
  switch (maps\mp\_utility::_id_4571()) {
    case "mp_aachen_v2":
      return 3400;
    case "mp_airship":
      return 3500;
    case "mp_battleship_2":
      return 6400;
    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      return 3650;
    case "mp_canon_farm":
      return 3200;
    case "mp_d_day":
      return 3750;
    case "mp_flak_tower":
      return 5000;
    case "mp_forest_01":
      return 4650;
    case "mp_france_village":
      return 3200;
    case "mp_gibraltar_02":
      return 2000;
    case "mp_scorestreak_training":
      return 1600;
    case "mp_london":
      return 3400;
    case "mp_paris_s2":
      return 3300;
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
      return 3850;
    case "mp_prague":
      return 3500;
    case "mp_market_garden":
      return 3600;
    case "mp_monte_cassino_v2":
      return 3500;
    case "mp_stalingrad":
      return 3650;
    case "mp_sandbox":
      return 2000;
    default:
      return 3200;
  }
}

getdiveheightformap() {
  switch (maps\mp\_utility::_id_4571()) {
    case "mp_egypt_02":
    case "mp_canon_farm":
      return 1000;
    case "mp_stalingrad":
    case "mp_dunkirk":
    case "mp_carentan_s2":
    case "mp_sandbox_01":
    case "mp_d_day":
    case "mp_carentan_s2_winter":
    case "mp_gibraltar_02":
      return 1500;
    case "mp_aachen_v2":
    case "mp_monte_cassino_v2":
    case "mp_market_garden":
    case "mp_v2_rocket_02":
    case "mp_london":
    case "mp_flak_tower":
    case "mp_airship":
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
    case "mp_france_village":
    case "mp_forest_01":
      return 2000;
    case "mp_prague":
    case "mp_paris_s2":
      return 2500;
    case "mp_battleship_2":
      return 3000;
    case "mp_scorestreak_training":
    default:
      return undefined;
  }
}

_id_9E39(var_0, var_1) {
  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  var_2 = _id_83BB(var_0, var_1);

  if(!isDefined(var_2) || !var_2)
    return 0;

  _id_0485::_id_5E9A(var_1, self.origin);
  return 1;
}

_id_83BB(var_0, var_1) {
  self endon("stop_location_selection");
  var_2 = 0;
  var_3 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  var_4 = _id_45C1(var_1, var_3);
  self _meth_82FF("ui_map_location_num_targets", var_4);
  maps\mp\_utility::_id_05D4(var_1, "map_artillery_selector", var_2, _id_46C2(var_1), 0.5);
  thread _id_A6AB();
  var_5 = [];

  for(var_6 = 0; var_6 < var_4; var_6++) {
    self waittill("confirm_location", var_7, var_8);
    _id_0380::_id_6844("mp_ks_target_select_circle_target", self, self);

    switch (var_1) {
      case "mortar_strike":
        self _meth_85EF(&"confirmed_target_location_mortar_strike", 3, var_6, int(var_7[0]), int(var_7[1]));
        self notify("single_location_selection_complete");
        break;
      case "v2_rocket":
      case "missile_strike":
        break;
    }

    var_5[var_6] = var_7;
  }

  _id_0380::_id_6844("mstrike_entry_npc", maps\mp\_utility::getotherteam(self.team), self);
  _id_0380::_id_6845("mstrike_entry_npc", self.team, self, self);
  self _meth_82DD(0, 0.3);
  self notify("location_selection_complete");
  self _meth_82FF("ui_map_location_num_targets", 0);
  thread _id_9303(var_0, var_5, var_1);
  return 1;
}

_id_A6AB() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self _meth_82DD(0, 0.3);
  self _meth_82FF("ui_map_location_num_targets", 0);

  if(maps\mp\gametypes\_hostmigration::_id_A782() > 0)
    self switchtoweapon(common_scripts\utility::_id_4550());
}

_id_46C2(var_0) {
  if(!isDefined(level._id_5FF0))
    level._id_5FF0 = 1024;

  var_1 = 0;

  switch (var_0) {
    case "missile_strike":
      var_1 = 1054;
      break;
    case "mortar_strike":
      var_1 = 550;
      break;
    case "v2_rocket":
      var_1 = 2000;
      break;
  }

  if(level.splitscreen)
    var_1 = var_1 * 1.5;

  return var_1;
}

_id_45C1(var_0, var_1) {
  if(isDefined(var_1) && var_1) {
    switch (var_0) {
      case "missile_strike":
        return 1;
      case "mortar_strike":
        return 4;
      case "v2_rocket":
        return 1;
    }
  } else {
    switch (var_0) {
      case "missile_strike":
        return 1;
      case "mortar_strike":
        return 3;
      case "v2_rocket":
        return 1;
    }
  }
}