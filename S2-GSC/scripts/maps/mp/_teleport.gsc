/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_teleport.gsc
*****************************************/

main() {
  thread _id_5F8E();
}

_id_5F8E() {
  var_0 = common_scripts\utility::_id_46B7("teleport_world_origin", "targetname");
  var_1 = level.gametype;

  if(!var_0.size || !(var_1 == "dom" || var_1 == "ctf" || var_1 == "hp" || var_1 == "undead" || var_1 == "ball")) {
    return;
  }
  common_scripts\utility::flag_init("teleport_setup_complete");
  level._id_9891 = [];
  level._id_9876 = 1;
  level._id_98B7 = 0;
  level._id_98B6 = 0;
  level._id_9888 = 0;
  level._id_988A = 0;
  level._id_9880 = undefined;
  level._id_98A8 = [];
  level._id_98A7 = [];
  level._id_9892 = [];
  level._id_98A1 = [];
  level._id_9898 = level._id_6BAF;
  level._id_6BAF = ::_id_9898;
  level._id_98C4 = ::_id_9881;
  level._id_98C5 = ::_id_9882;
}

_id_988B() {
  level._id_98B3 = [];
  var_0 = common_scripts\utility::_id_46B7("teleport_world_origin", "targetname");

  if(!var_0.size) {
    return;
  }
  level._id_98C1 = [];

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_0165))
      var_2._id_0165 = "zone_" + level._id_98C1.size;

    var_2.name = var_2._id_0165;
    _id_98A0(var_2);
    level._id_9892[var_2.name] = [];
    level._id_98A1[var_2.name] = [];
    level._id_98C1[var_2._id_0165] = var_2;
  }

  var_4 = _getallnodes();

  foreach(var_6 in var_4) {
    var_2 = _id_9879(var_6.origin);
    level._id_9892[var_2.name][level._id_9892[var_2.name].size] = var_6;
  }

  for(var_8 = 0; var_8 < _getzonecount(); var_8++) {
    var_2 = _id_9879(_getzoneorigin(var_8));
    level._id_98A1[var_2.name][level._id_98A1[var_2.name].size] = var_8;
  }

  if(!isDefined(level._id_98C0)) {
    if(isDefined(level._id_98C1["start"]))
      _id_98AF("start");
    else {
      foreach(var_11, var_10 in level._id_98C1) {
        _id_98AF(var_11);
        break;
      }
    }
  }
}

_id_9898() {
  _id_988B();
  var_0 = undefined;
  var_1 = undefined;

  switch (level.gametype) {
    case "dom":
      var_1 = ::_id_9896;
      break;
    case "ctf":
      var_1 = ::_id_9895;
      break;
    case "undead":
    case "hp":
      var_1 = ::_id_9897;
      break;
    default:
      break;
  }

  if(isDefined(var_0))
    level[[var_0]]();

  level[[level._id_9898]]();

  if(isDefined(var_1))
    level[[var_1]]();

  common_scripts\utility::flag_set("teleport_setup_complete");
}

_id_98AB() {
  _id_98AA();
}

_id_98A9() {
  _id_98AA();
}

_id_98AA() {
  foreach(var_1 in level._id_98C1) {
    var_1.closemenu = [];
    var_1._id_8328 = [];
    var_1._id_8329 = [];
  }

  var_3 = getEntArray("sd_bomb_pickup_trig", "targetname");

  foreach(var_5 in var_3) {
    var_6 = _id_9879(var_5.origin);

    if(isDefined(var_6)) {
      var_6.closemenu[var_6.closemenu.size] = var_5;
      _id_9878(var_5, var_6.name);
    }
  }

  var_8 = getEntArray("sd_bomb", "targetname");

  foreach(var_10 in var_8) {
    var_6 = _id_9879(var_10.origin);

    if(isDefined(var_6)) {
      var_6._id_8328[var_6._id_8328.size] = var_10;
      _id_9878(var_10, var_6.name);
    }
  }

  var_12 = getEntArray("bombzone", "targetname");

  foreach(var_14 in var_12) {
    var_6 = _id_9879(var_14.origin);

    if(isDefined(var_6)) {
      var_6._id_8329[var_6._id_8329.size] = var_14;
      _id_9878(var_14, var_6.name);
    }
  }

  var_16 = [];

  foreach(var_1 in level._id_98C1) {
    if(var_1.closemenu.size && var_1.closemenu.size && var_1.closemenu.size)
      var_16[var_16.size] = var_1.name;
  }

  _id_987F(var_16);
  var_19 = level._id_98C1[level._id_98C0];
  _id_98AC(var_19.closemenu);
  _id_98AC(var_19._id_8328);
  _id_98AC(var_19._id_8329);
}

_id_9878(var_0, var_1) {
  if(!_isarray(var_0))
    var_0 = [var_0];

  if(!isDefined(var_1))
    var_1 = "hide_from_getEnt";

  foreach(var_3 in var_0) {
    var_3._id_8063 = var_3.targetname;
    var_3.targetname = var_3.targetname + "_" + var_1;
  }
}

_id_987F(var_0) {
  if(!isDefined(var_0))
    var_0 = getarraykeys(level._id_98C1);

  var_1 = game["teleport_zone_dom"];

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::random(var_0);
    game["teleport_zone_dom"] = var_1;
  }

  _id_98B8(var_1, 0);
  level._id_9876 = 0;
}

_id_98AC(var_0) {
  if(!_isarray(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_8063))
      var_2.targetname = var_2._id_8063;
  }
}

_id_9895() {
  level._id_9880 = ::_id_989A;
}

_id_9897() {
  if(!isDefined(level._id_687F))
    level._id_687F = 5;

  level._id_762C = [];
  level._id_75BF = [];
  level._id_0BCF = level._id_ACB3;

  foreach(var_1 in level._id_ACB3) {
    if(var_1.setmovespeedscale > level._id_687F) {
      level._id_75BF[level._id_75BF.size] = var_1;
      continue;
    }

    level._id_762C[level._id_762C.size] = var_1;
  }

  level._id_ACB3 = level._id_762C;
  level._id_9880 = ::_id_989C;
}

_id_9896() {
  foreach(var_1 in level._id_98C1) {
    var_1._id_3CC5 = [];
    var_1._id_3211 = [];
  }

  level._id_0BCA = level._id_3CC5;

  foreach(var_4 in level._id_3CC5) {
    var_5 = _id_9879(var_4.origin);

    if(isDefined(var_5)) {
      var_4._id_98BF = var_5.name;
      var_5._id_3CC5[var_5._id_3CC5.size] = var_4;
      var_5._id_3211[var_5._id_3211.size] = var_4._id_A222;
    }
  }

  level._id_320A = [];

  foreach(var_1 in level._id_98C1) {
    foreach(var_9 in var_1._id_3CC5) {
      var_10 = spawnStruct();
      var_10._id_9DA5 = var_9.origin;
      var_10._id_A57F = var_9._id_A222._id_A582[0].origin;
      var_10._id_15FA = var_9._id_A222._id_15FA;
      var_10._id_15F9 = var_9._id_A222._id_15F9;
      var_10._id_15FB = var_9._id_A222._id_15FB;
      var_10._id_68E0 = var_9._id_A222._id_28D4;
      var_10._id_68FA = [];

      foreach(var_12 in level._id_985B) {
        var_13 = "objpoint_" + var_12 + "_" + var_9._id_A222._id_37D8;
        var_14 = _id_04EC::_id_45D6(var_13);

        if(isDefined(var_14))
          var_10._id_68FA[var_12] = (var_14.x, var_14.y, var_14._id_01D9);
      }

      var_13 = "objpoint_broadcaster_" + var_9._id_A222._id_37D8;
      var_14 = _id_04EC::_id_45D6(var_13);

      if(isDefined(var_14))
        var_10._id_68FA["broadcaster"] = (var_14.x, var_14.y, var_14._id_01D9);

      level._id_320A[var_1.name][var_9._id_A222.label] = var_10;
    }
  }

  level._id_3CC5 = level._id_98C1[level._id_98C0]._id_3CC5;
  level._id_3211 = level._id_98C1[level._id_98C0]._id_3211;

  foreach(var_1 in level._id_98C1) {
    foreach(var_4 in var_1._id_3CC5) {
      if(var_1.name == level._id_98C0) {
        continue;
      }
      var_4._id_A222._id_A582[0] delete();
      var_4._id_A222 _id_04D1::_id_2D58();
    }
  }

  level._id_9880 = ::_id_989B;
  _id_989B(level._id_98C0);
  level._id_987B = 1;
  level thread _id_987C();
}

_id_987C() {
  while(!isDefined(level._id_19E8))
    waitframe();

  foreach(var_1 in level._id_98C1) {
    foreach(var_3 in var_1._id_3CC5) {
      var_4 = level._id_320A[var_1.name][var_3._id_A222.label];
      var_4._id_671A = var_3._id_671A;

      if(var_1.name != level._id_98C0)
        var_3 delete();
    }
  }
}

_id_9894() {
  level._id_9880 = ::_id_9899;
}

_id_989B(var_0) {
  var_1 = level._id_98C1[level._id_98C0];
  var_2 = level._id_98C1[var_0];

  if(var_0 == level._id_98C0) {
    return;
  }
  foreach(var_4 in level._id_3211) {
    var_4 _id_04D1::_id_86EC("neutral");
    var_4 _id_04D1::set2dicon("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::set2dicon("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::set2dicon("broadcaster", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("broadcaster", "waypoint_captureneutral" + var_4.label, 3);
    var_4._id_3C66 = 1;
  }

  foreach(var_4 in level._id_3CC5) {
    var_7 = level._id_320A[var_0][var_4._id_A222.label];
    var_4.origin = var_7._id_9DA5;
    var_4._id_A222._id_A582[0].origin = var_7._id_A57F;
    var_4._id_A222._id_15FA = var_7._id_15FA;
    var_4._id_A222._id_15F9 = var_7._id_15F9;
    var_4._id_A222 maps\mp\gametypes\dom::_id_A192();
    var_4._id_98BF = var_0;
    var_4._id_671A = var_7._id_671A;

    if(isDefined(var_4._id_A222._id_698A))
      _objective_position(var_4._id_A222._id_698A, var_7._id_68E0);

    if(isDefined(var_4._id_A222._id_698B))
      _objective_position(var_4._id_A222._id_698B, var_7._id_68E0);

    if(isDefined(var_4._id_A222._id_698C))
      _objective_position(var_4._id_A222._id_698C, var_7._id_68E0);

    foreach(var_9 in level._id_985B) {
      var_10 = "objpoint_" + var_9 + "_" + var_4._id_A222._id_37D8;
      var_11 = _id_04EC::_id_45D6(var_10);
      var_11.x = var_7._id_68FA[var_9][0];
      var_11.y = var_7._id_68FA[var_9][1];
      var_11._id_01D9 = var_7._id_68FA[var_9][2];
    }

    var_10 = "objpoint_broadcaster_" + var_4._id_A222._id_37D8;
    var_11 = _id_04EC::_id_45D6(var_10);
    var_11.x = var_7._id_68FA["broadcaster"][0];
    var_11.y = var_7._id_68FA["broadcaster"][1];
    var_11._id_01D9 = var_7._id_68FA["broadcaster"][2];
  }

  maps\mp\gametypes\dom::_id_3CC7();

  foreach(var_15 in level._id_3211) {
    var_16 = var_15.label;

    foreach(var_18 in level._id_98C1["start"]._id_3211) {
      if(var_18.label == var_16)
        var_15.levelflag = var_18.levelflag;
    }
  }

  foreach(var_15 in level._id_3CC5) {
    var_16 = var_15.label;

    foreach(var_23 in level._id_98C1["start"]._id_3CC5) {
      if(var_23.label == var_16)
        var_15.levelflag = var_23.levelflag;
    }
  }
}

_id_9885(var_0, var_1) {
  foreach(var_3 in level._id_98C1[var_1]._id_3CC5) {
    if(var_0._id_A222.label == var_3._id_A222.label)
      return var_3;
  }

  return undefined;
}

_id_989A(var_0) {
  if(game["switchedsides"]) {
    level._id_289D["axis"] = _getent("post_event_capzone_allies", "targetname");
    level._id_289D["allies"] = _getent("post_event_capzone_axis", "targetname");
  } else {
    level._id_289D["allies"] = _getent("post_event_capzone_allies", "targetname");
    level._id_289D["axis"] = _getent("post_event_capzone_axis", "targetname");
  }

  var_1 = [];
  var_1["allies"] = level._id_1FC6["allies"];
  var_1["axis"] = level._id_1FC6["axis"];
  var_2["allies"] = level._id_9853["allies"];
  var_2["axis"] = level._id_9853["axis"];
  var_3["allies"] = level._id_289D["allies"].origin;
  var_3["axis"] = level._id_289D["axis"].origin;

  foreach(var_5 in var_1) {
    var_5 _id_04D1::_id_6497(var_3[var_5._id_6DB2], (0, 0, 85));
    var_5._id_9D65 common_scripts\utility::_id_9D9F();
  }

  foreach(var_8 in level._id_9853) {
    var_8 _id_04D1::_id_6497(var_3[var_8._id_6DB2], (0, 0, 85));

    if(isDefined(var_8.carrier)) {
      var_8 _id_04D1::_id_8A60("any");
      var_8 _id_04D1::set2dicon("friendly", level._id_5014);
      var_8 _id_04D1::playsoundtoteam("friendly", level._id_5015);
      var_8 _id_04D1::set2dicon("enemy", level._id_5011);
      var_8 _id_04D1::playsoundtoteam("enemy", level._id_5012);
      level._id_1FC6[var_8._id_6DB2] _id_04D1::_id_0C30("none");
      level._id_1FC6[var_8._id_6DB2] _id_04D1::_id_8A60("friendly");
      level._id_1FC6[var_8._id_6DB2] _id_04D1::set2dicon("friendly", level._id_5028);
      level._id_1FC6[var_8._id_6DB2] _id_04D1::playsoundtoteam("friendly", level._id_5029);

      if(var_8._id_6DB2 == "allies") {
        level._id_1FC6[var_8._id_6DB2] _id_04D1::set2dicon("broadcaster", level._id_5018);
        level._id_1FC6[var_8._id_6DB2] _id_04D1::playsoundtoteam("broadcaster", level._id_5018, 1);
        continue;
      }

      level._id_1FC6[var_8._id_6DB2] _id_04D1::set2dicon("broadcaster", level._id_5018);
      level._id_1FC6[var_8._id_6DB2] _id_04D1::playsoundtoteam("broadcaster", level._id_5018, 2);
    }
  }

  maps\mp\gametypes\ctf::_id_1FC3();

  foreach(var_5 in var_1)
  var_5._id_9D65 common_scripts\utility::_id_9DA3();
}

_id_989C(var_0) {
  level._id_ACB3 = level._id_75BF;

  if(level._id_7A62 == 0)
    level._id_76EE = level._id_ACB3.size - 1;
  else {
    level._id_ACB9 = [];
    maps\mp\gametypes\hp::_id_8C31();
  }

  _setomnvar("ui_hardpoint_timer", 0);
  level notify("zone_moved");
}

_id_9899(var_0) {
  var_1 = _id_4380(var_0);

  foreach(var_3 in level._id_31F9) {
    var_4 = var_3._id_28D4 + var_1;
    var_5 = _id_9886(var_4);

    if(isDefined(var_5)) {
      var_5._id_5B59 = gettime();
      var_6 = var_5.origin - var_3._id_28D4;
      var_3._id_28D4 = var_3._id_28D4 + var_6;
      var_3._id_9D65.origin = var_3._id_9D65.origin + var_6;
      var_3._id_A582[0].origin = var_3._id_A582[0].origin + var_6;
      var_3._id_A582[1].origin = var_3._id_A582[1].origin + var_6;
      continue;
    }

    var_3 maps\mp\gametypes\conf::_id_7D6F();
  }
}

_id_9886(var_0) {
  var_1 = gettime();
  var_2 = _getnodesinradiussorted(var_0, 300, 0, 200, "Path");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(isDefined(var_4._id_5B59) && var_4._id_5B59 == var_1) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

_id_9879(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_98C1) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_989D(var_0) {
  level._id_98B6 = var_0;
}

_id_989E(var_0) {
  level._id_98B7 = var_0;
}

_id_9889(var_0) {
  level._id_9888 = var_0;
}

_id_98B0(var_0, var_1) {
  level._id_9891[var_0] = var_1;
}

_id_98B2(var_0, var_1) {
  level._id_98A8[var_1] = var_0;
}

_id_98B1(var_0, var_1) {
  level._id_98A7[var_1] = var_0;
}

_id_98A0(var_0) {
  if(isDefined(var_0._id_6C5B) && var_0._id_6C5B) {
    return;
  }
  var_0._id_989F = [];
  var_0._id_989F["none"] = [];
  var_0._id_989F["allies"] = [];
  var_0._id_989F["axis"] = [];
  var_1 = common_scripts\utility::_id_46B7("teleport_zone_" + var_0.name, "targetname");

  if(isDefined(var_0.target)) {
    var_2 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
    var_1 = common_scripts\utility::_id_0F73(var_2, var_1);
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_4._id_0165))
      var_4._id_0165 = "teleport_origin";

    switch (var_4._id_0165) {
      case "teleport_origin":
        var_5 = var_4.origin + (0, 0, 1);
        var_6 = var_4.origin - (0, 0, 250);
        var_7 = bulletTrace(var_5, var_6, 0);

        if(var_7["fraction"] == 1.0) {
          break;
        }

        var_4.origin = var_7["position"];
      case "telport_origin_nodrop":
        if(!isDefined(var_4.setlookatent))
          var_4.setlookatent = "none,axis,allies";

        var_8 = strtok(var_4.setlookatent, ", ");

        foreach(var_10 in var_8) {
          if(!isDefined(var_0._id_989F[var_10])) {
            continue;
          }
          if(!isDefined(var_4.angles))
            var_4.angles = (0, 0, 0);

          var_11 = var_0._id_989F[var_10].size;
          var_0._id_989F[var_10][var_11] = var_4;
        }

        break;
      default:
        break;
    }
  }

  var_0._id_6C5B = 1;
}

_id_98AF(var_0) {
  level._id_98C0 = var_0;

  if(isDefined(level._id_9891[var_0]))
    _id_0472::_id_8A2F(level._id_9891[var_0]);
}

_id_987E(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level._id_98C0;

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_988E))
      var_4._id_988E = "ent_" + var_4 getentitynumber();

    if(!isDefined(level._id_98B3[var_4._id_988E]))
      _id_988C(var_4);

    if(level._id_98B3[var_4._id_988E]._id_AC7C == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_988C(var_0) {
  if(!isDefined(var_0._id_988E))
    var_0._id_988E = "ent_" + var_0 getentitynumber();

  if(isDefined(level._id_98B3[var_0._id_988E])) {
    return;
  }
  var_1 = spawnStruct();
  var_1._id_0186 = var_0;
  var_2 = undefined;

  foreach(var_4 in level._id_98C1) {
    var_5 = distance(var_4.origin, var_0.origin);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_2 = var_5;
      var_1._id_AC7C = var_4.name;
    }
  }

  level._id_98B3[var_0._id_988E] = var_1;
}

_id_988D(var_0) {
  foreach(var_3, var_2 in level._id_98C1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

_id_98B8(var_0, var_1) {
  if(!level._id_9876) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = level._id_98A8[var_0];

  if(isDefined(var_2) && var_1)
    [[var_2]]();

  var_3 = level._id_98C1[level._id_98C0];
  var_4 = level._id_98C1[var_0];

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  if(level._id_988A) {
    _id_98BC(var_0);
    _id_98B9(var_0);
  }

  if(level._id_9888)
    _id_98BB(var_0);

  if(isDefined(level._id_9880))
    [[level._id_9880]](var_0);

  _id_98AF(var_0);
  level notify("teleport_to_zone", var_0);
  var_5 = level._id_98A7[var_0];

  if(isDefined(var_5) && var_1)
    [[var_5]]();

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_teleport"]))
    [[level.bot_funcs["post_teleport"]]]();
}

_id_98B9(var_0) {
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1)
  _id_98BA(var_0, var_3);
}

_id_98BC(var_0) {
  foreach(var_2 in level.players)
  _id_98BA(var_0, var_2);
}

_id_98BA(var_0, var_1) {
  var_2 = level._id_98C1[level._id_98C0];
  var_3 = level._id_98C1[var_0];
  var_4 = gettime();

  if(isPlayer(var_1) && (var_1.sessionstate == "intermission" || var_1.sessionstate == "spectator")) {
    var_5 = getEntArray("mp_global_intermission", "classname");
    var_5 = _id_987E(var_5, var_0);
    var_6 = var_5[0];
    var_1 dontinterpolate();
    var_1 setOrigin(var_6.origin);
    var_1 setplayerangles(var_6.angles);
  } else {
    var_7 = undefined;
    var_8 = var_1.angles;

    if(isPlayer(var_1))
      var_8 = var_1 getplayerangles();

    foreach(var_14, var_10 in var_3._id_989F) {
      var_3._id_989F[var_14] = common_scripts\utility::array_randomize(var_10);

      foreach(var_12 in var_10)
      var_12._id_2307 = 0;
    }

    var_15 = [];

    if(level.teambased) {
      if(isDefined(var_1.team) && isDefined(var_3._id_989F[var_1.team]))
        var_15 = var_3._id_989F[var_1.team];
    } else
      var_15 = var_3._id_989F["none"];

    foreach(var_12 in var_15) {
      if(!var_12._id_2307) {
        var_7 = var_12.origin;
        var_8 = var_12.angles;
        var_12._id_2307 = 1;
        break;
      }
    }

    var_18 = var_3.origin - var_2.origin;
    var_19 = var_1.origin + var_18;

    if(!isDefined(var_7) && level._id_98B7) {
      if(_canspawn(var_19) && !_positionwouldtelefrag(var_19))
        var_7 = var_19;
    }

    if(!isDefined(var_7) && level._id_98B6) {
      var_20 = _getnodesinradiussorted(var_19, 300, 0, 200, "Path");

      for(var_21 = 0; var_21 < var_20.size; var_21++) {
        var_22 = var_20[var_21];

        if(isDefined(var_22._id_5B59) && var_22._id_5B59 == var_4) {
          continue;
        }
        var_12 = var_22.origin;

        if(_canspawn(var_12) && !_positionwouldtelefrag(var_12)) {
          var_22._id_5B59 = var_4;
          var_7 = var_12;
          break;
        }
      }
    }

    if(!isDefined(var_7)) {
      var_1 maps\mp\_utility::_suicide();
      return;
    }

    var_1 cancelmantle();
    var_1 dontinterpolate();
    var_1 setOrigin(var_7);
    var_1 setplayerangles(var_8);
    thread _id_98BD(var_1);
  }
}

_id_98BD(var_0) {
  waitframe();

  if(isDefined(var_0)) {
    var_1 = _id_9879(var_0.origin);

    if(var_1.name != level._id_98C0)
      var_0 maps\mp\_utility::_suicide();
  }
}

_id_4380(var_0) {
  var_1 = level._id_98C1[var_0];
  var_2 = level._id_98C1[level._id_98C0];
  var_3 = var_1.origin - var_2.origin;
  return var_3;
}

_id_98BB(var_0) {}

_id_9893() {
  if(isDefined(self))
    self notify("death");
}

_id_0FB4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::_id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_0F8B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::_id_0F8A(var_0, var_1, var_2, var_3, var_4);
}

_id_9883() {
  return getEntArray("care_package", "targetname");
}

_id_9884() {
  var_0 = [];
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_1B7B))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_98A2(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 300;

  var_2 = var_0.origin;
  var_3 = var_0.origin - (0, 0, var_1);
  var_4 = bulletTrace(var_2, var_3, 0, var_0);

  if(var_4["fraction"] < 1) {
    var_0.origin = var_4["position"];
    return 1;
  } else
    return 0;
}

_id_9873(var_0, var_1) {
  if(_id_987A(var_0)) {
    return;
  }
  _id_9872(var_0, var_1);

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");
    var_3 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
    var_4 = common_scripts\utility::_id_0F73(var_2, var_3);
    common_scripts\utility::_id_0F8A(var_4, ::_id_9873, var_1);
  }
}

_id_98AE(var_0) {
  _id_9873(self, var_0);
}

_id_98AD(var_0) {
  _id_9872(self, var_0);
}

_id_9872(var_0, var_1) {
  if(isDefined(var_0)) {
    if(!_id_987A(var_0)) {
      var_0.origin = var_0.origin + var_1;
      var_0._id_5B59 = gettime();
    }
  }
}

_id_987A(var_0) {
  return isDefined(var_0._id_5B59) && var_0._id_5B59 == gettime();
}

_id_9881() {
  return level._id_9892[level._id_98C0];
}

_id_9882() {
  return level._id_98A1[level._id_98C0];
}