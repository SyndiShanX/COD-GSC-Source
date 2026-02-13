/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1802.gsc
*************************************************/

_id_9A65() {
  scripts\engine\utility::_id_5C24("introscreen_over");

  if(!isDefined(anim._id_341F)) {
    anim.player = getEntArray("player", "classname")[0];

    while(!isDefined(anim.player)) {
      anim.player = getEntArray("player", "classname")[0];
      wait 5;
    }
  }

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  level._id_0B65 = spawnStruct();
  level._id_0B65._id_5D7D = _id_070B::_id_5674;
  level._id_0B65._id_5D7E = _id_070B::_id_5677;
  level._id_0B65._id_5D55 = _id_070B::_id_1151;
  level._id_0B65._id_5D7C = _id_070B::_id_566C;
  level._id_0B65._id_5DB0 = ::_id_B367;
  scripts\anim\shared::_id_80C0();
  _id_7EFF();
  _id_0751::_id_8069();
  anim thread _id_2457();
  scripts\cp\utility::_id_236C("axis");
}

_id_7EFF() {
  if(isDefined(anim._id_341F) && anim._id_341F) {
    return;
  }
  scripts\engine\utility::_id_5097("#x3c23f48a9e29249ee", 1);

  if(getdvarint("#x3c23f48a9e29249ee") == 0) {
    anim._id_341F = 0;
    anim.player._id_341F = 0;
    return;
  }

  anim._id_2440 = 0;
  anim._id_341F = 1;
  anim.player._id_341F = 0;

  if(!isDefined(level._id_5FAD)) {
    level._id_5FAD = 1;
  }

  scripts\engine\utility::_id_5097("#x38f523271ea48d7e7", "off");
  scripts\engine\utility::_id_5097("#x3875c7cd2ad9c8b1a", "off");
  scripts\engine\utility::_id_5097("#x3af56cb02c76b94c9", "off");
  scripts\engine\utility::_id_5097("#x33694f11bb7c77584", "off");
  scripts\engine\utility::_id_5097("#x398e914761d90dac4", "off");
  scripts\engine\utility::_id_5097("#x3c3931a3a23adba0f", "all");
  scripts\engine\utility::_id_5097("#x36f852bff91c62d60", "off");
  scripts\engine\utility::_id_5097("#x32e69219b614d0b6c", "off");
  scripts\engine\utility::_id_5097("#x32e2728fffabcab9", "off");
  scripts\engine\utility::_id_5097("#x375255821ff37f0cb", "");
  scripts\engine\utility::_id_5097("#x39b61afe16196c67b", "");
  scripts\engine\utility::_id_5097("#x33f916ec54e649462", "off");
  scripts\engine\utility::_id_5097("#x33baee9158c4d4a9e", "off");
  scripts\engine\utility::_id_5097("#x352e907d4be0ad0f8", "off");
  scripts\engine\utility::_id_5097("#x33ba40ca4c8cdc6b0", "csv");
  scripts\engine\utility::_id_5097("#x327fb6f536402b531", "off");
  anim._id_243D = "^1***** BCS FAILURE: ";
  anim._id_243E = "^3***** BCS WARNING: ";
  _id_2451();
  _id_244E();
  anim._id_B725["unitednations"] = "1";
  anim._id_B725["unitednationshelmet"] = "1";
  anim._id_B725["unitednationsfemale"] = "1";
  anim._id_B725["unitedstates"] = "1";
  anim._id_B725["unitedstatesfemale"] = "1";
  anim._id_B725["alqatala"] = "1";
  anim._id_B725["alqatalafemale"] = "1";
  anim._id_B725["russian"] = "1";
  anim._id_B725["sas"] = "1";
  anim._id_B725["sasfemale"] = "1";
  anim._id_B725["fsa"] = "1";
  anim._id_B725["fsafemale"] = "1";
  thread _id_D658();
  _id_7F84();
  anim._id_56C9 = [];
  anim._id_56C9["threat"] = [];
  anim._id_56C9["response"] = [];
  anim._id_56C9["reaction"] = [];
  anim._id_56C9["order"] = [];
  anim._id_56C9["inform"] = [];
  anim._id_56C9["custom"] = [];
  anim._id_56C9["direction"] = [];
  anim._id_56C9["stealth"] = [];

  if(isDefined(level._id_0D88)) {
    anim._id_56B2["threat"]["self"] = 20000;
    anim._id_56B2["threat"]["squad"] = 30000;
  } else {
    anim._id_56B2["threat"]["self"] = 9000;
    anim._id_56B2["threat"]["squad"] = 5000;
  }

  anim._id_56B2["threat"]["location_repeat"] = 15000;
  anim._id_56B2["response"]["self"] = 1400;
  anim._id_56B2["response"]["squad"] = 1400;
  anim._id_56B2["reaction"]["self"] = 1400;
  anim._id_56B2["reaction"]["squad"] = 1400;
  anim._id_56B2["order"]["self"] = 7000;
  anim._id_56B2["order"]["squad"] = 6000;
  anim._id_56B2["inform"]["self"] = 4000;
  anim._id_56B2["inform"]["squad"] = 6000;
  anim._id_56B2["custom"]["self"] = 0;
  anim._id_56B2["custom"]["squad"] = 0;
  anim._id_56B2["stealth"]["self"] = 9000;
  anim._id_56B2["stealth"]["squad"] = 5000;
  anim._id_56B2["stealth"]["location_repeat"] = 45000;
  anim._id_56C9["playername"] = 50000;
  anim._id_56C9["reaction"]["casualty"] = 14000;
  anim._id_56C9["reaction"]["friendlyfire"] = 5000;
  anim._id_56C9["reaction"]["takingfire"] = 5000;
  anim._id_56C9["reaction"]["maneuver"] = 4000;
  anim._id_56C9["reaction"]["movement"] = 4000;
  anim._id_56C9["reaction"]["underfire"] = 4000;
  anim._id_56C9["reaction"]["danger"] = 4000;
  anim._id_56C9["reaction"]["ask_ok"] = 4000;
  anim._id_56C9["reaction"]["taunt"] = 5000;
  anim._id_56C9["inform"]["reloading"] = 5000;
  anim._id_56C9["inform"]["killfirm"] = 4000;
  anim._id_56C9["inform"]["attack"] = 5000;
  anim._id_56C9["threat"]["acquired"] = 7000;
  anim._id_56C9["threat"]["sighted"] = 7000;
  anim._id_56C9["reaction"]["maneuver"] = 5000;
  anim._id_56C9["reaction"]["underfire"] = 2000;
  anim._id_56C9["order"]["action"] = 5000;
  anim._id_56C9["response"]["callout"] = 7000;
  anim._id_56C9["response"]["location"] = 7000;
  anim._id_56C9["stealth"]["idle"] = 27500;
  anim._id_56C9["stealth"]["idle_alert"] = 25000;
  anim._id_56C9["stealth"]["investigate"] = 12000;
  anim._id_56C9["stealth"]["hunt"] = 500;
  anim._id_56C9["stealth"]["combat"] = 15000;
  anim._id_56C9["stealth"]["announce1"] = 500;
  anim._id_56C9["stealth"]["announce2"] = 3000;
  anim._id_56C9["stealth"]["announce3"] = 3000;
  anim._id_56C9["stealth"]["announce4"] = 3000;
  anim._id_56C9["stealth"]["announce5"] = 3000;
  anim._id_56BA["threat"]["infantry"] = 0.6;
  anim._id_56BA["threat"]["vehicle"] = 0.7;
  anim._id_56BA["threat"]["sighted"] = 0.6;
  anim._id_56BA["threat"]["acquired"] = 0.6;
  anim._id_56BA["response"]["ack"] = 0.9;
  anim._id_56BA["response"]["exposed"] = 0.8;
  anim._id_56BA["response"]["callout"] = 0.9;
  anim._id_56BA["response"]["location"] = 0.9;
  anim._id_56BA["response"]["echo"] = 0.9;
  anim._id_56BA["response"]["covering"] = 0.9;
  anim._id_56BA["response"]["im"] = 0.9;
  anim._id_56BA["reaction"]["casualty"] = 0.5;
  anim._id_56BA["reaction"]["friendlyfire"] = 1.0;
  anim._id_56BA["reaction"]["takingfire"] = 1.0;
  anim._id_56BA["reaction"]["maneuver"] = 0.8;
  anim._id_56BA["reaction"]["movement"] = 0.8;
  anim._id_56BA["reaction"]["underfire"] = 0.8;
  anim._id_56BA["reaction"]["danger"] = 0.8;
  anim._id_56BA["reaction"]["ask_ok"] = 1.0;
  anim._id_56BA["reaction"]["taunt"] = 0.9;
  anim._id_56BA["order"]["action"] = 0.3;
  anim._id_56BA["order"]["move"] = 0.3;
  anim._id_56BA["order"]["displace"] = 0.5;
  anim._id_56BA["inform"]["attack"] = 0.9;
  anim._id_56BA["inform"]["incoming"] = 0.9;
  anim._id_56BA["inform"]["reloading"] = 0.2;
  anim._id_56BA["inform"]["suppressed"] = 0.2;
  anim._id_56BA["inform"]["killfirm"] = 0.4;
  anim._id_56BA["custom"]["generic"] = 1.0;
  anim._id_56BA["stealth"]["idle"] = 0.6;
  anim._id_56BA["stealth"]["idle_alert"] = 0.6;
  anim._id_56BA["stealth"]["investigate"] = 0.6;
  anim._id_56BA["stealth"]["hunt"] = 0.9999;
  anim._id_56BA["stealth"]["combat"] = 0.6;
  anim._id_56BA["stealth"]["announce1"] = 0.999999;
  anim._id_56BA["stealth"]["announce2"] = 0.99999;
  anim._id_56BA["stealth"]["announce3"] = 0.9999;
  anim._id_56BA["stealth"]["announce4"] = 0.999;
  anim._id_56BA["stealth"]["announce5"] = 0.99;
  anim._id_56B6["threat"]["infantry"] = 10000;
  anim._id_56B6["threat"]["vehicle"] = 10000;
  anim._id_56B6["threat"]["sighted"] = 15000;
  anim._id_56B6["threat"]["acquired"] = 15000;
  anim._id_56B6["response"]["exposed"] = 10000;
  anim._id_56B6["response"]["callout"] = 20000;
  anim._id_56B6["response"]["location"] = 20000;
  anim._id_56B6["response"]["echo"] = 20000;
  anim._id_56B6["response"]["ack"] = 10000;
  anim._id_56B6["response"]["covering"] = 15000;
  anim._id_56B6["response"]["im"] = 15000;
  anim._id_56B6["reaction"]["casualty"] = 10000;
  anim._id_56B6["reaction"]["friendlyfire"] = 10000;
  anim._id_56B6["reaction"]["takingfire"] = 15000;
  anim._id_56B6["reaction"]["maneuver"] = 15000;
  anim._id_56B6["reaction"]["movement"] = 15000;
  anim._id_56B6["reaction"]["underfire"] = 15000;
  anim._id_56B6["reaction"]["danger"] = 15000;
  anim._id_56B6["reaction"]["ask_ok"] = 15000;
  anim._id_56B6["reaction"]["taunt"] = 20000;
  anim._id_56B6["order"]["action"] = 30000;
  anim._id_56B6["order"]["move"] = 30000;
  anim._id_56B6["order"]["displace"] = 30000;
  anim._id_56B6["inform"]["attack"] = 10000;
  anim._id_56B6["inform"]["incoming"] = 15000;
  anim._id_56B6["inform"]["reloading"] = 10000;
  anim._id_56B6["inform"]["suppressed"] = 20000;
  anim._id_56B6["inform"]["killfirm"] = 20000;
  anim._id_56B6["custom"]["generic"] = 10000;
  anim._id_56B6["stealth"]["idle"] = 5000;
  anim._id_56B6["stealth"]["idle_alert"] = 5000;
  anim._id_56B6["stealth"]["investigate"] = 15000;
  anim._id_56B6["stealth"]["hunt"] = 15000;
  anim._id_56B6["stealth"]["combat"] = 15000;
  anim._id_56B6["stealth"]["announce1"] = 15000;
  anim._id_56B6["stealth"]["announce2"] = 15000;
  anim._id_56B6["stealth"]["announce3"] = 15000;
  anim._id_56B6["stealth"]["announce4"] = 15000;
  anim._id_56B6["stealth"]["announce5"] = 15000;
  anim._id_56B4["response"]["exposed"] = 85;
  anim._id_56B4["response"]["reload"] = 80;
  anim._id_56B4["response"]["location"] = 75;
  anim._id_56B4["response"]["callout"] = 75;
  anim._id_56B4["response"]["callout_negative"] = 60;
  anim._id_56B4["response"]["order"] = 80;
  anim._id_56B4["moveEvent"]["coverme"] = 70;
  anim._id_56B4["moveEvent"]["ordertoplayer"] = 50;
  anim._id_59EE = 620;
  anim._id_59F4 = 12;
  anim._id_59F3 = 24;
  anim._id_59F2 = 2;
  anim._id_59F1 = 5;
  anim._id_A243 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level._id_2449)) {
    level._id_2449 = _func_0219(3000);
  }

  if(!isDefined(level._id_244A)) {
    level._id_244A = _func_0219(5000);
  }

  if(!isDefined(level._id_2448)) {
    level._id_2448 = _func_0219(1500);
  }

  level._id_7666 = 96.0;
  level._id_9EB7 = 10.0;
  level._id_9C66 = 45.0;

  if(!isDefined(anim._id_2447)) {
    _id_06C9::_id_2446();
  }

  anim._id_CF6F = 4000;
  anim._id_2454 = 3000;
  anim._id_E48C[anim._id_E48C.size] = ::_id_80BF;
  anim._id_E48D[anim._id_E48D.size] = "::init_squadBattleChatter";

  foreach(var_1 in anim._id_EFA0) {
    anim._id_8A97[var_1] = 0;
    anim._id_8A96[var_1]["threat"] = 0;
    anim._id_8A96[var_1]["order"] = 0;
    anim._id_8A96[var_1]["reaction"] = 0;
    anim._id_8A96[var_1]["response"] = 0;
    anim._id_8A96[var_1]["inform"] = 0;
    anim._id_8A96[var_1]["custom"] = 0;
    anim._id_8A96[var_1]["stealth"] = 0;
  }

  _id_244D();
  _id_244F();
  anim._id_90A1 = [];
  anim._id_901C = [];
  anim._id_901D = [];

  foreach(var_1 in anim._id_EFA0) {
    anim._id_90A1[var_1] = -50000;
    anim._id_901C[var_1] = "none";
    anim._id_901D[var_1] = -100000;
  }

  anim._id_901E = 120000;

  for(var_5 = 0; var_5 < anim._id_E496.size; var_5++) {
    if(isDefined(anim._id_E496[var_5]._id_341F) && anim._id_E496[var_5]._id_341F) {
      continue;
    }
    anim._id_E496[var_5] _id_80BF();
  }

  anim._id_F160 = [];
  anim._id_F160["exposed"] = 25;
  anim._id_F160["sighted"] = 25;
  anim._id_F160["acquired"] = 50;
  anim._id_F160["player_distance"] = 20;
  anim._id_F160["player_obvious"] = 25;
  anim._id_F160["player_contact_clock"] = 25;
  anim._id_F160["player_target_clock"] = 25;
  anim._id_F160["player_target_clock_high"] = 25;
  anim._id_F160["player_cardinal"] = 20;
  anim._id_F160["ai_distance"] = 25;
  anim._id_F160["ai_obvious"] = 25;
  anim._id_F160["ai_contact_clock"] = 20;
  anim._id_F160["ai_casual_clock"] = 20;
  anim._id_F160["ai_target_clock"] = 20;
  anim._id_F160["ai_target_clock_high"] = 25;
  anim._id_F160["ai_cardinal"] = 10;
  anim._id_F160["concat_location"] = 90;
  anim._id_F160["player_location"] = 90;
  anim._id_F160["ai_location"] = 100;
  anim._id_F160["generic_location"] = 95;
  anim._id_90A4 = [];
  anim._id_90A5 = [];

  foreach(var_1 in anim._id_EFA0) {
    anim._id_90A4[var_1] = undefined;
    anim._id_90A5[var_1] = undefined;
  }

  anim._id_EFB4 = 120000;
  level notify("battlechatter initialized");
  anim notify("battlechatter initialized");
}

_id_7F84() {
  anim._id_5CDD["unitednations"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["unitednations"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["unitednationshelmet"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["unitednationshelmet"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["unitednationsfemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["unitednationsfemale"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["unitedstates"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["unitedstates"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["unitedstatesfemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["unitedstatesfemale"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["sas"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["sas"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["sasfemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["sasfemale"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["fsa"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["fsa"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CDD["fsafemale"] = [];
  var_0 = 41;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    anim._id_5CDD["fsafemale"][var_1] = ::scripts\engine\utility::_id_EA52(var_1 + 1);
  }

  anim._id_5CE0 = [];
}

_id_80BF() {
  var_0 = self;
  var_0._id_A798 = 0;
  var_0._id_9CA3 = 1;
  var_0._id_A4D0 = gettime() + 50;
  var_0._id_A4D1["threat"] = gettime() + 50;
  var_0._id_A4D1["order"] = gettime() + 50;
  var_0._id_A4D1["reaction"] = gettime() + 50;
  var_0._id_A4D1["response"] = gettime() + 50;
  var_0._id_A4D1["inform"] = gettime() + 50;
  var_0._id_A4D1["custom"] = gettime() + 50;
  var_0._id_A4D1["stealth"] = gettime() + 50;
  var_0._id_A4E4["threat"] = [];
  var_0._id_A4E4["order"] = [];
  var_0._id_A4E4["reaction"] = [];
  var_0._id_A4E4["response"] = [];
  var_0._id_A4E4["inform"] = [];
  var_0._id_A4E4["custom"] = [];
  var_0._id_A4E4["stealth"] = [];
  var_0._id_892D["threat"] = 0;
  var_0._id_892D["order"] = 0;
  var_0._id_892D["reaction"] = 0;
  var_0._id_892D["response"] = 0;
  var_0._id_892D["inform"] = 0;
  var_0._id_892D["custom"] = 0;
  var_0._id_892D["stealth"] = 0;
  var_0._id_8FBC = "";
  var_0._id_9DAF[var_0._id_9DAF.size] = _id_070B::_id_1174;
  var_0._id_9DB3[var_0._id_9DB3.size] = _id_070B::_id_C4BA;
  var_0._id_E4B3[var_0._id_E4B3.size] = ::_id_816A;
  var_0._id_59EF = 1;
  var_0._id_59F0 = undefined;

  for(var_1 = 0; var_1 < anim._id_E496.size; var_1++) {
    var_0 thread _id_816A(anim._id_E496[var_1]._id_E4A3);
  }

  var_0 thread _id_070B::_id_E4B1();
  var_0 thread _id_E493();
  var_0._id_341F = 1;
  var_0 notify("squad chat initialized");
}

_id_8603() {
  var_0 = _id_6335();

  foreach(var_2 in var_0) {
    if(!_id_96D2(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_54ED(var_0) {
  return scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0.origin, 0);
}

_id_816A(var_0) {
  if(!isDefined(self._id_E49D[var_0]._id_2F62)) {
    self._id_E49D[var_0]._id_2F62 = 0;
  }

  if(!isDefined(self._id_E49D[var_0]._id_5BCA)) {
    self._id_E49D[var_0]._id_5BCA = 2000000000;
  }

  if(!isDefined(self._id_E49D[var_0]._id_8FB2)) {
    self._id_E49D[var_0]._id_8FB2 = 0;
  }
}

_id_D658(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    anim.player._id_2439 = var_0;
    anim.player._id_2426 = var_1;
    return;
  }

  while(!isDefined(level._id_30AB)) {
    wait 0.1;
  }

  var_2 = level._id_30AB;
  var_3 = anim._id_B725[var_2];
  var_4 = anim._id_3DAA[var_2];

  if(isDefined(var_3)) {
    anim.player._id_2439 = var_3;
  }

  if(isDefined(var_4)) {
    anim.player._id_2426 = var_4;
  }
}

_id_E493() {
  anim endon("battlechatter disabled");
  self endon("squad_deleting");

  if(self._id_E4A3 != "jackal_allies") {
    return;
  }
  while(self._id_9DB1 <= 0) {
    wait 0.5;
  }

  wait 0.5;
  var_0 = 0;

  while(isDefined(self)) {
    if(!_id_E48A(self)) {
      var_0 = 1;
      wait 1;
      continue;
    } else if(self._id_59EF) {
      if(!var_0) {
        wait(randomfloat(anim._id_59F4));
      }

      if(var_0) {
        var_0 = 0;
      }

      self._id_59EF = 0;
    } else {
      if(!var_0) {
        wait(randomfloatrange(anim._id_59F4, anim._id_59F3));
      }

      if(var_0) {
        var_0 = 0;
      }
    }

    var_1 = _id_6939(self);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = var_1._id_10691;
    var_3 = _id_6A4B(self, var_2);
    var_4 = _id_6A4A(var_2, var_3);

    foreach(var_8, var_6 in var_4) {
      if(!var_1 _id_3175() || distance(anim.player.origin, var_1.origin) > anim._id_59EE && !isDefined(var_1._id_2442)) {
        for(var_7 = 0; var_7 < self._id_9DB5.size; var_7++) {
          var_1 = _id_6939(self);

          if(!isDefined(var_1)) {
            continue;
          }
          if(var_1._id_10691 == var_2) {
            break;
          }
        }

        if(!isDefined(var_1) || var_1._id_10691 != var_2) {
          break;
        }
      }

      thread _id_B83A(var_1, var_6);
      self waittill("burst_line_done");

      if(var_8 != var_4.size - 1) {
        wait(randomfloatrange(anim._id_59F2, anim._id_59F1));
      }
    }
  }
}

_id_6939(var_0) {
  var_1 = undefined;
  var_2 = scripts\engine\utility::_id_636A(anim.player.origin, var_0._id_9DB5);

  foreach(var_4 in var_2) {
    if(var_4 _id_3175()) {
      var_1 = var_4;

      if(!isDefined(var_0._id_59F0)) {
        break;
      }

      if(isDefined(var_0._id_59F0) && var_0._id_59F0 == var_1._id_F94F) {
        continue;
      }
    }
  }

  if(isDefined(var_1)) {
    var_0._id_59F0 = var_1._id_F94F;
  }

  return var_1;
}

_id_6A4B(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize(anim._id_5CDD[var_1]);

  if(anim._id_5CE0.size >= var_2.size) {
    anim._id_5CE0 = [];
  }

  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_3 = var_5;

    if(!_id_5CE2(var_3)) {
      break;
    }
  }

  anim._id_5CE0[anim._id_5CE0.size] = var_3;
  return var_3;
}

_id_5CE2(var_0) {
  if(!anim._id_5CE0.size) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in anim._id_5CE0) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_6A4A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_2;
  var_4 = [];

  for(;;) {
    var_5 = var_3;
    var_6 = "FB_" + anim._id_3DAA[var_0] + "_" + var_1 + "_" + var_5;
    var_3++;

    if(_func_0205(var_6)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    break;
  }

  return var_4;
}

_id_10693() {
  if(isDefined(anim._id_5CE1) && isDefined(anim._id_5CE1[self._id_10691]) && anim._id_5CE1[self._id_10691]) {
    return 1;
  }

  return 0;
}

_id_3175() {
  var_0 = 0;

  if(self != anim.player && isalive(self) && level._id_5CDD[self.team] && _id_10693() && isDefined(self._id_5CDD) && self._id_5CDD) {
    var_0 = 1;
  }

  return var_0;
}

_id_E48A(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_9DB5) {
    if(var_3 == anim.player) {
      continue;
    }
    if(!isDefined(var_3.team)) {
      return var_1;
    }

    if(var_3 _id_3175()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_5CDC(var_0, var_1) {
  self endon("burst_line_done");

  for(;;) {
    wait 0.05;
  }
}

_id_B83A(var_0, var_1) {
  anim endon("battlechatter disabled");
  var_2 = undefined;
  var_2 = spawn("script_origin", var_0 gettagorigin("j_head"));
  var_2 linkto(var_0);

  if(_id_235D()) {
    _id_2370([var_1]);
  }

  var_2 playSound(var_1);
  wait(_func_0142(var_1) / 1000);
  var_2 delete();

  if(isDefined(self)) {
    self notify("burst_line_done");
  }
}

_id_3FAB(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = self;
  var_3._id_56C8 = var_1;
  var_3._id_56B1 = var_0;

  if(isDefined(var_2)) {
    var_3._id_BD27 = var_2;
  } else {
    var_3._id_BD27 = anim._id_56BA[var_0][var_1];
  }

  var_3._id_57AC = gettime() + anim._id_56B6[var_0][var_1];
  return var_3;
}

_id_8A4D(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  wait 25;
  _id_3949(var_0);
}

_id_96ED(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  var_3 = var_0._id_E478;
  var_4 = var_0.team;
  var_0._id_2359._id_8A4B = 1;
  var_0 thread _id_8A4D(var_1);
  var_3._id_892D[var_1] = 1;
  var_3._id_A798++;
  anim._id_8A97[var_4] = 1;
  anim._id_8A96[var_4][var_1] = 1;
  var_5 = var_0 scripts\engine\utility::_id_10898("death", "done speaking", "cancel speaking");
  var_3._id_892D[var_1] = 0;
  var_3._id_A798--;
  anim._id_8A97[var_4] = 0;
  anim._id_8A96[var_4][var_1] = 0;

  if(var_5 == "cancel speaking") {
    return;
  }
  anim._id_90A1[var_4] = gettime();

  if(isalive(var_0)) {
    var_0 _id_3949(var_1);
  }

  var_3._id_A4D1[var_1] = gettime() + anim._id_56B2[var_1]["squad"];
}

_id_3949(var_0) {
  self._id_2359._id_8A4B = 0;
  self._id_2359._id_3420[var_0]._id_57AC = 0;
  self._id_2359._id_3420[var_0]._id_BD27 = 0.0;
  self._id_2359._id_A4D1[var_0] = gettime() + anim._id_56B2[var_0]["self"];
}

_id_B8F9() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self._id_2359._id_3420["stealth"]._id_56C8)) {
    iprintln("ChatQueue is undefined.What's going on?");
    return;
  }

  self._id_413B = self._id_2359._id_3420["stealth"];
  var_0 = self._id_2359._id_3420["stealth"]._id_02D0;
  anim thread _id_96ED(self, "stealth");

  switch (self._id_2359._id_3420["stealth"]._id_56C8) {
    case "idle":
      _id_E7FE(var_0);
      break;
    case "idle_alert":
      _id_E7FF(var_0);
      break;
    case "investigate":
      _id_E802(var_0);
      break;
    case "hunt":
      _id_E7FD(var_0);
      break;
    case "combat":
      break;
    case "announce5":
    case "announce4":
    case "announce3":
    case "announce2":
    case "announce1":
      _id_E7F1(var_0);
      break;
  }

  self notify("done speaking");
}

_id_E802(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_113B("investigate", var_0);
  var_3 = var_1 _id_B8B7(var_2, self);

  if(_id_E7F5(var_3)) {
    return;
  }
  if(var_3 && (isDefined(var_2._id_2F64) || isDefined(var_2._id_FB30))) {
    if(isDefined(var_2._id_C6CF[0]) && randomint(4)) {
      var_1 childthread _id_E7F3(var_2._id_C6CF[0]);
    }
  } else {}
}

_id_E7FD(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_113B("hunt", var_0);
  var_3 = var_1 _id_B8B7(var_2, self);

  if(_id_E7F5(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2._id_C6CF[0])) {
    if(randomint(4)) {
      var_1 childthread _id_E7F3(var_2._id_C6CF[0]);
    }
  } else {}
}

_id_E7F1(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_113B("announce", var_0);
  var_3 = var_1 _id_B8B7(var_2, self);

  if(var_3 && isDefined(var_2._id_C6CF[0])) {
    if(randomint(4)) {
      var_1 childthread _id_E7F3(var_2._id_C6CF[0]);
    }
  }
}

_id_E7F5(var_0) {
  if(isDefined(self._id_2359._id_4265) && self._id_2359._id_4265 == "") {
    self._id_2359._id_4265 = undefined;
    return 1;
  } else if(var_0 && isDefined(self._id_2359._id_4265)) {
    childthread _id_E7F4(self._id_2359._id_4265);
    self._id_2359._id_4265 = undefined;
    return 1;
  }

  return 0;
}

_id_E7F4(var_0) {
  wait(randomfloatrange(0.3, 0.4));

  if(_id_89D4(var_0)) {
    thread _id_B8C0(var_0, undefined, 1);
    thread _id_B8BF(var_0);
  } else {
    thread _id_B8C0(var_0, 1);
    var_1 = spawn("script_origin", self gettagorigin("j_head"));
    var_1 linkto(self);

    if(_id_235D()) {
      _id_2370([var_0 + " cusBC"]);
    }

    if(_func_0205(var_0)) {
      var_1 playSound(var_0);
      wait(_func_0142(var_0) / 1000);
    } else
      _id_2376("Tried to play an alias that doesn't exist: '" + var_0 + "'.");

    var_1 delete();
  }
}

_id_8859(var_0) {
  if(getDvar(_func_0483("#x38cb3b14f44eeeb57", var_0), "off") == "on" || getDvar(_func_0483("#x38cb3b14f44eeeb57", var_0), "off") == "1") {
    return 1;
  }

  switch (var_0) {
    case "threat":
      if(istrue(self._id_2359._id_5A58)) {
        return 1;
      }

      break;
    case "inform":
      if(istrue(self._id_2359._id_5A4C)) {
        return 1;
      }

      break;
    case "order":
      if(istrue(self._id_2359._id_5A4E)) {
        return 1;
      }

      break;
    case "reaction":
      if(istrue(self._id_2359._id_5A51)) {
        return 1;
      }

      break;
    case "response":
      if(istrue(self._id_2359._id_5A52)) {
        return 1;
      }

      break;
    case "stealth":
      if(istrue(self._id_2359._id_5A55)) {
        return 1;
      }

      break;
  }

  return 0;
}

_id_235E() {
  return 0;
}

_id_B8B7(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var_3 = 0;

  if(isDefined(var_2)) {
    return var_3;
  }

  if(_id_235D() || _id_235E()) {
    if(_id_8859(var_1._id_413B._id_56B1)) {
      if(_id_235D()) {
        _id_2370([var_1._id_413B._id_56B1 + " is filtered"]);
      }
    } else {
      var_4 = [];

      for(var_5 = 0; var_5 < var_0._id_E05F.size; var_5++) {
        var_6 = "";

        if(isDefined(var_0._id_E062[var_5])) {
          var_6 = " " + var_0._id_E062[var_5];
        }

        var_4[var_5] = var_0._id_E05F[var_5] + var_6;
      }

      if(_id_235D()) {
        _id_2370(var_4);
      }

      if(_id_235E()) {
        var_7 = self._id_413B._id_56B1 + "_" + self._id_413B._id_56C8;

        if(isDefined(self._id_413B._id_02D0)) {
          var_7 = var_7 + ("_" + self._id_413B._id_02D0);
        }

        thread _id_2371(var_4, var_7);
      }
    }
  }

  for(var_5 = 0; var_5 < var_0._id_E05F.size; var_5++) {
    if(!self._id_237D) {
      if(!_id_85DC(self._id_413B)) {
        continue;
      } else if(!_id_30EE(0)) {
        continue;
      }
    }

    if(!isDefined(self._id_0B37) && self != anim.player || isDefined(self._id_0B37) && self._id_0B37 > 0) {
      continue;
    }
    if(_id_8859(var_1._id_413B._id_56B1)) {
      wait 0.85;
      continue;
    }

    if(!_func_0205(var_0._id_E05F[var_5])) {
      _id_2376("Tried to play an alias that doesn't exist: '" + var_0._id_E05F[var_5] + "'.");
      continue;
    }

    var_8 = gettime();

    if(self == anim.player) {
      var_9 = spawn("script_origin", anim.player getEye());
      var_9 linkto(self);
    } else if(_id_89D4(var_0._id_E05F[var_5])) {
      var_9 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
      var_9 linkto(var_1);
    } else {
      var_9 = spawn("script_origin", self gettagorigin("j_head"));
      var_9 linkto(var_1);
    }

    thread _id_E8E3(var_0._id_E05F[var_5], var_9);
    _id_D171(var_0._id_E05F[var_5]);

    if(var_0._id_9BA1 && self.team == "allies") {
      if(isDefined(self.classname) && self.classname == "player") {
        self notify(var_0._id_E05F[var_5] + "_started");
        var_3 = 1;
        var_9 playSound(var_0._id_E05F[var_5]);
      } else {
        self notify(var_0._id_E05F[var_5] + "_started");
        var_3 = 1;
        var_9 playSound(var_0._id_E05F[var_5]);
      }

      wait(_func_0142(var_0._id_E05F[var_5]) / 1000);
      self notify(var_0._id_E05F[var_5]);
    } else {
      if(isDefined(self.classname) && self.classname == "player") {
        self notify(var_0._id_E05F[var_5] + "_started");
        var_3 = 1;
        var_9 playSound(var_0._id_E05F[var_5]);
      } else {
        self notify(var_0._id_E05F[var_5] + "_started");
        var_3 = 1;
        var_9 playSound(var_0._id_E05F[var_5]);
      }

      wait(_func_0142(var_0._id_E05F[var_5]) / 1000);
      self notify(var_0._id_E05F[var_5]);
    }

    var_9 delete();

    if(gettime() < var_8 + 250) {}
  }

  self notify("playPhrase_done");

  if(self != anim.player) {
    self._id_0B67._id_237C = undefined;
    self._id_0B67._id_235B = undefined;
  }

  var_1 _id_4E8D(var_1._id_413B._id_56B1, var_1._id_413B._id_56C8);
  return var_3;
}

_id_2371(var_0, var_1) {}

_id_689F(var_0) {
  if(_func_00D6(var_0, 0, 6) == "dx_vom") {
    var_1 = _func_00D6(var_0, 7, var_0.size);
  } else {
    if(self == anim.player) {
      var_2 = self._id_2359._id_3DA9 + "_";
    } else if(_func_00D6(var_0, 0, 6) == "dx_sbc") {
      var_2 = _id_2421("stealth");
    } else {
      var_2 = _id_2421();
    }

    var_1 = _func_00D6(var_0, var_2.size, var_0.size);
  }

  return var_1;
}

_id_2372(var_0, var_1, var_2) {
  if(scripts\engine\utility::_id_5C00(var_2)) {
    scripts\engine\utility::_id_5C24(var_2);
  }

  scripts\engine\utility::_id_5C1B(var_2);
  scripts\engine\utility::_id_5C04(var_2);
}

_id_85DC(var_0) {
  if(!isDefined(var_0._id_56B1) || !isDefined(var_0._id_56C8)) {
    return 0;
  }

  if(var_0._id_56B1 == "reaction" && var_0._id_56C8 == "friendlyfire") {
    return 1;
  }

  return 0;
}

_id_E8E3(var_0, var_1) {
  var_1 endon("death");
  self waittill("death");

  if(isDefined(var_1)) {
    var_1 _meth_83F8();
    waitframe();

    if(isDefined(var_1)) {
      var_1 notify(var_0);
      var_1 delete();
    }
  }
}

_id_D171(var_0) {
  var_1 = strtok(var_0, "_");

  if(!isDefined(self._id_0B67)) {
    return;
  }
  if(scripts\engine\utility::array_contains(var_1, "killfirm") || scripts\engine\utility::array_contains(var_1, "coverme") || scripts\engine\utility::array_contains(var_1, "suppress")) {
    self._id_0B67._id_235B = "action";
  } else if(scripts\engine\utility::array_contains(var_1, "attack") && !scripts\engine\utility::array_contains(var_1, "grenade")) {
    self._id_0B67._id_235B = "attacking_action";
  } else if(scripts\engine\utility::array_contains(var_1, "grenade") || scripts\engine\utility::array_contains(var_1, "inform") && !scripts\engine\utility::array_contains(var_1, "taking")) {
    self._id_0B67._id_235B = "defending_action";
  } else if(scripts\engine\utility::array_contains(var_1, "order")) {
    self._id_0B67._id_235B = "order_action";
  } else if(scripts\engine\utility::array_contains(var_1, "location") || scripts\engine\utility::array_contains(var_1, "contact") || scripts\engine\utility::array_contains(var_1, "target") || scripts\engine\utility::array_contains(var_1, "exposed") && !scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._id_0B67._id_235B = "threat_infantry";
  } else if(scripts\engine\utility::array_contains(var_1, "taking")) {
    self._id_0B67._id_235B = "takingfire";
  } else if(scripts\engine\utility::array_contains(var_1, "response") || scripts\engine\utility::array_contains(var_1, "affirm") || scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._id_0B67._id_235B = "response";
  }
}

_id_69B6(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = _id_2421("custom");
  var_6 = _id_2421("custom radio");
  var_7 = var_5;
  var_8 = getarraykeys(level._id_237E[var_0]);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(!isDefined(level._id_237E[var_0]["curEvent"]) || !scripts\engine\utility::array_contains(var_8, level._id_237E[var_0]["curEvent"]) || var_8[var_9] != level._id_237E[var_0]["curEvent"]) {
      continue;
    }
    if(_func_0107(level._id_237E[var_0][var_8[var_9]])) {
      for(var_10 = 0; var_10 < level._id_237E[var_0][var_8[var_9]].size; var_10++) {
        if(_func_0107(level._id_237E[var_0][var_8[var_9]][var_10])) {
          for(var_11 = 0; var_11 < level._id_237E[var_0][var_8[var_9]][var_10].size; var_11++) {
            if(_id_89D4(level._id_237E[var_0][var_8[var_9]][var_10][var_11])) {
              var_7 = var_6 + _id_69B7(level._id_237E[var_0][var_8[var_9]][var_10][var_11]);
            } else {
              var_7 = var_5;
            }

            if(!isDefined(var_1)) {
              var_1 = var_7 + level._id_237E[var_0][var_8[var_9]][var_10][var_11];
              var_3 = var_11;
              continue;
            }

            var_4 = 1;
            var_2 = var_7 + level._id_237E[var_0][var_8[var_9]][var_10][var_11];
          }

          if(isDefined(var_2)) {
            _id_383F(var_8[var_9], var_0, var_10, var_3, 0);
            _id_383F(var_8[var_9], var_0, var_10, var_3);
          } else
            _id_383F(var_8[var_9], var_0, var_10, var_3);

          break;
        } else {
          var_7 = scripts\engine\utility::ter_op(_id_89D4(level._id_237E[var_0][var_8[var_9]][var_10]), var_6, var_5);
          var_1 = var_7 + level._id_237E[var_0][var_8[var_9]][var_10];
          _id_383F(var_8[var_9], var_0, var_10, var_3);
          break;
        }
      }

      break;
    } else {
      var_7 = scripts\engine\utility::ter_op(_id_89D4(level._id_237E[var_0][var_8[var_9]]), var_6, var_5);
      var_1 = var_7 + level._id_237E[var_0][var_8[var_9]];
      break;
    }
  }

  if(isDefined(var_4)) {
    return [var_1, var_2];
  } else {
    return var_1;
  }
}

_id_69B7(var_0) {
  return _id_89D4(var_0, 1);
}

_id_383F(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(istrue(level._id_237E[var_1][var_0]["looping"])) {
    if(var_4) {
      level._id_237E[var_1][var_0] = _id_4267(level._id_237E[var_1][var_0]);
    }
  } else {
    level._id_237E[var_1][var_0][var_2] = ::scripts\engine\utility::array_remove_index(level._id_237E[var_1][var_0][var_2], var_3);

    if(level._id_237E[var_1][var_0][var_2].size < 1) {
      level._id_237E[var_1][var_0] = ::scripts\engine\utility::array_remove_index(level._id_237E[var_1][var_0], var_2);
    }
  }

  if(level._id_237E[var_1][var_0].size < 1) {
    level._id_237E[var_1] = ::scripts\engine\utility::_id_1BC6(level._id_237E[var_1], var_0);
  }
}

_id_4267(var_0) {
  if(!isDefined(var_0["count"])) {
    var_0["count"] = 1;
  }

  var_1 = [];
  var_2 = [];
  var_3 = getarraykeys(var_0);

  foreach(var_5 in var_3) {
    if(_func_02B7(var_5)) {
      if(var_5 != 0) {
        var_1[var_5 - 1] = var_0[var_5];
      }

      continue;
    }

    var_2[var_5] = var_0[var_5];
  }

  var_1[var_1.size] = var_0[0];

  if(var_0["count"] == var_1.size) {
    for(var_1 = scripts\engine\utility::array_randomize(var_1); var_1[0][0] == var_0[0][0]; var_1 = scripts\engine\utility::array_randomize(var_1)) {}

    var_0["count"] = 1;
  } else
    var_0["count"] = var_0["count"] + 1;

  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3) {
    var_1[var_5] = var_2[var_5];
  }

  var_1["count"] = var_0["count"];
  return var_1;
}

_id_10A1(var_0) {
  var_1 = _id_69B6(var_0);
  self._id_2359._id_4265 = "";

  if(_func_0107(var_1)) {
    self._id_2359._id_4265 = var_1[1];
    var_1 = var_1[0];
  }

  if(_id_89D4(var_1)) {
    thread _id_B8C0(var_1);
  } else {
    var_2 = "";
    var_3 = strtok(var_1, "_");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_4 == var_3.size - 1) {
        var_2 = var_2 + "r_" + var_3[var_4];
        continue;
      }

      var_2 = var_2 + var_3[var_4] + "_";
    }

    if(_func_0205(var_2)) {
      thread _id_B8C0(var_1, undefined, undefined, var_2);
    } else {
      _id_2376("Can't find radio alias '" + var_2 + "'.This may be intentional if talking to himself.");
    }
  }

  return var_1;
}

_id_FE38(var_0) {
  if(!isDefined(level._id_237E) || !isDefined(level._id_237E[var_0])) {
    return 0;
  } else {
    var_1 = getarraykeys(level._id_237E[var_0]);

    if(var_1.size > 0 && isDefined(level._id_237E[var_0]["curEvent"]) && scripts\engine\utility::array_contains(var_1, level._id_237E[var_0]["curEvent"])) {
      return 1;
    } else {
      return 0;
    }
  }
}

_id_113B(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(self.owner == anim.player) {} else {
    switch (var_0) {
      case "idle_alert":
      case "idle":
        self.owner._id_2359._id_8520 = 0;

        if(_id_FE38(var_0)) {
          var_2 = self.owner _id_10A1(var_0);
        } else if(scripts\engine\utility::cointoss()) {
          if(self.owner _id_FE8B("checkin")) {
            var_4 = self.owner _id_6D8D("checkin");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + self.owner _id_6908() + "_checkin";
            var_2 = self.owner _id_4009(var_6, var_5);
            var_3[0] = var_6 + "_resp_" + var_5;
            var_3[1] = self.owner _id_4009(var_6 + "_resp", var_5);
          }

          self._id_351D = 1;
          self.owner thread _id_B8C0(var_2);
        } else {
          if(self.owner _id_FE8B("callin")) {
            var_4 = self.owner _id_6D8D("callin");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + self.owner _id_6908() + "_callin_";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
          }

          self._id_2F64 = 1;
          self.owner thread _id_B8C0(var_2, 1);
        }

        break;
      case "investigate":
        if(_id_FE38(var_0)) {
          var_2 = self.owner _id_10A1(var_0);
        } else if(!istrue(self.owner._id_2359._id_8520)) {
          if(self.owner _id_FE8B("callin")) {
            var_4 = self.owner _id_6D8D("callin");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + self.owner _id_6908() + "_callin_";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
          }

          self.owner._id_2359._id_8520 = 1;
          self._id_2F64 = 1;
        } else {
          if(self.owner _id_FE8B("update")) {
            var_4 = self.owner _id_6D8D("update");
            var_2 = var_4[0];
            var_3 = scripts\engine\utility::array_remove_index(var_4, 0);
          } else {
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + self.owner _id_6908() + "_update_";
            var_2 = var_6 + var_5;
            var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
          }

          self._id_FB30 = 1;
        }

        self.owner thread _id_B8C0(var_2, 1);
        break;
      case "hunt":
        self.owner._id_2359._id_8520 = 0;

        if(_id_FE38(var_0)) {
          var_2 = self.owner _id_10A1(var_0);
        } else {
          switch (var_1) {
            case "teaminquiry":
              var_2 = self.owner _id_2421("stealth") + "team_inquiry_" + _id_BFFD(1);
              self.owner thread _id_B8C0(var_2, 1);
              break;
            case "first_lost":
              var_5 = _id_BFFD(1);
              var_6 = self.owner _id_2421("stealth") + "hunt_firstlost_";
              var_2 = var_6 + var_5;
              self.owner thread _id_B8C0(var_2, 1);
              var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
              break;
            case "lost_sight":
              var_5 = _id_BFFD(1);
              var_6 = self.owner _id_2421("stealth") + "lost_sight_";
              var_2 = var_6 + var_5;
              self.owner thread _id_B8C0(var_2, 1);
              var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
              break;
            default:
          }
        }

        break;
      case "combat":
        break;
      case "announce":
        switch (var_1) {
          case "investigate":
            var_2 = self.owner _id_2421("stealth") + "investigate_generic_" + _id_BFFD(1);
            break;
          case "coverblown":
            var_2 = self.owner _id_2421("stealth") + "coverblown_generic_" + _id_BFFD(1);
            break;
          case "combat":
            var_2 = self.owner _id_2421("stealth") + "combat_generic_" + _id_BFFD(1);
            break;
          case "ally_killed":
            var_2 = self.owner _id_2421("stealth") + "ally_killed_" + _id_BFFD(1);
            break;
          case "damage":
            var_2 = self.owner _id_2421("stealth") + "damage_generic_" + _id_BFFD(1);
            break;
          case "drone_spotted":
            var_2 = self.owner _id_2421("stealth") + "drone_spotted_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "explosion":
            var_2 = self.owner _id_2421("stealth") + "explosion_generic_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "footstep_walk":
          case "footstep":
            var_2 = self.owner _id_2421("stealth") + "footstep_generic_" + _id_BFFD(1);
            break;
          case "footstep_sprint":
            var_2 = self.owner _id_2421("stealth") + "footstep_sprint_" + _id_BFFD(1);
            break;
          case "found_corpse":
            var_2 = self.owner _id_2421("stealth") + "found_corpse_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "glass_destroyed":
            var_2 = self.owner _id_2421("stealth") + "glass_destroyed_" + _id_BFFD(1);
            break;
          case "grenade_danger":
            var_2 = self.owner _id_2421("stealth") + "grenade_danger_" + _id_BFFD(1);
            break;
          case "gunshot":
            var_2 = self.owner _id_2421("stealth") + "gunshot_generic_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "gunshot_teammate":
            var_2 = self.owner _id_2421("stealth") + "gunshot_teammate_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "alertreset":
            var_2 = self.owner _id_2421("stealth") + "alert_reset_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "teaminquiry":
            var_2 = self.owner _id_2421("stealth") + "team_inquiry_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "light_killed":
            var_2 = self.owner _id_2421("stealth") + "light_killed_" + _id_BFFD(1);
            break;
          case "first_lost":
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + "hunt_firstlost_";
            var_2 = var_6 + var_5;
            self.owner thread _id_B8C0(var_2, 1);
            var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
            break;
          case "lost_sight":
            var_5 = _id_BFFD(1);
            var_6 = self.owner _id_2421("stealth") + "lost_sight_";
            var_2 = var_6 + var_5;
            self.owner thread _id_B8C0(var_2, 1);
            var_3[0] = self.owner _id_4009(var_6 + "resp", var_5);
            break;
          case "proximity":
            var_2 = self.owner _id_2421("stealth") + "proximity_generic_" + _id_BFFD(1);
            break;
          case "saw_corpse":
            var_2 = self.owner _id_2421("stealth") + "saw_corpse_" + _id_BFFD(1);
            break;
          case "seek_backup":
            var_2 = self.owner _id_2421("stealth") + "seek_backup_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "sight":
            var_2 = self.owner _id_2421("stealth") + "sight_generic_" + _id_BFFD(1);
            break;
          case "unresponsive_teammate":
            var_2 = self.owner _id_2421("stealth") + "unresponsive_teammate_" + _id_BFFD(1);
            self.owner thread _id_B8C0(var_2, 1);
            break;
          case "bulletwhizby":
            var_2 = self.owner _id_2421("stealth") + "bulletwhizby_generic_" + _id_BFFD(1);
          case "silenced_shot":
            var_2 = self.owner _id_2421("stealth") + "silenced_shot_" + _id_BFFD(1);
            break;
          case "window_open":
            var_2 = self.owner _id_2421("stealth") + "window_open_" + _id_BFFD(1);
            break;
        }

        break;
    }
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  self._id_E062[self._id_E05F.size] = var_0;

  if(isDefined(var_1)) {
    self._id_E062[self._id_E05F.size] = var_0 + " " + var_1;
  }

  self._id_E05F[self._id_E05F.size] = var_2;

  if(isDefined(var_3)) {
    self._id_C6CF = var_3;
  }

  return 1;
}

_id_6D8D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_1 = _id_6E2F(self, "stealth", var_0);
  _id_96D0(var_1);

  switch (var_0) {
    case "callin":
    case "update":
      var_2 = _id_BFFD(1);
      var_3 = _id_6B1E(_id_6908() + "_location_" + var_0 + "_" + var_1._id_96D6[0] + "_");
      var_4[0] = var_3 + var_2;
      var_4[1] = _id_4009(var_3 + "resp", var_2);
      return var_4;
    case "checkin":
      var_2 = _id_BFFD(1);
      var_3 = _id_6B1E(_id_6908() + "_location_" + var_0 + "_" + var_1._id_96D6[0] + "_");
      var_4[0] = _id_4009(var_3, var_2);
      var_4[1] = var_3 + "resp_" + var_2;
      var_4[2] = _id_4009(var_3 + "resp", var_2);
      return var_4;
  }
}

_id_3FAC() {
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0._id_E062 = [];
  var_0._id_E05F = [];
  var_0._id_C6CF = [];
  var_0._id_9BA1 = 0;
  return var_0;
}

_id_E7FE(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");

  if(isDefined(self._id_2359._id_E800) && self._id_2359._id_E800 > gettime()) {
    return;
  }
  var_2 = var_1 _id_3FAC();
  var_2 _id_113B("idle", var_0);
  var_3 = var_1 _id_B8B7(var_2, self);

  if(_id_E7F5(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2._id_351D) && var_1 _id_6908() == "idle") {
    foreach(var_5 in var_2._id_C6CF) {
      var_2._id_E05F = [];
      var_2._id_E05F[0] = var_5;

      if(_id_89D4(var_5)) {
        var_3 = var_1 _id_E7F3(var_2._id_E05F[0]);
      } else {
        var_1 _id_3AD9();
        var_1 childthread _id_B8C0(var_2._id_E05F[0], 1, 1);
        var_3 = var_1 _id_B8B7(var_2, self);
      }

      if(!var_3 || var_1 _id_6908() != "idle") {
        break;
      }
    }
  } else if(var_3 && isDefined(var_2._id_2F64)) {
    if(isDefined(var_2._id_C6CF[0]) && randomint(3)) {
      var_1 childthread _id_E7F3(var_2._id_C6CF[0]);
    }
  } else if(var_3 && randomint(3)) {
    var_7 = ["dx_bcs_rul_contsweep_1", "dx_bcs_rul_contsweep_2", "dx_bcs_rul_contsweep_3", "dx_bcs_rul_contsweep_n_1", "dx_bcs_rul_contsweep_s_1", "dx_bcs_rul_contsweep_e_1", "dx_bcs_rul_contsweep_w_1"];

    if(issubstr(var_2._id_E05F[0], "_n_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_n_1");
    } else if(issubstr(var_2._id_E05F[0], "_s_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_s_1");
    } else if(issubstr(var_2._id_E05F[0], "_e_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_e_1");
    } else if(issubstr(var_2._id_E05F[0], "_w_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_w_1");
    }

    var_1 childthread _id_E7F3(scripts\engine\utility::random(var_7));
  } else {}
}

_id_89D4(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(_func_00D6(var_0, var_0.size - 2, var_0.size) == "_r") {
    return 1;
  }

  if(issubstr(var_0, "_r_")) {
    return 1;
  }

  if(issubstr(var_0, "_aql1r_")) {
    return scripts\engine\utility::ter_op(var_1, "_aql1_", 1);
  }

  if(issubstr(var_0, "_aql2r_")) {
    return scripts\engine\utility::ter_op(var_1, "_aql2_", 1);
  }

  if(issubstr(var_0, "_rul1r_")) {
    return scripts\engine\utility::ter_op(var_1, "_rul1_", 1);
  }

  if(issubstr(var_0, "_rul2r_")) {
    return scripts\engine\utility::ter_op(var_1, "_rul2_", 1);
  }

  return 0;
}

_id_B8C0(var_0, var_1, var_2, var_3) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");

  if(getDvar("#x39b61afe16196c67b") == self.team || getDvar("#x39b61afe16196c67b") == "all") {
    return;
  }
  if(isDefined(self._id_2359._id_426E)) {
    var_4 = self._id_2359._id_426E;
    self._id_2359._id_426E = undefined;
  } else
    var_4 = anim._id_E4A8[self.team]._id_9DB5;

  var_4 = scripts\engine\utility::array_remove(var_4, self);

  foreach(var_6 in var_4) {
    if(isDefined(var_6._id_04B9) && var_6._id_04B9 == "dog") {
      var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    }
  }

  var_4 = scripts\engine\utility::_id_1BD1(var_4);

  if(var_4.size == 0) {
    return;
  }
  var_8 = scripts\cp\utility::_id_686B(level.players[0].origin, var_4, _func_0218(level._id_2448));

  foreach(var_6 in var_8) {
    var_6 thread _id_0C95(var_0, var_1, self, var_2, var_3);
  }
}

_id_FE8B(var_0) {
  var_1 = _id_6E2F(self, "stealth", var_0);

  if(isDefined(var_1)) {
    return 1;
  }

  return 0;
}

_id_0C95(var_0, var_1, var_2, var_3, var_4) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var_2 endon("death");

  if(!istrue(var_3)) {
    var_5 = var_0 + "_started";
    var_6 = var_2 scripts\engine\utility::_id_108F7(var_5, 2);

    if(var_6 == var_5) {
      return;
    }
  }

  wait 0.15;

  if(isDefined(var_4)) {
    var_0 = var_4;
  } else if(isDefined(var_1)) {
    var_7 = strtok(var_0, "_");
    var_0 = "";

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_8 == var_7.size - 1) {
        var_0 = var_0 + "r_" + var_7[var_8];
        continue;
      }

      var_0 = var_0 + var_7[var_8] + "_";
    }
  }

  thread _id_B8BF(var_0);
}

_id_E7FF(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_113B("idle_alert", var_0);
  var_3 = var_1 _id_B8B7(var_2, self);

  if(_id_E7F5(var_3)) {
    return;
  }
  if(var_3 && isDefined(var_2._id_351D) && var_1 _id_6908() == "alert") {
    foreach(var_5 in var_2._id_C6CF) {
      var_2._id_E05F = [];
      var_2._id_E05F[0] = var_5;

      if(_id_89D4(var_5)) {
        var_3 = var_1 _id_E7F3(var_2._id_E05F[0]);
      } else {
        var_1 _id_3AD9();
        var_1 childthread _id_B8C0(var_2._id_E05F[0], 1, 1);
        var_3 = var_1 _id_B8B7(var_2, self);
      }

      if(!var_3 || var_1 _id_6908() != "alert") {
        break;
      }
    }
  } else if(var_3 && isDefined(var_2._id_2F64)) {
    if(isDefined(var_2._id_C6CF[0]) && randomint(4)) {
      var_1 childthread _id_E7F3(var_2._id_C6CF[0]);
    }
  } else {}
}

_id_E7F3(var_0) {
  if(getDvar("#x375255821ff37f0cb") == self.team || getDvar("#x375255821ff37f0cb") == "all") {
    return 0;
  }

  _id_3AD9();
  childthread _id_B8C0(var_0, undefined, 1);
  _id_B8BF(var_0);
  return 1;
}

_id_B8BF(var_0) {
  if(self == anim.player) {
    var_1 = spawn("script_origin", anim.player getEye());
    var_1 linkto(self);
  } else {
    var_1 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
    var_1 linkto(self);
  }

  if(_id_235D()) {
    _id_2370([var_0 + " radio"]);
  }

  if(_func_0205(var_0)) {
    var_1 playSound(var_0);
    wait(_func_0142(var_0) / 1000);
  } else
    _id_2376("Tried to play an alias that doesn't exist: '" + var_0 + "'.");

  var_1 delete();
}

_id_2451() {
  if(!isDefined(anim._id_EFA0)) {
    anim._id_EFA0 = [];
    anim._id_EFA0[anim._id_EFA0.size] = "axis";
    anim._id_EFA0[anim._id_EFA0.size] = "allies";
    anim._id_EFA0[anim._id_EFA0.size] = "team3";
    anim._id_EFA0[anim._id_EFA0.size] = "neutral";
  }
}

_id_244E() {
  if(!isDefined(anim._id_FE49)) {
    anim._id_FE49 = [];
    anim._id_5CE1 = [];
    anim._id_3DAA = [];
    _id_2452("unitednations", "UN", 6, 1);
    _id_2452("unitednationshelmet", "UN", 6, 1);
    _id_2452("unitednationsfemale", "UN", 3, 1);
    _id_2452("setdef", "SD", 5);
    _id_2452("unitedstates", "USM", 3, 1);
    _id_2452("unitedstatesfemale", "USMF", 1, 1);
    _id_2452("sas", "USM", 3, 1);
    _id_2452("sasfemale", "USMF", 1, 1);
    _id_2452("fsa", "FSA", 3, 1);
    _id_2452("fsafemale", "FSAF", 1, 1);

    switch (getDvar("#x32e69219b614d0b6c")) {
      case "all":
      case "axis":
        _id_2452("alqatala", "USM", 3);
        _id_2452("alqatalafemale", "USMF", 1);
        _id_2452("russian", "USM", 3);
        break;
      default:
        _id_2452("alqatala", "AQ", 3);
        _id_2452("alqatalafemale", "AQF", 1);
        _id_2452("russian", "RU", 3);
        break;
    }
  }
}

_id_2452(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  anim._id_FE49[var_0] = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    anim._id_FE49[var_0][var_4] = spawnStruct();
    anim._id_FE49[var_0][var_4]._id_011A = 0;
    anim._id_FE49[var_0][var_4]._id_A6D6 = "" + (var_4 + 1);
  }

  anim._id_3DAA[var_0] = var_1;
  anim._id_5CE1[var_0] = var_3;
}

_id_244D() {
  _id_2451();

  if(!isDefined(level._id_2359)) {
    level._id_2359 = [];

    foreach(var_1 in anim._id_EFA0) {
      _id_D172(var_1, 0);
    }
  }
}

_id_244F() {
  _id_2451();

  if(!isDefined(level._id_5CDD)) {
    level._id_5CDD = [];

    foreach(var_1 in anim._id_EFA0) {
      level._id_5CDD[var_1] = 0;
    }
  }
}

_id_235D() {
  return 0;
}

_id_2370(var_0) {
  if(var_0.size <= 0) {
    return;
  }
  if(!_id_235D()) {
    return;
  }
  var_1 = "^5 ";

  if(_id_53F4()) {
    var_1 = "^6 ";
  }

  var_2 = (0, 0, -7);

  foreach(var_4 in var_0) {}
}

_id_2364(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 = var_4 + anglestoright(vectortoangles(var_1 - var_0)) * 18;
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 = var_4 + anglestoright(vectortoangles(var_1 - var_0)) * -18;
}

_id_235F() {
  return 0;
}

_id_2375(var_0, var_1) {
  if(!isDefined(level._id_2359)) {
    level._id_2359 = [];
  }

  if(!isDefined(level._id_2359["printscreen"])) {
    level._id_2359["printscreen"] = [];
  }

  if(!isDefined(level._id_2359["printscreen"]["axis"])) {
    level._id_2359["printscreen"]["axis"] = [];
  }

  if(!isDefined(level._id_2359["printscreen"]["allies"])) {
    level._id_2359["printscreen"]["allies"] = [];
  }

  if(!isDefined(level._id_2359["printscreen"]["team3"])) {
    level._id_2359["printscreen"]["team3"] = [];
  }

  var_2 = level._id_2359["printscreen"][self.team].size;

  if(var_2 > 40) {
    level._id_2359["printscreen"][self.team] = ::scripts\engine\utility::array_remove_index(level._id_2359["printscreen"][self.team], 0);
    var_2 = level._id_2359["printscreen"][self.team].size;
  }

  level._id_2359["printscreen"][self.team][var_2]["alias"] = var_0;
  level._id_2359["printscreen"][self.team][var_2]["color"] = var_1;
  level thread _id_2374();
}

_id_2374() {
  self notify("printscreen_stop");
  self endon("printscreen_stop");

  if(!isDefined(level._id_2359)) {
    level._id_2359 = [];
  }

  if(!isDefined(level._id_2359["printscreen"])) {
    level._id_2359["printscreen"] = [];
  }

  var_0 = 220;
  var_1 = 30;
  var_2 = 600;
  var_3 = 1170;

  for(;;) {
    var_4 = var_0;

    for(var_5 = 0; var_5 < level._id_2359["printscreen"]["axis"].size; var_5++) {
      var_4 = var_4 + 18;
    }

    var_4 = var_0;

    for(var_5 = 0; var_5 < level._id_2359["printscreen"]["allies"].size; var_5++) {
      var_4 = var_4 + 18;
    }

    var_4 = var_0;

    for(var_5 = 0; var_5 < level._id_2359["printscreen"]["team3"].size; var_5++) {
      var_4 = var_4 + 18;
    }

    waitframe();
  }
}

_id_3AD9() {
  wait(randomfloatrange(0.3, 0.4));
}

_id_31C0(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(anim.player)) {
    return 0;
  }

  if(isPlayer(self)) {
    if(!isDefined(anim.player._id_237D) || isDefined(anim.player._id_237D) && !anim.player._id_237D) {
      return 0;
    }
  }

  if(var_0 == "stealth") {
    if(distancesquared(anim.player.origin, self.origin) > level._id_2448) {
      return 0;
    }
  } else if(distancesquared(anim.player.origin, self.origin) > level._id_2449)
    return 0;

  if(!isDefined(self._id_237D) || !self._id_237D || !isDefined(self._id_2359._id_A4D1)) {
    return 0;
  }

  if(isDefined(var_2) && var_2 >= 1) {
    return 1;
  }

  if(gettime() + anim._id_56B2[var_0]["self"] < self._id_2359._id_A4D1[var_0]) {
    return 0;
  }

  if(gettime() + anim._id_56B2[var_0]["squad"] < self._id_E478._id_A4D1[var_0]) {
    return 0;
  }

  if(isDefined(var_1) && _id_F8E3(var_0, var_1)) {
    return 0;
  }

  if(isDefined(var_1) && anim._id_56BA[var_0][var_1] < self._id_2359._id_9F35) {
    return 0;
  }

  if(_func_011D(self) && self._id_0229) {
    return 0;
  }

  if(isDefined(self._id_5D9B) && self[[self._id_5D9B]]()) {
    return 0;
  }

  if(!isPlayer(self) && self _meth_81C7()) {
    return 0;
  }

  return 1;
}

_id_6CF0(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "response";
  }

  if(!isDefined(self._id_E478)) {
    return;
  }
  var_4 = scripts\engine\utility::array_randomize(self._id_E478._id_9DB5);
  var_0 = var_0 * var_0;
  var_1 = var_1 * var_1;

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == self) {
      continue;
    }
    if(!isalive(var_4[var_5])) {
      continue;
    }
    var_6 = distancesquared(self.origin, var_4[var_5].origin);

    if(var_6 < var_0) {
      continue;
    }
    if(var_6 > var_1) {
      continue;
    }
    if(_id_8AD1(var_4[var_5])) {
      continue;
    }
    if(!var_4[var_5] _id_31C0(var_2)) {
      continue;
    }
    var_3 = var_4[var_5];

    if(_id_31C2(var_3)) {
      break;
    }
  }

  return var_3;
}

_id_8947() {
  var_0 = self._id_02ED;

  if(!isDefined(var_0)) {
    return 0;
  }

  if(issubstr(var_0.type, "Cover") || issubstr(var_0.type, "Conceal")) {
    return 1;
  }

  return 0;
}

_id_2458() {
  if(isDefined(anim._id_341F)) {
    return anim._id_341F;
  }

  return 0;
}

_id_31C2(var_0) {
  if(_id_53F4()) {
    return 0;
  }

  if(!isDefined(var_0._id_2438)) {
    return 0;
  }

  if(var_0._id_237D == 0) {
    return 0;
  }

  if(!isDefined(var_0._id_2359._id_3DA9)) {
    return 0;
  }

  if(!isDefined(self._id_2359._id_3DA9)) {
    return 0;
  }

  if(self._id_2359._id_3DA9 != var_0._id_2359._id_3DA9) {
    return 0;
  }

  if(_id_A3D2(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isPlayer(self)) {
    var_1 = "UN_plr_name_" + var_0._id_2438;
  } else {
    var_1 = _id_2421() + "name_" + var_0._id_2438;
  }

  if(_func_0205(var_1)) {
    return 1;
  }

  return 0;
}

_id_2421(var_0) {
  if(!isDefined(self._id_2359._id_A6D6)) {
    self._id_2359._id_A6D6 = "";
  }

  if(self == anim.player) {
    return "UN_plr_";
  }

  if(isDefined(var_0) && var_0 == "stealth") {
    if(getDvar("#x3c3931a3a23adba0f") != "off") {
      return tolower("dx_otn_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
    } else {
      return tolower("dx_cst_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
    }
  } else if(isDefined(var_0) && var_0 == "custom")
    return tolower("dx_vom_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
  else if(isDefined(var_0) && var_0 == "custom radio") {
    return tolower("dx_vom");
  } else if(getDvar("#x36f852bff91c62d60") != "off") {
    if(_func_0107(getDvar("#x36f852bff91c62d60"))) {
      if(isDefined(self.team) && scripts\engine\utility::array_contains(getDvar("#x36f852bff91c62d60"), self.team)) {
        return tolower("dx_otn_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
      }
    } else if(isDefined(self.team) && self.team == getDvar("#x36f852bff91c62d60"))
      return tolower("dx_otn_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
    else {
      return tolower("dx_cbc_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
    }
  } else
    return tolower("dx_cbc_" + self._id_2359._id_3DA9 + self._id_2359._id_A6D6 + "_");
}

_id_A3D2(var_0) {
  if(anim._id_901C[self.team] == var_0._id_2438 || gettime() - anim._id_901D[self.team] < anim._id_901E) {
    return 1;
  }

  return 0;
}

_id_53F4() {
  if(_func_011D(self) && self _meth_81BA()) {
    return 1;
  } else {
    return 0;
  }
}

_id_8AD1(var_0) {
  if(!isDefined(var_0._id_2359)) {
    return 0;
  }

  if(_func_0121(self._id_2359._id_A6D6) && _func_0121(var_0._id_2359._id_A6D6) && self._id_2359._id_A6D6 == var_0._id_2359._id_A6D6) {
    return 1;
  } else if(!_func_0121(self._id_2359._id_A6D6) && !_func_0121(var_0._id_2359._id_A6D6) && self._id_2359._id_A6D6 == var_0._id_2359._id_A6D6) {
    return 1;
  } else {
    return 0;
  }
}

_id_F8E3(var_0, var_1) {
  if(!isDefined(anim._id_56C9[var_0][var_1])) {
    return 0;
  }

  if(!isDefined(self._id_E478._id_A4E4[var_0][var_1])) {
    return 0;
  }

  if(gettime() > self._id_E478._id_A4E4[var_0][var_1]) {
    return 0;
  }

  return 1;
}

_id_FC3C(var_0, var_1) {
  if(gettime() - self._id_E49D[var_0]._id_8FB2 > 10000) {
    var_2 = 0;

    for(var_3 = 0; var_3 < self._id_9DB5.size; var_3++) {
      if(self._id_9DB5[var_3] != var_1 && isalive(self._id_9DB5[var_3]._id_0192) && isDefined(self._id_9DB5[var_3]._id_0192._id_E478) && self._id_9DB5[var_3]._id_0192._id_E478._id_E4A3 == var_0) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      self._id_E49D[var_0]._id_5BCA = gettime();
      self._id_E49D[var_0]._id_2F62 = 0;
    }
  }

  self._id_E49D[var_0]._id_8FB2 = gettime();
}

_id_F16D(var_0) {
  if(isDefined(var_0._id_2359._id_2F62) && isDefined(var_0._id_2359._id_2F62[self._id_E478._id_E4A3])) {
    if(var_0._id_2359._id_2F62[self._id_E478._id_E4A3]._id_57AC > gettime()) {
      return 1;
    }
  }

  return 0;
}

_id_B367(var_0) {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  if(!_id_2458()) {
    return;
  }
  if(isDefined(self._id_0B37) && self._id_0B37 > 0) {
    self._id_2359._id_E800 = 4000 + gettime();
    return;
  }

  if(isDefined(self._id_0B67) && isDefined(self._id_0B67._id_7CCD)) {
    self._id_2359._id_E800 = 5500 + gettime();
    return;
  }

  if(isDefined(self._id_2359._id_8A4B) && self._id_2359._id_8A4B) {
    return;
  }
  if(!isDefined(self.team) || isDefined(self.team) && self.team == "allies" && isDefined(anim._id_CF72)) {
    if(anim._id_CF72 + anim._id_CF6F > gettime()) {
      return;
    }
  }

  if(_id_5FAB()) {
    return;
  }
  if(!isDefined(self._id_237D) || !self._id_237D) {
    return;
  }
  if(anim._id_8A97[self.team]) {
    return;
  }
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = _id_6A9B();
  }

  if(isDefined(self._id_241F)) {
    var_0 = self._id_241F;
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self._id_9D39)) {
    if(isDefined(self._id_9D39._id_82D8)) {
      if(self._id_9D39._id_82D8) {
        return;
      }
    }
  }

  if(self == anim.player) {
    if(!isDefined(anim.player._id_237D) || isDefined(anim.player._id_237D) && !anim.player._id_237D) {
      return;
    }
    if(!isDefined(anim.player._id_2456) || anim.player._id_2456 != 0) {
      return;
    } else {
      level notify("player_battlechatter_refresh");
    }
  }

  switch (var_0) {
    case "custom":
      thread _id_B381();
      break;
    case "response":
      thread _id_B8CA();
      break;
    case "order":
      thread _id_B8A8();
      break;
    case "threat":
      thread _id_B900();
      break;
    case "reaction":
      thread _id_B8C5();
      break;
    case "inform":
      thread _id_B856();
      break;
    case "stealth":
      thread _id_B8F9();
      break;
  }
}

_id_30EE(var_0) {
  if(isDefined(self._id_5FAE)) {
    return 0;
  }

  if(isDefined(self._id_9D39)) {
    if(isDefined(self._id_9D39._id_82D8)) {
      if(self._id_9D39._id_82D8) {
        return 0;
      }
    }
  }

  if(!isDefined(self._id_2359._id_3420)) {
    return 0;
  }

  if(!isDefined(self._id_2359._id_3420["reaction"]) || !isDefined(self._id_2359._id_3420["reaction"]._id_56C8)) {
    return 0;
  }

  if(self._id_2359._id_3420["reaction"]._id_56C8 != "friendlyfire") {
    return 0;
  }

  if(gettime() > self._id_2359._id_3420["reaction"]._id_57AC) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    if(isDefined(self._id_E478._id_A4E4["reaction"]["friendlyfire"])) {
      if(gettime() < self._id_E478._id_A4E4["reaction"]["friendlyfire"]) {
        return 0;
      }
    }
  }

  return 1;
}

_id_5FAB() {
  if(!_id_30EE()) {
    return 0;
  }

  _id_4E8D("reaction", "friendlyfire");
  thread _id_B8C5();
  return 1;
}

_id_4E8D(var_0, var_1) {
  if(!isDefined(anim._id_56C9[var_0][var_1])) {
    return;
  }
  self._id_E478._id_A4E4[var_0][var_1] = gettime() + anim._id_56C9[var_0][var_1];
}

_id_8AE4(var_0) {
  var_1 = gettime();

  if(!self._id_E478._id_892D[var_0] && !anim._id_8A96[anim._id_EFA0[0]][var_0] && !anim._id_8A96[anim._id_EFA0[1]][var_0] && !anim._id_8A96[anim._id_EFA0[2]][var_0] && !anim._id_8A96[anim._id_EFA0[3]][var_0] && gettime() < self._id_2359._id_3420[var_0]._id_57AC && gettime() > _id_CB84(self._id_E478._id_A4D1[var_0])) {
    if(!_id_F8E3(var_0, self._id_2359._id_3420[var_0]._id_56C8)) {
      return 1;
    }
  }

  return 0;
}

_id_CB84(var_0) {
  if(!isDefined(self._id_237B)) {
    return var_0;
  }

  var_1 = var_0 - gettime();

  if(var_1 <= 0) {
    return var_0;
  } else {
    var_1 = var_1 - var_1 * self._id_237B;
    var_1 = var_1 + gettime();
  }

  return var_1;
}

_id_6A9B() {
  var_0 = undefined;
  var_1 = -999999999;

  foreach(var_4, var_3 in self._id_2359._id_3420) {
    if(_id_8AE4(var_4)) {
      if(var_3._id_BD27 > var_1) {
        var_0 = var_4;
        var_1 = var_3._id_BD27;
      }
    }
  }

  return var_0;
}

_id_B381() {
  var_0 = self._id_2359._id_3420["custom"];
  self._id_413B = self._id_2359._id_3420["custom"];
  self._id_413B._id_56B1 = "custom";
  self._id_413B._id_56C8 = "generic";
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  anim thread _id_96ED(var_1, "custom", 1);
  var_2 = var_1 _id_3FAC();
  var_2._id_E05F[0] = var_1._id_4269;
  var_1 _id_B8B7(var_2, self);
  var_1 notify("done speaking");
  var_1._id_4268 = undefined;
  var_1._id_4269 = undefined;
}

_id_B8CA() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_413B = self._id_2359._id_3420["response"];
  var_0 = self._id_2359._id_3420["response"]._id_02D0;
  var_1 = self._id_2359._id_3420["response"]._id_C6CD;

  if(!isalive(var_1)) {
    return;
  }
  if(self._id_2359._id_3420["response"]._id_02D0 == "follow" && !_id_06BD::_id_23E5()) {
    return;
  }
  anim thread _id_96ED(self, "response");

  switch (self._id_2359._id_3420["response"]._id_56C8) {
    case "exposed":
      _id_C6D5(var_1, var_0);
      break;
    case "callout":
      _id_C6D4(var_1, var_0, self._id_0192);
      break;
    case "ack":
      _id_C6D1(var_1, var_0);
      break;
    case "location":
      _id_C6D2(var_1, var_0, self._id_0192);
      break;
    default:
      _id_C6D1(var_1, var_0);
      break;
  }

  self notify("done speaking");
}

_id_C6D5(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_3 = var_2 _id_3FAC();
  var_3 _id_1152(var_1);
  var_3._id_2420 = var_0;
  var_3._id_9BA1 = 1;
  var_2 _id_B8B7(var_3, self);
}

_id_114A(var_0, var_1) {
  var_2 = _id_3FC4(var_0, var_1);

  if(!_func_0205(var_2)) {
    _id_2376("Can't find echo alias '" + var_2 + "'.");
    return 0;
  }

  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_3FC4(var_0, var_1) {
  var_2 = "_report";
  var_3 = "_echo";
  var_4 = undefined;

  if(var_1 == anim.player) {
    var_5 = "plr";
  } else {
    var_5 = var_1._id_2359._id_A6D6;
  }

  if(self.owner == anim.player) {
    var_4 = self.owner._id_2359._id_3DA9 + "_plr_";
  } else {
    var_4 = self.owner _id_2421() + "";
  }

  var_6 = var_0.size - var_2.size;

  if(self.owner == anim.player) {
    var_7 = self.owner._id_2359._id_3DA9 + "_plr_";
    var_8 = var_7.size;
  } else {
    var_7 = self.owner._id_2359._id_3DA9 + "_" + var_5 + "_";
    var_8 = var_7.size;
  }

  var_9 = _func_00D6(var_0, var_8, var_6);
  var_10 = var_4 + var_9 + var_3;
  return var_10;
}

_id_C6D4(var_0, var_1, var_2) {
  var_3 = self._id_413B._id_C560;
  var_4 = self._id_413B._id_96CF;
  var_5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_6 = var_5 _id_3FAC();
  var_7 = 0;

  if(var_1 == "echo") {
    var_7 = var_6 _id_114A(var_3, var_0);
  } else if(var_1 == "QA") {
    var_7 = var_6 _id_114D(var_0, var_3, var_4);
  } else {
    var_7 = var_6 _id_114E(var_1, var_2);
  }

  if(!var_7) {
    return;
  }
  var_6._id_2420 = var_0;
  var_6._id_9BA1 = 1;
  var_5 _id_B8B7(var_6, self);
}

_id_114D(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_5 in var_2._id_96D6) {
    if(issubstr(var_1, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = self.owner _id_2421() + "";
  var_8 = _func_00D6(var_1, var_1.size - 1, var_1.size);
  var_9 = int(var_8) + 1;
  var_10 = var_7 + _id_6908() + "_location_" + var_3 + "_qa" + var_9;

  if(!_func_0205(var_10)) {
    if(randomint(100) < anim._id_56B4["response"]["callout_negative"]) {
      var_0 _id_070B::_id_1124("callout", "neg", self.owner, 0.9);
    } else {
      var_0 _id_070B::_id_1124("exposed", "acquired", self.owner, 0.9);
    }

    var_2._id_BE90 = 1;
    return 0;
  }

  var_0 _id_070B::_id_1124("callout", "QA", self.owner, 0.9, var_10, var_2);
  self._id_E05F[self._id_E05F.size] = var_10;
  return 1;
}

_id_114E(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = "_" + var_0;
  }

  var_2 = self.owner _id_6903("response_threat" + var_0);

  if(!_func_0205(var_2)) {
    _id_2376("Can't find callout response alias '" + var_2 + "'.");
    return 0;
  }

  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_C6D1(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = self._id_2359._id_3420["response"]._id_56C8;
  var_3 = self;
  var_4 = var_3 _id_3FAC();
  var_4 _id_1123(var_2, var_1);
  var_4._id_2420 = var_0;
  var_4._id_9BA1 = 1;
  var_3 _id_B8B7(var_4, self);
}

_id_C6D2(var_0, var_1, var_2) {
  var_3 = self._id_413B._id_C560;
  var_4 = self._id_413B._id_96CF;
  var_5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_6 = var_5 _id_3FAC();
  var_7 = var_6 _id_10E4(var_1, var_2);

  if(!var_7) {
    return;
  }
  var_6._id_2420 = var_0;
  var_6._id_9BA1 = 1;
  var_5 _id_B8B7(var_6, self);
}

_id_10E4(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = "_" + var_0;
  }

  var_2 = self.owner _id_6903("location_response") + var_0;

  if(!_func_0205(var_2)) {
    _id_2376("Can't find location response alias '" + var_2 + "'.");
    return 0;
  }

  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_B8A8() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_413B = self._id_2359._id_3420["order"];
  var_0 = self._id_2359._id_3420["order"]._id_02D0;
  var_1 = self._id_2359._id_3420["order"]._id_AC65;
  anim thread _id_96ED(self, "order");

  switch (self._id_2359._id_3420["order"]._id_56C8) {
    case "action":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = anim.player;
      }

      _id_AC60(var_0, var_1);
      break;
    case "move":
      _id_AC64(var_0, var_1);
      break;
    case "displace":
      _id_AC61(var_0);
      break;
  }

  if(isDefined(self._id_0B67)) {
    self._id_0B67._id_235B = undefined;
    self._id_0B67._id_237C = undefined;
  }

  self notify("done speaking");
}

_id_AC60(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = var_2 _id_3FAC();
  var_2 _id_F751(var_3, var_1);
  var_3 _id_1108("action", var_0);
  var_2 _id_B8B7(var_3, self);
}

_id_AC64(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = var_2 _id_3FAC();
  var_2 _id_F751(var_3, var_1);
  var_3 _id_1108("move", var_0);
  var_2 _id_B8B7(var_3, self);
}

_id_F751(var_0, var_1) {
  if(randomint(100) > anim._id_56B4["response"]["order"]) {
    if(!isDefined(var_1) || isDefined(var_1) && !isPlayer(var_1)) {
      return;
    }
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(anim.player._id_2439)) {
    var_0 _id_1111();
    var_0._id_2420 = anim.player;
  } else if(isDefined(var_1) && _id_31C2(var_1)) {
    var_0 _id_10EC(var_1._id_2438);
    var_0._id_2420 = var_1;
    var_1 _id_070B::_id_1124("ack", "affirm", self, 0.9);
  } else
    level notify("follow order", self);
}

_id_AC61(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = self;
  var_2 = var_1 _id_3FAC();
  var_2 _id_1108("displace", var_0);
  var_1 _id_B8B7(var_2, self, 1);
}

_id_1108(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = self.owner _id_6903("order" + var_1);

  if(!isDefined(var_2)) {
    return 0;
  }

  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_B856() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_413B = self._id_2359._id_3420["inform"];
  var_0 = self._id_2359._id_3420["inform"]._id_02D0;

  if(var_0 == "generic") {
    var_0 = undefined;
  }

  anim thread _id_96ED(self, "inform");

  if(self != anim.player) {
    self._id_0B67._id_237C = anim.player;
  }

  switch (self._id_2359._id_3420["inform"]._id_56C8) {
    case "incoming":
      _id_7EA6(var_0);
      break;
    case "attack":
      _id_7EA4(var_0);
      break;
    case "reloading":
      _id_7EA8(var_0);
      break;
    case "suppressed":
      _id_7EA9(var_0);
      break;
    case "killfirm":
      _id_7EA7(var_0);
      break;
  }

  self notify("done speaking");
}

_id_B900() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self._id_413B = self._id_2359._id_3420["threat"];
  var_0 = self._id_2359._id_3420["threat"]._id_F13F;

  if(!isalive(var_0)) {
    return;
  }
  if(_id_F16D(var_0) && !isPlayer(var_0)) {
    return;
  }
  anim thread _id_96ED(self, "threat");
  var_1 = 0;
  var_2 = self._id_2359._id_3420["threat"]._id_56C8;

  switch (var_2) {
    case "infantry":
      if(isPlayer(var_0) || !isDefined(var_0 _meth_8182())) {
        if(isDefined(self._id_0B67)) {
          self._id_0B67._id_237C = var_0;
        }

        var_1 = _id_F164(var_0, undefined);
      } else {}

      break;
    case "acquired":
    case "vehicle":
      self._id_2F78 = var_2;
      var_1 = _id_F164(var_0, undefined);
      break;
    case "sighted":
      self._id_2F78 = var_2;
      var_1 = _id_F164(var_0, undefined);
      break;
  }

  var_3 = self;
  var_3 notify("done speaking");

  if(!var_1) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0._id_2359._id_2F62[var_3._id_E478._id_E4A3] = spawnStruct();
  var_0._id_2359._id_2F62[var_3._id_E478._id_E4A3]._id_E43D = var_3;
  var_0._id_2359._id_2F62[var_3._id_E478._id_E4A3]._id_F16B = var_3._id_2359._id_3420["threat"]._id_56C8;
  var_0._id_2359._id_2F62[var_3._id_E478._id_E4A3]._id_57AC = gettime() + anim._id_2454;

  if(isDefined(var_0._id_E478)) {
    var_3._id_E478._id_E49D[var_0._id_E478._id_E4A3]._id_2F62 = 1;
  }
}

_id_6DE2(var_0) {
  var_1 = var_0 _id_6E2F(self);
  var_2 = _id_69E1(self.angles, self.origin, var_0.origin);
  var_3 = _id_6CF0(64, 1024, "response");
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_4 = _id_69E1(var_3.angles, var_3.origin, var_0.origin);
  }

  var_5 = _id_69E1(anim.player.angles, anim.player.origin, var_0.origin);

  if(self.team == "allies") {
    var_6 = var_5;
    var_7 = anim.player;
  } else if(isDefined(var_3)) {
    var_6 = var_4;
    var_7 = var_3;
  } else {
    var_6 = var_2;
    var_7 = self;
  }

  var_8 = _id_69E8(var_7.origin, var_0.origin);
  self._id_BA12 = [];

  if(!isDefined(var_1) && var_0 _id_8845(0)) {
    _id_1115("exposed");
  }

  if(self.team == "allies") {
    var_9 = 0;

    if(var_0.origin[2] - var_7.origin[2] >= level._id_7666) {
      if(_id_1115("player_target_clock_high")) {
        var_9 = 1;
      }
    }

    if(!var_9) {
      if(var_6 == "12") {
        _id_1115("player_obvious");

        if(var_8 > level._id_9EB7 && var_8 < level._id_9C66) {
          _id_1115("player_distance");
        }
      }

      if(_id_31C3() && var_6 != "12") {
        _id_1115("player_contact_clock");
        _id_1115("player_target_clock");
        _id_1115("player_cardinal");
      }
    }
  }

  var_9 = 0;

  if(var_0.origin[2] - var_7.origin[2] >= level._id_7666) {
    if(_id_1115("ai_target_clock_high")) {
      var_9 = 1;
    }
  }

  _id_1115("ai_casual_clock");

  if(!var_9) {
    if(var_6 == "12") {
      _id_1115("ai_distance");

      if(var_8 > level._id_9EB7 && var_8 < level._id_9C66) {
        _id_1115("ai_obvious");
      }
    }

    _id_1115("ai_contact_clock");
    _id_1115("ai_target_clock");
    _id_1115("ai_cardinal");
  }

  if(isDefined(var_1)) {
    if(_id_3169(var_1) && scripts\engine\utility::cointoss()) {
      _id_1115("concat_location");
    } else if(isDefined(var_1 _id_6947(self))) {
      if(isDefined(var_3)) {
        _id_1115("ai_location");
      } else {
        _id_2376("Calling out a location at origin " + var_1.origin + " with a canned response, but there are no AIs able to respond.");

        if(_id_31C3()) {
          _id_1115("player_location");
        }

        _id_1115("generic_location");
      }
    } else {
      if(isDefined(var_3)) {
        _id_1115("ai_location");
      }

      if(_id_31C3() || isDefined(self._id_AD33)) {
        _id_1115("player_location");
      }

      _id_1115("generic_location");
    }
  }

  if(!self._id_BA12.size) {
    return undefined;
  }

  var_10 = _id_6E95(self._id_BA12, anim._id_F160);
  var_11 = spawnStruct();
  var_11.type = var_10;
  var_11._id_C6CB = var_3;
  var_11._id_C6CC = var_4;
  var_11._id_B67E = var_5;

  if(isDefined(var_1)) {
    var_11._id_96CF = var_1;
  }

  return var_11;
}

_id_8845(var_0) {
  if(distancesquared(self.origin, anim.player.origin) > 2250000) {
    return 0;
  }

  if(isDefined(var_0) && var_0 && isDefined(_id_6B1C())) {
    return 0;
  }

  var_1 = _id_242C();

  if(!isDefined(var_1)) {
    return 1;
  }

  if(!_id_8947()) {
    return 0;
  }

  return 1;
}

_id_6B1C() {
  var_0 = _id_6335();
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  if(var_0.size) {
    var_1 = _id_0C01(var_0);
  }

  return var_1;
}

_id_1115(var_0) {
  var_1 = 0;

  if(isDefined(self._id_15AC)) {
    foreach(var_3 in self._id_15AC) {
      if(var_3 == var_0) {
        if(!_id_2FCE(var_0)) {
          var_1 = 1;
        }

        break;
      }
    }
  }

  if(!var_1) {
    return var_1;
  }

  self._id_BA12[self._id_BA12.size] = var_0;
  return var_1;
}

_id_2FCE(var_0) {
  if(!isDefined(anim._id_90A4[self.team])) {
    return 0;
  }

  if(!isDefined(anim._id_90A5[self.team])) {
    return 0;
  }

  var_1 = anim._id_90A4[self.team];
  var_2 = anim._id_90A5[self.team];
  var_3 = anim._id_EFB4;

  if(var_0 == var_1 && gettime() - var_2 < var_3) {
    return 1;
  }

  return 0;
}

_id_3169(var_0) {
  var_1 = var_0._id_96D6;

  foreach(var_3 in var_1) {
    if(_id_879F(var_3, self)) {
      return 1;
    }
  }

  return 0;
}

_id_879F(var_0, var_1) {
  var_0 = var_1 _id_6B1E(_id_6908() + "_location_concat_" + var_0);

  if(_func_0205(var_0)) {
    return 1;
  }

  return 0;
}

_id_6E95(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }
    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100) {
        continue;
      }
    } else {
      if(var_1[var_5] >= 100) {
        var_2 = var_5;
        var_3 = var_6;
        continue;
      }

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

_id_F164(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = _id_3FAC();
  var_2._id_9BA1 = 1;
  var_2._id_F163 = var_0;
  var_3 = _id_6DE2(var_0);

  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type)) {
    return 0;
  }

  var_4 = undefined;

  if(isDefined(self._id_2F78)) {
    var_4 = self._id_2F78;
  } else {
    var_4 = var_3.type;
  }

  switch (var_4) {
    case "exposed":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_3._id_C6CB;
      }

      var_5 = _id_4C83(var_3._id_C6CB);
      var_6 = self;

      if(var_5 && var_6 _id_31C2(var_3._id_C6CB)) {
        var_2 _id_10EC(var_3._id_C6CB._id_2438);
        var_2._id_2420 = var_3._id_C6CB;
      }

      var_2 _id_F166(var_0);

      if(var_5) {
        if(randomint(100) < anim._id_56B4["response"]["callout_negative"]) {
          var_3._id_C6CB _id_070B::_id_1124("callout", "neg", self, 0.9);
        } else {
          var_3._id_C6CB _id_070B::_id_1124("exposed", "acquired", self, 0.9);
        }
      }

      break;
    case "acquired":
      var_2 _id_1111();
      var_2 _id_1149("acquired", var_3._id_B67E);
      break;
    case "sighted":
      var_2 _id_1111();
      var_2 _id_1149("sighted", var_3._id_B67E);
      break;
    case "player_obvious":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = anim.player;
      }

      var_2 _id_1111();
      var_2 _id_1153();
      break;
    case "player_distance":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = anim.player;
      }

      var_7 = _id_69E9(anim.player.origin, var_0.origin);
      var_2 _id_1111();
      var_2 _id_114F(var_7);
      break;
    case "player_contact_clock":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_1111();
      var_2 _id_1149("contactclock", var_3._id_B67E);
      break;
    case "player_target_clock":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_1111();
      var_2 _id_1149("targetclock", var_3._id_B67E);
      break;
    case "player_target_clock_high":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_1111();
      var_8 = _id_69D9(anim.player.origin, var_0.origin);

      if(var_8 >= 20 && var_8 <= 60) {
        var_2 _id_1149("targetclock_high", var_3._id_B67E);
        var_2 _id_1150(var_8);
      } else
        return 0;

      break;
    case "player_cardinal":
      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_1111();
      var_9 = _id_69E0(anim.player.origin, var_0.origin);
      var_10 = _id_A5C6(var_9);

      if(var_10 == "impossible") {
        return 0;
      }

      var_2 _id_1149("cardinal", var_10);
      break;
    case "ai_obvious":
      if(isDefined(var_3._id_C6CB) && _id_31C2(var_3._id_C6CB)) {
        var_2 _id_10EC(var_3._id_C6CB._id_2438);
        var_2._id_2420 = var_3._id_C6CB;
      }

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_1153();
      var_2 _id_1098(self, var_3, var_0);
      break;
    case "ai_distance":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      } else if(isDefined(var_3._id_C6CB) && randomint(100) < anim._id_56B4["response"]["callout"]) {
        var_11 = var_3._id_C6CB;
      }

      var_7 = _id_69E9(var_11.origin, var_0.origin);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_2 _id_114F(var_7);
      var_2 _id_1098(self, var_3, var_0);
      break;
    case "ai_contact_clock":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      } else if(isDefined(var_3._id_C6CB) && randomint(100) < anim._id_56B4["response"]["callout"]) {
        var_11 = var_3._id_C6CB;
      }

      var_12 = _id_6CE9(var_11);
      var_13 = _id_69E1(var_12, var_11.origin, var_0.origin);
      var_2 _id_1149("contactclock", var_13);
      var_2 _id_1098(self, var_3, var_0);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "ai_casual_clock":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      } else if(isDefined(var_3._id_C6CB) && randomint(100) < anim._id_56B4["response"]["callout"]) {
        var_11 = var_3._id_C6CB;
      }

      var_12 = _id_6CE9(var_11);
      var_13 = _id_69E1(var_12, var_11.origin, var_0.origin);
      var_2 _id_1149("contactclock", var_13);
      var_2 _id_1098(self, var_3, var_0);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "ai_target_clock":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      } else if(isDefined(var_3._id_C6CB) && randomint(100) < anim._id_56B4["response"]["callout"]) {
        var_11 = var_3._id_C6CB;
      }

      var_12 = _id_6CE9(var_11);
      var_13 = _id_69E1(var_12, var_11.origin, var_0.origin);
      var_2 _id_1149("targetclock", var_13);
      var_2 _id_1098(self, var_3, var_0);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "ai_target_clock_high":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      } else if(isDefined(var_3._id_C6CB) && randomint(100) < anim._id_56B4["response"]["callout"]) {
        var_11 = var_3._id_C6CB;
      }

      var_12 = _id_6CE9(var_11);
      var_13 = _id_69E1(var_12, var_11.origin, var_0.origin);
      var_8 = _id_69D9(var_11.origin, var_0.origin);

      if(var_8 >= 20 && var_8 <= 60) {
        var_2 _id_1149("targetclock_high", var_13);
        var_2 _id_1150(var_8);
      } else
        return 0;

      var_2 _id_1098(self, var_3, var_0);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "ai_cardinal":
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      }

      var_9 = _id_69E0(var_11.origin, var_0.origin);
      var_10 = _id_A5C6(var_9);

      if(var_10 == "impossible") {
        return 0;
      }

      var_2 _id_1149("cardinal", var_10);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "generic_location":
      var_6 = self;
      var_11 = self;

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      var_14 = var_2 _id_F165(var_3, undefined, var_6);

      if(!var_14) {
        return 0;
      }

      if(self.team == "allies") {
        var_11 = anim.player;
      }

      var_2 _id_109E(var_11, var_0);
      var_2 _id_1098(self, var_3, var_0);
      break;
    case "player_location":
      var_6 = self;
      var_2 _id_1111();

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = anim.player;
      }

      var_14 = var_2 _id_F165(var_3, undefined, var_6);

      if(!var_14) {
        return 0;
      }

      break;
    case "concat_location":
      var_15 = 0;

      if(randomint(3)) {
        var_15 = 1;
        var_2 _id_109F(var_0);
      }

      var_6 = self;
      var_11 = self;

      if(self.team == "allies") {
        var_11 = anim.player;
      }

      var_14 = var_2 _id_F165(var_3, 1, var_6);

      if(!var_14) {
        return 0;
      }

      if(!var_15) {
        var_2 _id_109E(var_11, var_0);
      } else if(randomint(3)) {
        var_2 _id_109E(var_11, var_0);
      }

      var_2 _id_1098(self, var_3, var_0);

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
    case "ai_location":
      var_6 = self;

      if(var_6 _id_31C2(var_3._id_C6CB)) {
        var_2 _id_10EC(var_3._id_C6CB._id_2438);
        var_2._id_2420 = var_3._id_C6CB;
      }

      var_14 = var_2 _id_F165(var_3, undefined, var_6);

      if(!var_14) {
        return 0;
      }

      var_16 = var_2._id_E05F.size - 1;
      var_17 = var_2._id_E05F[var_16];

      if(_id_87A1(var_17)) {
        var_3._id_C6CB _id_070B::_id_1124("callout", "echo", self, 0.9, var_17);
      } else if(_id_87A0(var_17, self)) {
        var_3._id_C6CB _id_070B::_id_1124("callout", "QA", self, 0.9, var_17, var_3._id_96CF);
      } else if(randomint(100) < anim._id_56B4["response"]["callout_negative"]) {
        var_3._id_C6CB _id_070B::_id_1124("callout", "neg", self, 0.9);
      } else {
        var_3._id_C6CB _id_070B::_id_1124("exposed", "acquired", self, 0.9);
      }

      if(isDefined(self._id_0B67)) {
        self._id_0B67._id_237C = var_0;
      }

      break;
  }

  _id_D5D9(var_3.type);
  var_6 = self;

  if(isDefined(self._id_0B67)) {
    self._id_0B67._id_2369 = 0;
  }

  var_6 _id_B8B7(var_2, self);

  if(isDefined(self._id_0B67)) {
    self._id_0B67._id_235B = undefined;
    self._id_0B67._id_237C = undefined;
  }

  return 1;
}

_id_1153() {
  var_0 = self.owner _id_6903("order_suppress");
  self._id_E05F[self._id_E05F.size] = var_0;
  return 1;
}

_id_1149(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = undefined;

  if(self.owner == anim.player) {
    if(var_0 == "acquired" || var_0 == "sighted") {
      var_2 = self.owner._id_2359._id_3DA9 + "_plr_target_" + var_0;
    } else {
      var_2 = self.owner._id_2359._id_3DA9 + "_plr_callout_" + var_0 + var_1;
    }
  } else
    var_2 = self.owner _id_6903("threat_callout_" + var_0) + var_1;

  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_31C3() {
  if(_id_53F4()) {
    return 0;
  }

  if(self == anim.player) {
    return 0;
  }

  if(!isDefined(anim.player._id_2439) || !isDefined(anim.player._id_2426)) {
    return 0;
  }

  if(_id_B557()) {
    return 0;
  }

  var_0 = _id_2421() + "name_player_" + anim.player._id_2426 + "_" + anim.player._id_2439;

  if(_func_0205(var_0)) {
    return 1;
  }

  return 0;
}

_id_B557() {
  if(!isDefined(anim._id_902A)) {
    return 0;
  }

  if(gettime() - anim._id_902A >= anim._id_56C9["playername"]) {
    return 0;
  }

  return 1;
}

_id_1111() {
  if(!self.owner _id_31C3()) {
    return;
  }
  anim._id_902A = gettime();
  var_0 = self.owner _id_2421() + "name_player_" + anim.player._id_2426 + "_" + anim.player._id_2439;
  self._id_E05F[self._id_E05F.size] = var_0;
  self._id_2420 = anim.player;
}

_id_69E8(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

_id_69E9(var_0, var_1) {
  var_2 = _id_69E8(var_0, var_1);

  if(var_2 < 15.0) {
    return "10";
  } else if(var_2 < 25.0) {
    return "20";
  } else if(var_2 < 35.0) {
    return "30";
  } else if(var_2 < 45.0) {
    return "40";
  } else if(var_2 < 55.0) {
    return "50";
  } else if(var_2 < 65.0) {
    return "60";
  } else if(var_2 < 75.0) {
    return "70";
  } else if(var_2 < 85.0) {
    return "80";
  } else if(var_2 < 95.0) {
    return "90";
  } else {
    return "100";
  }
}

_id_114F(var_0) {
  var_1 = self.owner _id_6903("contact_dist") + var_0;
  self._id_E05F[self._id_E05F.size] = var_1;
  return 1;
}

_id_10EC(var_0) {
  if(self.owner == anim.player) {} else
    self._id_E05F[self._id_E05F.size] = self.owner _id_2421() + "name_" + var_0;

  anim._id_901C[self.owner.team] = var_0;
  anim._id_901D[self.owner.team] = gettime();
}

_id_4C83(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0._id_2359._id_3DA9) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      break;
    default:
      return 0;
  }

  if(randomint(100) > anim._id_56B4["response"]["exposed"]) {
    return 0;
  }

  return 1;
}

_id_69D9(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = _func_0014(var_2 / var_3);

  if(var_4 < 15 || var_4 > 65) {
    return var_4;
  } else if(var_4 < 25) {
    return 20;
  } else if(var_4 < 35) {
    return 30;
  } else if(var_4 < 45) {
    return 40;
  } else if(var_4 < 55) {
    return 50;
  } else if(var_4 < 65) {
    return 60;
  }
}

_id_1150(var_0) {
  var_1 = self.owner _id_6903("contact_elev") + var_0;
  self._id_E05F[self._id_E05F.size] = var_1;
  return 1;
}

_id_69E0(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = _func_00B9();
  var_3 = var_3 - var_4;

  if(var_3 < 0) {
    var_3 = var_3 + 360;
  } else if(var_3 > 360) {
    var_3 = var_3 - 360;
  }

  if(var_3 < 22.5 || var_3 > 337.5) {
    var_5 = "north";
  } else if(var_3 < 67.5) {
    var_5 = "northwest";
  } else if(var_3 < 112.5) {
    var_5 = "west";
  } else if(var_3 < 157.5) {
    var_5 = "southwest";
  } else if(var_3 < 202.5) {
    var_5 = "south";
  } else if(var_3 < 247.5) {
    var_5 = "southeast";
  } else if(var_3 < 292.5) {
    var_5 = "east";
  } else if(var_3 < 337.5) {
    var_5 = "northeast";
  } else {
    var_5 = "impossible";
  }

  return var_5;
}

_id_A5C6(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "north":
      var_1 = "n";
      break;
    case "northwest":
      var_1 = "nw";
      break;
    case "west":
      var_1 = "w";
      break;
    case "southwest":
      var_1 = "sw";
      break;
    case "south":
      var_1 = "s";
      break;
    case "southeast":
      var_1 = "se";
      break;
    case "east":
      var_1 = "e";
      break;
    case "northeast":
      var_1 = "ne";
      break;
    case "impossible":
      var_1 = "impossible";
      break;
    default:
      return;
  }

  return var_1;
}

_id_1098(var_0, var_1, var_2) {
  if(!isDefined(var_1._id_C6CB)) {
    return;
  }
  if(var_1._id_C6CB.team != var_0.team) {
    return;
  }
  if(randomint(100) > anim._id_56B4["response"]["callout"]) {
    return;
  }
  var_3 = "neg";
  var_4 = "callout";

  if(!var_1._id_C6CB _id_2425(var_2) && randomint(100) < anim._id_56B4["response"]["callout_negative"]) {} else {
    var_3 = "affirm";

    if(isDefined(var_1._id_96CF)) {
      var_5 = var_2 _id_6E2F(var_1._id_C6CB, "response");

      if(isDefined(var_5) && isDefined(var_5._id_96D6[0])) {
        var_3 = var_5._id_96D6[0];
        var_4 = "location";
      }
    }
  }

  var_1._id_C6CB _id_070B::_id_1124(var_4, var_3, var_0, 0.9);
}

_id_2425(var_0) {
  if(!isDefined(self)) {
    return 0;
  } else if(isPlayer(self)) {
    if(scripts\anim\utility_common::_id_B3D2(self, var_0)) {
      return 1;
    }
  } else if(self _meth_8067(var_0))
    return 1;

  return 0;
}

_id_6E2F(var_0, var_1, var_2) {
  var_3 = _id_6335();
  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = undefined;

  if(var_3.size) {
    foreach(var_4 in var_3) {
      if(!var_0 _id_3150(var_4, var_1, var_2)) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_4);
      }
    }

    var_4 = _id_0C01(var_3, var_1);
  }

  return var_4;
}

_id_6335() {
  var_0 = anim._id_2447;
  var_1 = self _meth_813D(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_96D6)) {
      if(isDefined(var_4._id_88FB) && anim.player istouching(var_4)) {
        continue;
      } else {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_4009(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = strtok(var_0, "_");
  var_2[2] = self._id_2359._id_3DA9 + "l1";
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_4 == 0) {
      var_3 = var_2[var_4];
      continue;
    }

    var_3 = var_3 + ("_" + var_2[var_4]);
  }

  return tolower(var_3 + "_r" + var_1);
}

_id_3150(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  foreach(var_4 in var_0._id_96D6) {
    var_5 = undefined;

    if(var_1 == "stealth") {
      if(var_2 == "checkin") {
        var_6 = _id_BFFD(1);
        var_4 = _id_6B1E(_id_6908() + "_location_" + var_2 + "_" + var_4 + "_");
        var_4 = _id_4009(var_4, var_6);
      } else
        var_4 = _id_6B1E(_id_6908() + "_location_" + var_2 + "_" + var_4 + "_" + _id_BFFD(1));

      var_7 = _func_0205(var_4);
    } else if(var_1 == "response") {
      var_5 = _id_6B1E(_id_6908() + "_location_resp_" + var_4);
      var_7 = _func_0205(var_5);
    } else {
      var_5 = _id_6B1E(_id_6908() + "_location_callout_" + var_4);
      var_8 = _id_6C92(var_4, 0);
      var_9 = _id_6B1E(_id_6908() + "_location_concat_" + var_4);
      var_7 = _func_0205(var_5) || _func_0205(var_8) || _func_0205(var_9);
    }

    if(var_7) {
      return var_7;
    } else {
      if(isDefined(var_5)) {
        var_4 = var_5;
      }

      _id_2376("Missing location alias: " + var_4);
    }
  }

  return 0;
}

_id_BFFD(var_0, var_1) {
  if(getDvar("#x3c3931a3a23adba0f") != "off") {
    return "01";
  }

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      return randomintrange(var_0, var_1) * 1;
    } else {
      return "01";
    }
  }
}

_id_96D1(var_0) {
  var_1 = _id_96D3(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return 1;
}

_id_0C01(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!_id_96D1(var_3)) {
      if(isDefined(var_3._id_88FB)) {
        return var_3;
      }
    }
  }

  foreach(var_3 in var_0) {
    if(!_id_96D2(var_3, var_1) && isDefined(var_3._id_88FB) && randomint(3) == 0) {
      return var_3;
    } else if(!_id_96D1(var_3)) {
      return var_3;
    }
  }

  foreach(var_3 in var_0) {
    if(!_id_96D2(var_3, var_1)) {
      return var_3;
    }
  }

  return undefined;
}

_id_96D2(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = _id_96D3(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_1 == "stealth") {
    var_3 = var_2 + anim._id_56B2["stealth"]["location_repeat"];
  } else {
    var_3 = var_2 + anim._id_56B2["threat"]["location_repeat"];
  }

  if(gettime() < var_3) {
    return 1;
  }

  return 0;
}

_id_96D0(var_0) {
  anim._id_96D9[var_0.classname] = gettime();
}

_id_96D3(var_0) {
  if(isDefined(anim._id_96D9[var_0.classname])) {
    return anim._id_96D9[var_0.classname];
  }

  return undefined;
}

_id_F166(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "open");
  var_1 = scripts\engine\utility::array_add(var_1, "breaking");

  if(self.owner.team == "allies") {
    var_1 = scripts\engine\utility::array_add(var_1, "movement");
    var_2 = _func_0072("axis");

    if(var_2 > 2) {
      var_1 = scripts\engine\utility::array_add(var_1, "group");
    }
  }

  var_3 = var_1[randomint(var_1.size)];
  _id_1152(var_3);
}

_id_1152(var_0) {
  if(var_0 == "group") {
    var_0 = "movement_group";
  }

  var_1 = self.owner _id_6903("exposed_" + var_0);
  self._id_E05F[self._id_E05F.size] = var_1;
  return 1;
}

_id_6CE9(var_0) {
  var_1 = var_0.angles;

  if(!isPlayer(var_0)) {
    var_2 = var_0 _id_242C();

    if(isDefined(var_2)) {
      var_1 = var_2.angles;
    }
  }

  return var_1;
}

_id_242C() {
  if(isPlayer(self)) {
    return self._id_02ED;
  } else {
    return scripts\anim\utility_common::_id_695E();
  }
}

_id_242A() {
  for(var_0 = 0; var_0 < anim._id_2447.size; var_0++) {
    var_1 = anim._id_2447[var_0]._id_96D6;

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = "";

    foreach(var_4 in var_1) {
      var_2 = var_2 + var_4;
    }

    thread _id_4F37("Location: " + var_2, anim._id_2447[var_0] _meth_8169(), (0, 0, 8), (1, 1, 1));
  }
}

_id_4F37(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(distancesquared(anim.player.origin, var_1) > 4194304) {
      wait 0.1;
      continue;
    }

    wait 0.05;
  }
}

_id_69E1(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 345 || var_7 < 15) {
    var_8 = "12";
  } else if(var_7 < 45) {
    var_8 = "1";
  } else if(var_7 < 75) {
    var_8 = "2";
  } else if(var_7 < 105) {
    var_8 = "3";
  } else if(var_7 < 135) {
    var_8 = "4";
  } else if(var_7 < 165) {
    var_8 = "5";
  } else if(var_7 < 195) {
    var_8 = "6";
  } else if(var_7 < 225) {
    var_8 = "7";
  } else if(var_7 < 255) {
    var_8 = "8";
  } else if(var_7 < 285) {
    var_8 = "9";
  } else if(var_7 < 315) {
    var_8 = "10";
  } else {
    var_8 = "11";
  }

  return var_8;
}

_id_F165(var_0, var_1, var_2) {
  var_3 = _id_114C(var_0._id_96CF, var_1, var_2);
  return var_3;
}

_id_6947(var_0) {
  var_1 = undefined;
  var_2 = self._id_96D6;

  foreach(var_4 in var_2) {
    if(_id_87A0(var_4, var_0) && !isDefined(self._id_BE90)) {
      var_1 = var_4;
      break;
    }

    if(_id_87A1(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_114C(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0._id_96D6;
  var_5 = var_4[0];

  if(var_4.size > 1) {
    var_6 = undefined;
    var_6 = var_0 _id_6947(var_2);

    if(isDefined(var_6)) {
      var_5 = var_6;
    } else {
      var_5 = scripts\engine\utility::random(var_4);
    }
  }

  var_7 = undefined;

  if(isDefined(var_1) && var_1) {
    var_7 = self.owner _id_6B1E(_id_6908() + "_location_concat_" + var_5);
  } else if(!isDefined(var_0._id_BE90) && _id_87A0(var_5, self.owner)) {
    var_7 = self.owner _id_6C92(var_5, 0);
  } else {
    var_7 = self.owner _id_6B1E(_id_6908() + "_location_callout_" + var_5);
  }

  if(_func_0205(var_7)) {
    var_3 = var_7;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  _id_96D0(var_0);
  self._id_E05F[self._id_E05F.size] = var_3;
  return 1;
}

_id_109E(var_0, var_1) {
  var_2 = undefined;
  var_3 = "undefined";
  var_4 = scripts\engine\utility::random(["relative", "absolute"]);

  switch (var_4) {
    case "absolute":
      var_5 = _id_69E0(anim.player.origin, var_1.origin);
      var_6 = _id_A5C6(var_5);

      if(var_6 != "impossible" && var_6.size != 2) {
        var_2 = self.owner _id_6903("concat_compass") + var_6;
        break;
      }

      var_3 = "absolute";
    case "relative":
      var_7 = _id_6CE9(var_0);
      var_8 = _id_69E1(var_7, var_0.origin, var_1.origin);
      var_9 = int(var_8);

      if(scripts\engine\utility::cointoss()) {
        if(var_9 >= 2 && var_9 < 5) {
          var_2 = self.owner _id_6903("concat_right");
          break;
        } else if(var_9 >= 8 && var_9 < 11) {
          var_2 = self.owner _id_6903("concat_left");
          break;
        } else {}
      } else if(randomint(3) == 1) {
        var_10 = _id_69E9(var_0.origin, var_1.origin);
        var_2 = self.owner _id_6903("concat_dist") + var_10;
        break;
      } else if(randomint(3) == 1) {
        var_11 = _id_69D9(anim.player.origin, var_1.origin);

        if(var_11 >= 20 && var_11 <= 60) {
          var_2 = self.owner _id_6903("concat_elev") + var_11;
          break;
        }

        var_3 = "elevation";
      } else if(self.owner._id_10691 != "fsa" && self.owner._id_10691 != "fsafemale") {
        var_2 = self.owner _id_6903("concat_clock") + var_8;
        break;
      }
  }

  if(isDefined(var_2)) {
    self._id_E05F[self._id_E05F.size] = var_2;
  } else {
    _id_2376("Missing concat direction: " + var_3);
  }
}

_id_2376(var_0) {}

_id_2373(var_0) {}

_id_109F(var_0) {
  var_1 = "";
  var_2 = undefined;

  if(var_0 scripts\anim\utility_common::_id_FF1B()) {
    var_1 = "_rpg";
  }

  if(var_0 _id_2436()) {
    var_1 = "_sniper";
  }

  var_2 = self.owner _id_6903("concat_target") + var_1;
  self._id_E05F[self._id_E05F.size] = var_2;
}

_id_2436() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(isPlayer(self)) {
    return 0;
  }

  if(!isDefined(self._id_04F6)) {
    return 0;
  }

  return scripts\anim\utility_common::_id_8A44(self._id_04F6);
}

_id_87A1(var_0) {
  return issubstr(var_0, "_report");
}

_id_87A0(var_0, var_1) {
  if(issubstr(var_0, "_qa") && _func_0205(var_0)) {
    return 1;
  }

  var_2 = var_1 _id_6C92(var_0, 0);

  if(_func_0205(var_2)) {
    return 1;
  }

  return 0;
}

_id_6B1E(var_0) {
  var_1 = undefined;

  if(self == anim.player) {
    var_1 = "UN_plr_";
    var_1 = var_1 + var_0;
  } else {
    if(_id_6908() == "combat") {
      var_1 = _id_2421();
    } else {
      var_1 = _id_2421("stealth");
    }

    var_1 = var_1 + var_0;
  }

  return var_1;
}

_id_6C92(var_0, var_1) {
  var_2 = _id_6B1E(_id_6908() + "_location_callout_" + var_0);
  var_2 = var_2 + ("_qa" + var_1);
  return var_2;
}

_id_D5D9(var_0) {
  anim._id_90A4[self.team] = var_0;
  anim._id_90A5[self.team] = gettime();
}

_id_7EA8(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_10C1("reloading", var_0);
  var_1 _id_B8B7(var_2, self);
}

_id_7EA9(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_10C1("suppressed", var_0);
  var_1 _id_B8B7(var_2, self);
}

_id_7EA6(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();

  if(var_0 == "grenade" || var_0 == "shock" || var_0 == "ant" || var_0 == "seek") {
    var_2._id_9BA1 = 1;
  }

  var_2 _id_10C1("incoming", var_0);
  var_1 _id_B8B7(var_2, self);
}

_id_7EA4(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_10C1(var_0);
  var_1 _id_B8B7(var_2, self);
}

_id_7EA7(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = var_1 _id_3FAC();
  var_2 _id_10C1("killfirm", var_0, self._id_413B._id_F15D);
  var_1 _id_B8B7(var_2, self);
}

_id_10C1(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = "";
  } else {
    var_2 = "_" + var_2;
  }

  if(!issubstr(var_1, "weapon")) {
    var_0 = "inform_" + var_0;
  } else {
    var_0 = "";
  }

  var_3 = self.owner _id_6903(var_0 + var_1 + var_2);
  self._id_E05F[self._id_E05F.size] = var_3;
}

_id_6903(var_0) {
  var_1 = undefined;
  var_2 = _id_2421();

  switch (var_0) {
    case "check_fire":
      var_1 = var_2 + "response_check_fire";
      break;
    case "concat_clock":
      var_1 = var_2 + _id_6908() + "_concat_clock_";
      break;
    case "concat_compass":
      var_1 = var_2 + _id_6908() + "_concat_compass_";
      break;
    case "concat_dist":
      var_1 = var_2 + _id_6908() + "_concat_dist_";
      break;
    case "concat_elev":
      var_1 = var_2 + _id_6908() + "_concat_elev_";
      break;
    case "concat_left":
      var_1 = var_2 + _id_6908() + "_concat_left";
      break;
    case "concat_right":
      var_1 = var_2 + _id_6908() + "_concat_right";
      break;
    case "concat_center":
      var_1 = var_2 + _id_6908() + "_concat_center";
      break;
    case "concat_target":
      var_1 = var_2 + _id_6908() + "_concat_target";
      break;
    case "contact_dist":
      var_1 = var_2 + "contact_dist_";
      break;
    case "contact_elev":
      var_1 = var_2 + "contact_elev_";
      break;
    case "contact_movement_group":
      var_1 = var_2 + "contact_movement_group";
      break;
    case "exposed_acquired":
      var_1 = var_2 + "exposed_acquired";
      break;
    case "exposed_breaking":
      var_1 = var_2 + "exposed_breaking";
      break;
    case "exposed_movement":
      var_1 = var_2 + "exposed_movement";
      break;
    case "exposed_movement_group":
      var_1 = var_2 + "exposed_movement_group";
      break;
    case "exposed_open":
      var_1 = var_2 + "exposed_open";
      break;
    case "inform_grenade":
    case "inform_frag":
      var_1 = var_2 + "inform_grenade";
      break;
    case "inform_incoming_grenade":
      var_1 = var_2 + "inform_incoming_grenade";
      break;
    case "inform_killfirm_soldier":
    case "inform_killfirm_juggernaut":
      var_1 = var_2 + "inform_killfirm_soldier";
      break;
    case "inform_molotov":
      var_1 = var_2 + "inform_molotov";
      break;
    case "inform_reloading":
      var_1 = var_2 + "inform_reloading";
      break;
    case "inform_taking_fire":
      var_1 = var_2 + "inform_taking_fire";
      break;
    case "location_response":
      var_1 = var_2 + _id_6908() + "_location_resp";
      break;
    case "order_coverme":
      var_1 = var_2 + "order_coverme";
      break;
    case "order_movecombat":
      var_1 = var_2 + "order_move_combat";
      break;
    case "order_movenoncombat":
      var_1 = var_2 + "order_move_noncombat";
      break;
    case "order_suppress":
      var_1 = var_2 + "order_suppress";
      break;
    case "reaction_casualty":
      var_1 = var_2 + "reaction_casualty";
      break;
    case "reaction_hostile_burst":
      var_1 = var_2 + "reaction_hostile_burst";
      break;
    case "response_ack_affirm":
      var_1 = var_2 + "response_ack_affirm";
      break;
    case "response_threat_affirm":
      var_1 = var_2 + "response_threat_affirm";
      break;
    case "response_threat_neg":
      var_1 = var_2 + "response_threat_neg";
      break;
    case "taunt":
      var_1 = var_2 + "taunt";
      break;
    case "threat_callout_acquired":
      var_1 = var_2 + "acquired_";
      break;
    case "threat_callout_cardinal":
      var_1 = var_2 + "cardinal_";
      break;
    case "threat_callout_contactclock":
      var_1 = var_2 + "contact_clock_";
      break;
    case "threat_callout_sighted":
      var_1 = var_2 + "sighted_";
      break;
    case "threat_callout_targetclock":
      var_1 = var_2 + "target_clock_";
      break;
    case "threat_callout_targetclock_high":
      var_1 = var_2 + "target_clock_high_";
      break;
    default:
  }

  return var_1;
}

_id_B8C5() {
  self endon("death");
  self endon("removed from battleChatter");
  self._id_413B = self._id_2359._id_3420["reaction"];
  var_0 = self._id_2359._id_3420["reaction"]._id_C099;
  var_1 = self._id_2359._id_3420["reaction"]._id_02D0;
  anim thread _id_96ED(self, "reaction");

  if(isDefined(self._id_0B67)) {
    self._id_0B67._id_235B = undefined;
  }

  var_2 = self._id_2359._id_3420["reaction"]._id_56C8;

  switch (var_2) {
    case "underfire":
    case "maneuver":
    case "danger":
    case "casualty":
    case "movement":
      _id_C089(var_0, var_1, var_2);
      break;
    case "taunt":
      _id_C08D(var_0, var_1, var_2);
      break;
    case "friendlyfire":
      _id_C08A(var_0, var_1, var_2);
      break;
    case "takingfire":
      _id_C08C(var_0, var_1, var_2);

      if(scripts\engine\utility::cointoss()) {
        var_3 = _id_6CF0(64, 1024, "response");

        if(isDefined(var_3)) {
          if(scripts\engine\utility::cointoss()) {
            if(var_3 _id_31C0("reaction", "ask_ok", 1.0)) {
              var_3 _id_070B::_id_111E("ask_ok", undefined, self, 1.0);
            }
          } else
            var_3 _id_070B::_id_1124("covering", "fire", self, 1.0);
        }
      }

      break;
    case "ask_ok":
      _id_C6D3(var_0, "ask", "ok");
      var_3 = _id_6CF0(64, 1024, "response");

      if(isDefined(var_3)) {
        var_3 _id_070B::_id_1124("im", "ok", self, 1.0);
      }

      break;
  }

  if(isDefined(self._id_0B67)) {
    self._id_0B67._id_235B = undefined;
  }

  self notify("done speaking");
}

_id_C6D3(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 _id_3FAC();
  var_4 _id_1123(var_1, var_2);
  var_3 _id_B8B7(var_4, self);
}

_id_1123(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = self.owner _id_6903("response_" + var_0 + var_1);
  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_C089(var_0, var_1, var_2) {
  if(isDefined(var_0) && !scripts\engine\trace::_id_30F5(var_0.origin)) {
    return;
  }
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 _id_3FAC();
  var_4 _id_111D("casualty");
  var_3 _id_B8B7(var_4, self);
}

_id_111D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = self.owner _id_6903("reaction_" + var_0 + var_1);
  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_C08D(var_0, var_1, var_2) {
  var_3 = self;
  self endon("death");
  self endon("removed from battleChatter");
  var_4 = var_3 _id_3FAC();

  if(isDefined(var_1) && var_1 == "hostileburst") {
    var_4 _id_10BB();
  } else {
    var_4 _id_1143("taunt");
  }

  var_3 _id_B8B7(var_4, self);
}

_id_10BB() {
  var_0 = self.owner _id_6903("reaction_hostile_burst");

  if(_func_0205(var_0)) {
    self._id_E05F[self._id_E05F.size] = var_0;
  }

  return 1;
}

_id_1143(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = self.owner _id_6903("taunt");
  self._id_E05F[self._id_E05F.size] = var_2;
  return 1;
}

_id_C08A(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 _id_3FAC();
  var_4 _id_109A();
  var_3 _id_B8B7(var_4, self);
}

_id_C08C(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = var_3 _id_3FAC();
  var_4 _id_1140();
  var_3 _id_B8B7(var_4, self);
}

_id_109A() {
  var_0 = self.owner _id_6903("check_fire");
  self._id_E05F[self._id_E05F.size] = var_0;
  return 1;
}

_id_1140() {
  var_0 = self.owner _id_6903("inform_taking_fire");
  self._id_E05F[self._id_E05F.size] = var_0;
  return 1;
}

_id_6CAE() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "custom";
  var_0[1] = "response";
  var_0[2] = "order";
  var_0[3] = "threat";
  var_0[4] = "inform";
  var_0[5] = "stealth";

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(self._id_2359._id_3420[var_0[var_3 - 1]]._id_BD27 < self._id_2359._id_3420[var_0[var_3]]._id_BD27) {
        var_4 = var_0[var_3 - 1];
        var_0[var_3 - 1] = var_0[var_3];
        var_0[var_3] = var_4;
      }
    }
  }

  var_5 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = _id_6A1B(var_0[var_2]);

    if(var_6 == " valid" && !var_5) {
      var_5 = 1;
      var_1[var_2] = "g " + var_0[var_2] + var_6 + " " + self._id_2359._id_3420[var_0[var_2]]._id_BD27;
      continue;
    }

    if(var_6 == " valid") {
      var_1[var_2] = "y " + var_0[var_2] + var_6 + " " + self._id_2359._id_3420[var_0[var_2]]._id_BD27;
      continue;
    }

    if(self._id_2359._id_3420[var_0[var_2]]._id_57AC == 0) {
      var_1[var_2] = "b " + var_0[var_2] + var_6 + " " + self._id_2359._id_3420[var_0[var_2]]._id_BD27;
      continue;
    }

    var_1[var_2] = "r " + var_0[var_2] + var_6 + " " + self._id_2359._id_3420[var_0[var_2]]._id_BD27;
  }

  return var_1;
}

_id_6A1B(var_0) {
  var_1 = "";

  if(self._id_E478._id_892D[var_0]) {
    var_1 = var_1 + " playing";
  }

  if(gettime() > self._id_2359._id_3420[var_0]._id_57AC) {
    var_1 = var_1 + " expired";
  }

  if(gettime() < self._id_E478._id_A4D1[var_0]) {
    var_1 = var_1 + " cantspeak";
  }

  if(var_1 == "") {
    var_1 = " valid";
  }

  return var_1;
}

_id_44EF() {
  if(!isalive(self)) {
    return;
  }
  if(getDvar("#x327fb6f536402b531") != self.team && getDvar("#x327fb6f536402b531") != "all") {
    return;
  }
  self endon("death");
  self notify("debugPrintEvents");
  self endon("debugPrintEvents");
  var_0 = _id_6CAE();
  var_1["g"] = (0, 1, 0);
  var_1["y"] = (1, 1, 0);
  var_1["r"] = (1, 0, 0);
  var_1["b"] = (0, 0, 0);

  for(;;) {
    var_2 = self _meth_8176() + (0, 0, 10);

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + (0, 0, 5);
    }

    wait 0.05;
  }
}

_id_44F3() {
  if(getDvar("#x37c951c52f57f6df0") == "on") {
    thread _id_BD1E("response");
  }

  if(getDvar("#x34c0590180e7b267b") == "on") {
    thread _id_BD1E("threat");
  }

  if(getDvar("#x3ab2ff9ca52f2a7f6") == "on") {
    thread _id_BD1E("inform");
  }

  if(getDvar("#x31586e4cc3324d045") == "on") {
    thread _id_BD1E("order");
  }

  if(getDvar("#x3b14ac0ddef858cea") == "on") {
    thread _id_BD1E("stealth");
  }
}

_id_BD1E(var_0) {
  var_1 = gettime();

  if(self._id_2359._id_3420[var_0]._id_57AC > 0 && !isDefined(self._id_2359._id_3420[var_0]._id_BD14)) {
    if(var_1 > self._id_2359._id_3420[var_0]._id_57AC) {} else {}

    self._id_2359._id_3420[var_0]._id_BD14 = 1;
  }
}

_id_6908() {
  if(isDefined(self._id_5D9A) && [[self._id_5D9A]]()) {
    if(isDefined(self._id_015B) && self._id_015B == "alert") {
      return "alert";
    } else {
      return "idle";
    }
  } else if(isDefined(self._id_5D9C) && [[self._id_5D9C]]())
    return "investigate";
  else if(isDefined(self._id_5D99) && [[self._id_5D99]]()) {
    return "hunt";
  } else if(isDefined(self._id_5D98) && [[self._id_5D98]]()) {
    return "combat";
  } else {
    return "combat";
  }
}

_id_D172(var_0, var_1) {
  level._id_2359[var_0] = var_1;
  _id_FB3B();
}

_id_FB3B() {}

_id_243C() {
  self endon("death");
}

_id_6B6E() {
  if(_id_53F4()) {
    var_0 = self._id_135F;
  } else if(self.team == "allies") {
    var_0 = self.name;
  } else {
    var_0 = undefined;
  }

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = strtok(var_0, " ");

  if(var_1.size < 2) {
    return var_0;
  }

  return var_1[1];
}

_id_895C() {
  var_0 = getrank();

  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant") {
    return 1;
  }

  return 0;
}

_id_2457() {
  var_0 = getdvarint("#x3c23f48a9e29249ee");

  for(;;) {
    var_1 = getdvarint("#x3c23f48a9e29249ee");

    if(var_1 != var_0) {
      switch (var_1) {
        case 1:
          if(!anim._id_341F) {
            _id_523A();
          }

          break;
        case 0:
          if(anim._id_341F) {
            _id_4A81();
          }

          break;
      }

      var_0 = var_1;
    }

    wait 1.0;
  }
}

_id_523A() {
  _id_7EFF();
  anim.player thread _id_070B::_id_1174();
  var_0 = _func_0070();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] _id_070B::_id_1174();
  }
}

_id_4A81() {
  if(!isDefined(anim._id_341F)) {
    return;
  }
  _id_DD09();
  var_0 = _func_0070();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]._id_E478) && var_0[var_1]._id_E478._id_341F) {
      var_0[var_1]._id_E478 _id_DD0B();
    }

    var_0[var_1] _id_070B::_id_C4BA();
  }
}

_id_DD09() {
  anim._id_3DAA = undefined;
  anim._id_56C9 = undefined;
  anim._id_56B2 = undefined;
  anim._id_56C9 = undefined;
  anim._id_56BA = undefined;
  anim._id_56B6 = undefined;
  anim._id_A243 = undefined;
  anim._id_CF6F = undefined;
  anim._id_2454 = undefined;
  anim._id_96D9 = undefined;
  anim._id_FE49 = undefined;
  anim._id_5CE0 = undefined;
  anim._id_90A4 = undefined;
  anim._id_90A5 = undefined;
  anim._id_901E = undefined;
  anim._id_901C = undefined;
  anim._id_901D = undefined;
  anim._id_341F = 0;
  anim.player._id_341F = 0;
  level._id_2359 = undefined;
  anim._id_2447 = undefined;

  for(var_0 = 0; var_0 < anim._id_E48C.size; var_0++) {
    if(anim._id_E48D[var_0] != "::init_squadBattleChatter") {
      continue;
    }
    if(var_0 != anim._id_E48C.size - 1) {
      anim._id_E48C[var_0] = anim._id_E48C[anim._id_E48C.size - 1];
      anim._id_E48D[var_0] = anim._id_E48D[anim._id_E48D.size - 1];
    }

    anim._id_E48C[anim._id_E48C.size - 1] = undefined;
    anim._id_E48D[anim._id_E48D.size - 1] = undefined;
  }

  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

_id_DD0B() {
  var_0 = self;
  var_0._id_A798 = undefined;
  var_0._id_9CA3 = undefined;
  var_0._id_A4D0 = undefined;
  var_0._id_A4D1 = undefined;
  var_0._id_A4E4 = undefined;
  var_0._id_892D = undefined;
  var_0._id_59EF = undefined;
  var_0._id_59F0 = undefined;

  for(var_1 = 0; var_1 < var_0._id_9DAF.size; var_1++) {
    var_0._id_9DAF[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0._id_9DB3.size; var_1++) {
    var_0._id_9DB4[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0._id_E4B3.size; var_1++) {
    var_0._id_E4B3[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < anim._id_E496.size; var_1++) {
    var_0 _id_DD0C(anim._id_E496[var_1]._id_E4A3);
  }

  var_0._id_341F = 0;
}

_id_DD0C(var_0) {
  self._id_E49D[var_0]._id_2F62 = undefined;
  self._id_E49D[var_0]._id_5BCA = undefined;
  self._id_E49D[var_0]._id_8FB2 = undefined;
}

getrank() {
  return self._id_136B;
}

_id_B9B9(var_0) {
  return scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0, 0.766);
}