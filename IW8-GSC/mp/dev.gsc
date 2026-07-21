/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\dev.gsc
***********************************************/

init() {}

reflectionprobe_hide_hp() {}

reflectionprobe_hide_front() {}

gotonextspawn() {}

gotoprevspawn() {}

devaliengiveplayersmoney() {}

spam_points_popup() {
  var_0 = ["_encstr_848909BBD3A7526348E8E3", "_encstr_977C08697BE705EAA5E3", "_encstr_B82009D8DBE6D9CDD0B7E8", "_encstr_93150B9B625FB5C8DBEDA79B1B", "_encstr_8E9C0791DB5D26632B", "_encstr_8DA3073A27B483C6CA", "_encstr_AF4006A12DF490AB"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread scripts\mp\rank::scorepointspopup(100);
    thread scripts\mp\rank::scoreeventpopup(var_0[var_1]);
    wait 2.0;
  }
}

devlistinventory() {
  var_0 = getDvar("_encstr_8BF713EB49383F90F1501B0702F0986B284D3026BF", "_encstr_B40101");

  if(var_0 != "_encstr_B40101") {
    var_1 = devfindhost();

    if(!isDefined(var_1)) {
      return;
    }
    var_2 = undefined;
    var_3 = undefined;
    var_4 = 0;

    if(var_0 == "_encstr_AF1904A7F929") {
      var_3 = "_encstr_88F80CF641FBE207A973873A6853";
      var_2 = var_1 getweaponslistall();
    } else if(var_0 == "_encstr_8FAB0FD0586935900A9746674336CD68EB") {
      var_3 = "_encstr_8C770FE693A84A6218C1A2C7DBB7FB9F90";
      var_4 = 1;
      var_2 = [var_1 getcurrentweapon()];
    } else {
      var_3 = var_0 + "_encstr_8B200BE92452F3F9C81B8FE813";
      var_2 = var_1 getweaponslist(var_0);
    }

    var_1 devprintweaponlist(var_2, var_3, var_4);
  }
}

devprintweaponlist(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_4 in var_0) {
      var_5 = self getweaponammoclip(var_4);
      var_6 = self getweaponammostock(var_4);
      var_7 = "_encstr_B8070386C0" + createheadicon(var_4) + "_encstr_974C0246" + var_5 + "_encstr_874C029E" + var_6;

      if(var_2)
        iprintlnbold(var_7);
    }
  } else {}
}

devgivesuperthink() {
  for(;;) {
    var_0 = getDvar("_encstr_97560E93CF6317217418825F9510E5F6", "_encstr_B40101");

    if(var_0 != "_encstr_B40101") {
      foreach(var_2 in level.players)
      var_2 scripts\mp\supers::givesuper(var_0, 0, 1);
    }

    if(getdvarint("_encstr_B234198337602137450B5A33F69E93E5D8B1371B57E0B5536003E2", 0) != 0) {
      foreach(var_2 in level.players) {
        if(isbot(var_2)) {
          continue;
        }
        if(!isDefined(var_2 scripts\mp\supers::getcurrentsuper())) {
          continue;
        }
        if(var_2 scripts\mp\supers::issupercharging())
          var_2 scripts\mp\supers::givesuperpoints(var_2 scripts\mp\supers::getsuperpointsneeded() * 0.25);
      }
    }

    wait 0.25;
  }
}

devgivefieldupgradethink() {
  for(;;) {
    var_0 = getDvar("_encstr_9B1615E28EA5B12F60E0CFFB20D9ECCA339F6F5A6721AA", "_encstr_B40101");

    if(var_0 != "_encstr_B40101") {
      foreach(var_2 in level.players)
      var_2 scripts\mp\perks\perkpackage::perkpackage_givedebug(var_0);
    }

    wait 0.25;
  }
}

devfindhost() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(var_2 ishost()) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

watchlethaldelaycancel() {
  for(;;) {
    if(getdvarint("_encstr_AA3B165BEFB8F98385B3C25AD87DFF6D8863E3D11DC8BF4B", 0)) {
      scripts\mp\equipment::cancellethaldelay();
      return;
    }

    wait 1.0;
  }
}

watchsuperdelaycancel() {
  for(;;) {
    if(getdvarint("_encstr_A56415E68D93D7E65707562711CA632CE5680B736C9563", 0)) {
      scripts\mp\supers::cancelsuperdelay();
      return;
    }

    wait 1.0;
  }
}

watchslowmo() {
  for(;;) {
    if(getDvar("_encstr_863D0BE78F23A8907CCDF388F5") != "_encstr_B40101") {
      break;
    }

    wait 1;
  }

  var_0 = getdvarfloat("_encstr_863D0BE78F23A8907CCDF388F5");
  setslowmotion(var_0, var_0, 0.0);
  thread watchslowmo();
}

rangefinder() {
  thread scripts\mp\rangefinder::runmprangefinder();
}