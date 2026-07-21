/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\vehicle_omnvar_utility.gsc
****************************************************/

vehomn_init() {
  var_0 = spawnStruct();
  level.vehicle._id_11FD0 = var_0;
  var_0.vehicledata = [];
}

vehomn_setvehicle(var_0, var_1) {
  var_2 = _id_1427E(var_0);
  var_3 = var_2.id;

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_5 in var_1) {
        if(isDefined(var_5) && isPlayer(var_5))
          var_5 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", var_3);
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", var_3);
  }
}

vehomn_setcurrentseat(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_0)) {
    var_4 = _id_1427E(var_0);

    if(isDefined(var_1))
      var_3 = var_4.seatids[var_1];
  }

  var_2 setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", var_3);
}

vehomn_setnextseat(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_1)) {
    var_4 = _id_1427E(var_0);
    var_3 = var_4.seatids[var_1];
  }

  var_2 setclientomnvar("_encstr_B1F011E0EF178B8BBAE118951E53B793956770", var_3);
}

vehomn_setseatentity(var_0, var_1, var_2, var_3) {
  var_4 = -1;

  if(isDefined(var_0)) {
    var_5 = _id_1427E(var_0);

    if(isDefined(var_1))
      var_4 = var_5.seatids[var_1];
  }

  var_6 = undefined;

  switch (var_4) {
    case 0:
      var_6 = "_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81";
      break;
    case 1:
      var_6 = "_encstr_BA3C1265BBE6D35FD10102DAF833D247789DC7B9";
      break;
    case 2:
      var_6 = "_encstr_B13C127DDBF1938723F6D21A59858B0E1099DFA2";
      break;
    case 3:
      var_6 = "_encstr_A23C12CD2C819DC1681F2048C7353BEBFA135076";
      break;
    case 4:
      var_6 = "_encstr_8D3C128564C9D5995857581B9F7DF33302CB68AD";
      break;
    case 5:
      var_6 = "_encstr_AF3C12AD31C780AD80177808A7075399A003EF52";
      break;
    case 6:
      var_6 = "_encstr_9A3C126F6B18D3D5E84E454EE128087A68B93FEA";
      break;
  }

  var_7 = -1;

  if(isDefined(var_2))
    var_7 = var_2 getentitynumber();

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9))
          var_9 setclientomnvar(var_6, var_7);
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_7);
  }
}

vehomn_clearseatentity(var_0, var_1, var_2) {
  vehomn_setseatentity(var_0, var_1, undefined, var_2);
}

vehomn_sethealthpercent(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3))
          var_3 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", int(var_0));
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", int(var_0));
  }
}

vehomn_clearhealthpercent(var_0) {
  vehomn_sethealthpercent(undefined, var_0);
}

vehomn_showhealth(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2))
          var_2 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 1);
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 1);
  }
}

vehomn_hidehealth(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2))
          var_2 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 0);
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 0);
  }
}

vehomn_clearshowhealth(var_0) {
  if(0)
    vehomn_showhealth(var_0);
  else
    vehomn_hidehealth(var_0);
}

vehomn_settimepercent(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3) && isPlayer(var_3))
          var_3 setclientomnvar("_encstr_ABFD148BF829A69AF37F6B17732D61F850238617F088", int(var_0));
      }
    } else if(isPlayer(var_1))
      var_1 setclientomnvar("_encstr_ABFD148BF829A69AF37F6B17732D61F850238617F088", int(var_0));
  }
}

vehomn_cleartimepercent(var_0) {
  vehomn_settimepercent(undefined, var_0);
}

vehomn_showtime(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2))
          var_2 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 1);
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 1);
  }
}

vehomn_hidetime(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2))
          var_2 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 0);
      }
    } else if(isPlayer(var_0))
      var_0 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 0);
  }
}

vehomn_clearshowtime(var_0) {
  if(0)
    vehomn_showtime(var_0);
  else
    vehomn_hidetime(var_0);
}

vehomn_setfuelpercent(var_0, var_1) {}

vehomn_clearfuelpercent(var_0) {}

vehomn_showfuel(var_0) {}

vehomn_hidefuel(var_0) {}

vehomn_clearshowfuel(var_0) {}

vehomn_setammo(var_0, var_1, var_2, var_3) {
  var_4 = _id_1427E(var_0);
  var_5 = var_4.brtruck_initdialog[var_1];
  var_6 = undefined;

  switch (var_5) {
    case 0:
      var_6 = "_encstr_BD790E1550D8659DFAF15370A5A8AE58";
      break;
    case 1:
      var_6 = "_encstr_87790EAB512798D5FC162740F572C049";
      break;
    case 2:
      var_6 = "_encstr_96790ED596D7ECAC86D758ADD6DBD746";
      break;
  }

  if(!isDefined(var_2))
    var_2 = -1;
  else if(isstring(var_2) && var_2 == "_encstr_8D5609DA3DA4A282035BED")
    var_2 = -2;

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      foreach(var_8 in var_3) {
        if(isDefined(var_8) && isPlayer(var_8))
          var_8 setclientomnvar(var_6, var_2);
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_2);
  }
}

vehomn_clearammo(var_0, var_1, var_2) {
  vehomn_setammo(var_0, var_1, undefined, var_2);
}

vehomn_showammo(var_0, var_1, var_2, var_3) {
  vehomn_setammo(var_0, var_1, var_2, var_3);
}

vehomn_hideammo(var_0, var_1, var_2) {
  vehomn_setammo(var_0, var_1, -1, var_2);
}

vehomn_showwarning(var_0, var_1, var_2) {
  var_3 = _id_1427E(var_2);
  var_4 = var_3._id_14422[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3._id_14426[var_0];

    if(isarray(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 setclientomnvarbit("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", var_4, 1);

          if(isDefined(var_5))
            thread[[var_5]](var_7, "_encstr_84E11F1B60E08B0F18DF1F119DF0D423145E320228CC8F82C9930F1C43989C77CD");
        }
      }
    } else if(isPlayer(var_1)) {
      var_1 setclientomnvarbit("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", var_4, 1);

      if(isDefined(var_5))
        thread[[var_5]](var_1, "_encstr_84E11F1B60E08B0F18DF1F119DF0D423145E320228CC8F82C9930F1C43989C77CD");
    }
  }
}

vehomn_hidewarning(var_0, var_1, var_2) {
  var_3 = _id_1427E(var_2);
  var_4 = var_3._id_14422[var_0];

  if(isDefined(var_1)) {
    var_5 = var_3._id_14424[var_0];

    if(isarray(var_1)) {
      foreach(var_7 in var_1) {
        if(isDefined(var_7) && isPlayer(var_7)) {
          var_7 setclientomnvarbit("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", var_4, 0);

          if(isDefined(var_5))
            thread[[var_5]](var_7, "_encstr_84E11F1B60E08B0F18DF1F119DF0D423145E320228CC8F82C9930F1C43989C77CD");
        }
      }
    } else if(isPlayer(var_1)) {
      var_1 setclientomnvarbit("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", var_4, 0);

      if(isDefined(var_5))
        thread[[var_5]](var_1, "_encstr_84E11F1B60E08B0F18DF1F119DF0D423145E320228CC8F82C9930F1C43989C77CD");
    }
  }
}

vehomn_clearwarnings(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = undefined;

    if(isDefined(var_1))
      var_2 = _id_1427E(var_1, undefined, 1);

    if(isarray(var_0)) {
      foreach(var_4 in var_0) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 setclientomnvar("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", 0);

          if(isDefined(var_2)) {
            foreach(var_6 in var_2._id_14423) {
              if(isDefined(var_6))
                thread[[var_6]](var_4);
            }
          }
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 setclientomnvar("_encstr_B2F40F2BDCD7383D12E74F6B7B5A73A087", 0);

      if(isDefined(var_2)) {
        foreach(var_6 in var_2._id_14423) {
          if(isDefined(var_6))
            thread[[var_6]](var_0);
        }
      }
    }
  }
}

vehomn_setrotation(var_0, var_1, var_2, var_3) {
  var_4 = _id_1427E(var_0);
  var_5 = var_4._id_12DA2[var_1];
  var_6 = undefined;

  switch (var_5) {
    case 0:
      var_6 = "_encstr_92B811EAA5FAECCA0DEB19ACEC27CA566EBE0C";
      break;
    case 1:
      var_6 = "_encstr_BEB811C0FAB99DD9DBDFB53DFF6B01731A216A";
      break;
  }

  if(!isDefined(var_2))
    var_2 = 0;

  if(isDefined(var_3)) {
    var_7 = var_2 - floor(var_2);

    if(var_7 >= 0.5)
      var_2 = ceil(var_2);
    else
      var_2 = floor(var_2);

    if(isarray(var_3)) {
      foreach(var_9 in var_3) {
        if(isDefined(var_9) && isPlayer(var_9))
          var_9 setclientomnvar(var_6, var_2);
      }
    } else if(isPlayer(var_3))
      var_3 setclientomnvar(var_6, var_2);
  }
}

vehomn_clearrotation(var_0, var_1, var_2) {
  vehomn_setrotation(var_0, var_1, undefined, var_2);
}

_id_14281(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("_encstr_93EA197380A0FF6265109D15E5338A91A9305FBF38981C5B4F9162");
          var_2._id_14284 = "_encstr_BD1805CB69C063";
          var_2 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 1);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 notify("_encstr_93EA197380A0FF6265109D15E5338A91A9305FBF38981C5B4F9162");
      var_0._id_14284 = "_encstr_BD1805CB69C063";
      var_0 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 1);
    }
  }
}

_id_14280(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 notify("_encstr_93EA197380A0FF6265109D15E5338A91A9305FBF38981C5B4F9162");
          var_2._id_14284 = "_encstr_BECC055CF3811A";
          var_2 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 notify("_encstr_93EA197380A0FF6265109D15E5338A91A9305FBF38981C5B4F9162");
      var_0._id_14284 = "_encstr_BECC055CF3811A";
      var_0 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
    }
  }
}

_id_1427B(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2))
          thread _id_1427C(var_2);
      }
    } else if(isPlayer(var_0))
      thread _id_1427C(var_0);
  }
}

_id_1427C(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_93EA197380A0FF6265109D15E5338A91A9305FBF38981C5B4F9162");

  if(!isDefined(var_0._id_14284) || var_0._id_14284 != "_encstr_BECC055CF3811A" && var_0._id_14284 != "_encstr_96A30882C9D57F3D5811") {
    var_0._id_14284 = "_encstr_96A30882C9D57F3D5811";
    var_0 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 2);
    wait 3;
    thread _id_14280(var_0);
  }
}

_id_14278(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2._id_14284 = undefined;
          var_2 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
        }
      }
    } else if(isPlayer(var_0)) {
      var_0 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
      var_0._id_14284 = undefined;
    }
  }
}

_id_1427A(var_0) {
  return !isDefined(var_0._id_14284) || var_0._id_14284 == "_encstr_96A30882C9D57F3D5811" || var_0._id_14284 == "_encstr_BECC055CF3811A";
}

_id_1427D() {
  return level.vehicle._id_11FD0;
}

_id_1427E(var_0, var_1, var_2) {
  var_3 = _id_1427D();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.seatids = [];
      var_4.brtruck_initdialog = [];
      var_4._id_12DA2 = [];
      var_4._id_14422 = [];
      var_4._id_14426 = [];
      var_4._id_14424 = [];
      var_4._id_14423 = [];
      var_4._id_12DA3 = [];
      var_4.id = undefined;
      var_4._id_14422["_encstr_B8310C70ED636AC7A8A7CC6A8F88"] = 1;
      var_4._id_14422["_encstr_A3FA0FA331A28318788F91DA3F678A5067"] = 2;
      var_4._id_14422["_encstr_BABE10DAA5DC9B2DC62B52B9B17BDAD2DC3B"] = 4;
      var_4._id_14422["_encstr_82E411B6F6D9565B95E68E114B9BB026D8AC23"] = 3;
    } else if(!istrue(var_2)) {}
  }

  return var_4;
}

_id_14279(var_0, var_1, var_2) {
  var_3 = _id_1427E(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_3.seatids = [];
    var_3.brtruck_initdialog = [];
    var_3._id_12DA2 = [];
    var_3._id_14422 = [];
    var_3._id_14426 = [];
    var_3._id_14424 = [];
    var_3._id_14423 = [];
    var_3.id = undefined;
  }

  return var_3;
}

vehomn_clearall(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0)
    vehomn_clearallinternal(var_3, var_1);
  } else
    vehomn_clearallinternal(var_0, var_1);
}

vehomn_clearallinternal(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
    var_0 setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", -1);
    var_0 setclientomnvar("_encstr_B1F011E0EF178B8BBAE118951E53B793956770", -1);
    var_0 setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", -1);
    var_0 setclientomnvar("_encstr_BA3C1265BBE6D35FD10102DAF833D247789DC7B9", -1);
    var_0 setclientomnvar("_encstr_B13C127DDBF1938723F6D21A59858B0E1099DFA2", -1);
    var_0 setclientomnvar("_encstr_A23C12CD2C819DC1681F2048C7353BEBFA135076", -1);
    var_0 setclientomnvar("_encstr_8D3C128564C9D5995857581B9F7DF33302CB68AD", -1);
    var_0 setclientomnvar("_encstr_AF3C12AD31C780AD80177808A7075399A003EF52", -1);
    var_0 setclientomnvar("_encstr_9A3C126F6B18D3D5E84E454EE128087A68B93FEA", -1);
    var_0 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", 0);
    var_0 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 0);
    var_0 setclientomnvar("_encstr_ABFD148BF829A69AF37F6B17732D61F850238617F088", 0);
    var_0 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 0);
    var_0 setclientomnvar("_encstr_BD790E1550D8659DFAF15370A5A8AE58", -1);
    var_0 setclientomnvar("_encstr_87790EAB512798D5FC162740F572C049", -1);
    vehomn_clearwarnings(var_0, var_1);
    var_0 setclientomnvar("_encstr_92B811EAA5FAECCA0DEB19ACEC27CA566EBE0C", 0);
    var_0 setclientomnvar("_encstr_BEB811C0FAB99DD9DBDFB53DFF6B01731A216A", 0);
    _id_14278(var_0);
  }
}

vehomn_updateomnvarsonseatenter(var_0, var_1, var_2, var_3) {
  vehomn_setvehicle(var_0.vehiclename, var_3);
  vehomn_setcurrentseat(var_0.vehiclename, var_2, var_3);
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(isDefined(var_1))
    vehomn_clearseatentity(var_0.vehiclename, var_1, var_4);
  else {
    foreach(var_7, var_6 in var_4) {
      if(isDefined(var_6) && var_6 != var_3)
        vehomn_setseatentity(var_0.vehiclename, var_7, var_6, var_3);
    }
  }

  vehomn_setseatentity(var_0.vehiclename, var_2, var_3, var_4);
  vehomn_updatenextseatomnvars(var_0);
  vehomn_updateomnvarsondamage(var_0);
  _id_14281(var_3);
  _id_140FF(var_0, var_3, var_2);
  var_8 = _id_1427E(var_0.vehiclename);

  if(scripts\cp_mp\utility\weapon_utility::islockedonto(var_0)) {
    if(isDefined(var_8._id_14422["_encstr_A3FA0FA331A28318788F91DA3F678A5067"]))
      vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", var_3, var_0.vehiclename);
  }

  if(scripts\cp_mp\utility\weapon_utility::hasincoming(var_0)) {
    if(isDefined(var_8._id_14422["_encstr_BABE10DAA5DC9B2DC62B52B9B17BDAD2DC3B"]))
      vehomn_showwarning("_encstr_BABE10DAA5DC9B2DC62B52B9B17BDAD2DC3B", var_3, var_0.vehiclename);
  }

  if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed(var_0)) {
    if(isDefined(var_8._id_14422["_encstr_82E411B6F6D9565B95E68E114B9BB026D8AC23"]))
      vehomn_showwarning("_encstr_82E411B6F6D9565B95E68E114B9BB026D8AC23", var_3, var_0.vehiclename);
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_1415B()) {
    if(isDefined(var_8._id_14422["_encstr_B8310C70ED636AC7A8A7CC6A8F88"]))
      vehomn_showwarning("_encstr_B8310C70ED636AC7A8A7CC6A8F88", var_3, var_0.vehiclename);
  }
}

vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    if(isDefined(var_1)) {
      vehomn_clearall(var_3, var_0.vehiclename);

      if(isDefined(var_0)) {
        var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
        vehomn_clearseatentity(var_0.vehiclename, var_1, var_4);
        vehomn_updatenextseatomnvars(var_0);
      }
    }
  }
}

vehomn_updateomnvarsondamage(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 0);

  if(!isDefined(var_1))
    var_3 = int(clamp(var_0.health / var_0.maxhealth * 100, 0, 100));
  else
    var_3 = int(clamp((var_0.health - var_1.damage) / var_0.maxhealth * 100, 0, 100));

  vehomn_showhealth(var_2);
  vehomn_sethealthpercent(var_3, var_2);
}

_id_14282(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = spawnStruct();

  var_2 = _id_1427E(var_0.vehiclename, undefined, 1);
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(isDefined(var_3) && isDefined(var_2)) {
    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_6, var_5 in var_3) {
        if(isDefined(var_5) && isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive())
          _id_140FF(var_0, var_5, var_6, var_1);
      }
    }
  }
}

_id_140FF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_0, var_1);

  _id_14283(var_0, var_1, var_2, var_3);
}

vehomn_updatenextseatomnvars(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_5, var_3 in var_1) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat(var_0, var_3, var_5);
    vehomn_setnextseat(var_0.vehiclename, var_4, var_3);
  }
}

_id_14283(var_0, var_1, var_2, var_3) {
  var_4 = _id_1427E(var_0.vehiclename);

  if(var_4._id_12DA3.size > 0 && isDefined(var_4._id_12DA3[var_2])) {
    var_5 = 0;

    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_0, var_2))
      var_5 = 1;
    else {
      var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_getcameraforseat(var_0, var_2);

      if(isDefined(var_6) && var_6 != "_encstr_8BBA05185F8B99")
        var_5 = 1;
    }

    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

    if(var_5) {
      if(isDefined(var_0.objweapon)) {
        var_8 = var_4._id_12DA3[var_2][var_0.objweapon.basename];

        if(isDefined(var_8)) {
          var_9 = invertangles(var_1 getplayerangles());
          var_10 = var_0.angles;
          var_11 = combineangles(var_9, var_10);
          var_12 = angleclamp(var_11[1]);
          vehomn_setrotation(var_0.vehiclename, var_8, var_12, var_1);
        }
      }
    } else {}

    var_13 = _id_1427F(var_0, var_3);

    if(isDefined(var_13)) {
      foreach(var_15, var_8 in var_4._id_12DA3[var_2]) {
        var_11 = var_13[var_15];

        if(isDefined(var_11)) {
          var_12 = angleclamp(var_11[1]);
          vehomn_setrotation(var_0.vehiclename, var_8, var_12, var_1);
        }
      }
    }
  }
}

_id_1427F(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_1196A))
    return var_1._id_12DA1;

  var_2 = scripts\cp_mp\vehicles\vehicle::_id_14193(var_0);

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = [];
    var_4 = invertangles(var_0.angles);

    foreach(var_7, var_6 in var_2) {
      if(var_6 scripts\engine\utility::hastag(var_6.model, "_encstr_A14F0AE336178944BA076F41"))
        var_3[var_7] = combineangles(var_4, var_6 gettagangles("_encstr_A14F0AE336178944BA076F41"));
    }

    if(isDefined(var_1))
      var_1._id_12DA1 = var_3;

    return var_3;
  }

  return undefined;
}