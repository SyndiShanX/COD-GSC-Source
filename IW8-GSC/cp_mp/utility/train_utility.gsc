/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\train_utility.gsc
***********************************************/

init() {
  scripts\engine\scriptable::_id_12F5B("_encstr_83FC16A06FA4E829AA2A1308C64253902FAB78D8E34F612F", ::brtruck_initpostmain);
  level.ammorestocklocs = [];
  var_0 = "_encstr_92981616B6B6B7EBC956DC1DF68DB6D7B1B78D1647D2BDB9";

  if(scripts\mp\utility\game::unset_relic_grounded())
    var_0 = "_encstr_849E1AF870BB97819B9DAB286060C8E9D8781B0A7B6AF8239F476043";

  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!istrue(level.useammorestocklocs) || isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_3.script_noteworthy) && var_3.script_noteworthy != level.localeid) {
      foreach(var_6 in var_4) {
        if(var_6.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
          var_6 delete();
          continue;
        }

        var_6 delete();
      }

      var_3 delete();
      continue;
    }

    var_3.timeplayerused = [];
    level.ammorestocklocs[level.ammorestocklocs.size] = var_3;
  }

  if(isDefined(level.localeid) && level.localeid == "_encstr_8A34097127C761890FA9D2")
    brtruck_initexternalfeatures();
}

brtruck_initpostmain(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(debug_start_silo_elevator(var_3)) {
      if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && (getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_816E079685517D0975" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E"))
        var_0 disablescriptableplayeruse(var_3);
      else
        thread brtruck_initfeatures(var_0, var_3, 5);
    } else
      thread brtruck_initfeatures(var_0, var_3, 0.1);
  } else if(ammorestock_playeruse(var_3, var_0.entity))
    thread brtruck_initfeatures(var_0, var_3, 5);
  else
    thread brtruck_initfeatures(var_0, var_3, 0.1);
}

brtruck_initfeatures(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 disablescriptableplayeruse(var_1);
  wait(var_2);
  var_0 enablescriptableplayeruse(var_1);
}

ammorestock_playeruse(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = var_0.primaryweapons;
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!scripts\mp\utility\weapon::ismeleeonly(var_5) && !scripts\mp\utility\weapon::issuperweapon(var_5) && !scripts\mp\utility\weapon::iskillstreakweapon(var_5) && !scripts\mp\utility\weapon::isgamemodeweapon(var_5) && !scripts\mp\utility\weapon::issinglehitweapon(var_5))
      var_3[var_3.size] = var_5;
  }

  var_2 = var_3;
  var_7 = 0;

  foreach(var_9 in var_2) {
    if(weaponmaxammo(var_9) == var_0 getweaponammostock(var_9))
      var_7++;
  }

  if(var_7 == var_2.size) {
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_AFC427F7611028F68985F5CF7EF1CEB0CB074F0FB3B0F1A2F1AFBB4515391719256FDF9F2F4C196461");
    return 0;
  }

  var_11 = [];

  foreach(var_13, var_5 in var_2)
  var_11[var_13] = var_0 getammotype(var_5);

  var_14 = 0;

  foreach(var_13, var_16 in var_11) {
    if(isDefined(var_11[var_13 + 1])) {
      if(var_11[var_13] == var_11[var_13 + 1]) {
        var_14 = 1;
        continue;
      }

      var_14 = 0;
    }
  }

  var_17 = 0;

  if(var_14) {
    foreach(var_5 in var_2)
    var_17 = var_17 + weaponmaxammo(var_5);
  }

  foreach(var_9 in var_2) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_delete_alerted_icon(var_9, 2);
      continue;
    }

    var_21 = scripts\mp\weapons::getammooverride(var_9);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_9)) {
      var_22 = var_0 getweaponammostock(var_9);
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 2));
      var_0 setweaponammostock(var_9, var_23);

      if(weaponclipsize(var_9) != var_0 getweaponammoclip(var_9)) {
        var_0 setweaponammoclip(var_9, 0, "_encstr_A5AD056A019C63");
        var_0 setweaponammoclip(var_9, 0, "_encstr_8253060E2B5FE330");
      }

      continue;
    }

    var_24 = var_0 getweaponammoclip(var_9);
    var_22 = var_0 getweaponammostock(var_9);

    if(scripts\mp\utility\weapon::issinglehitweapon(var_9))
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 1));
    else if(var_14)
      var_23 = int(min(var_17, var_22 + var_21 * 2));
    else
      var_23 = int(min(weaponmaxammo(var_9), var_22 + var_21 * 2));

    if(var_9.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
      var_0 setweaponammoclip(var_9, var_24 + var_21);
    else
      var_0 setweaponammostock(var_9, var_23);
  }

  var_0 scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");
  var_0 playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
  return 1;
}

debug_start_silo_elevator(var_0) {
  var_1 = 0;
  var_2 = [];
  var_3 = var_0 getweaponslistprimaries();

  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var_3) || var_3.size == 0) {
      var_4 = var_0 getcurrentweapon();
      var_5 = var_0 getcurrentweaponclipammo();
      var_6 = weaponclipsize(var_4);

      if(var_5 < var_6) {
        var_0 setweaponammoclip(var_4, var_6);
        var_0 scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");
        var_0 playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
        return 1;
      }
    }
  }

  foreach(var_8 in var_3) {
    var_9 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_8);

    if(var_8.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_8.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_10 = weaponclipsize(var_8);
      var_11 = int(var_10);
      var_0 setweaponammoclip(var_8, var_11);
      continue;
    } else if(scripts\mp\utility\weapon::update_health_on_spawn(var_8)) {
      var_0 setweaponammoclip(var_8, var_8.clipsize);
      continue;
    } else if(!isDefined(var_9)) {
      continue;
    }
    var_12 = 1;

    if(var_2.size >= 1) {
      foreach(var_14 in var_2) {
        if(var_9 == var_14)
          var_12 = 0;
      }
    }

    if(var_12) {
      var_2[var_2.size] = var_9;
      var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_delete_alerted_icon(var_8, 2);
      var_1 = 1;
    }
  }

  if(!var_1) {
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_AFC427F7611028F68985F5CF7EF1CEB0CB074F0FB3B0F1A2F1AFBB4515391719256FDF9F2F4C196461");
    return 0;
  }

  var_0 scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");
  var_0 playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
  return 1;
}

_encstr_88CE26357EF7292093E72ED51B1B4509A7AF0BBDA219B39B8D19E96A43F3D648FB0572ABFDD3F1B2() {
  foreach(var_1 in level.ammorestocklocs) {
    var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_4 in var_2) {
      if(var_4.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
        if(istrue(self.iszombie)) {
          var_4 disablescriptableplayeruse(self);
          continue;
        }

        var_4 enablescriptableplayeruse(self);
      }
    }
  }
}

brtruck_initexternalfeatures() {
  var_0 = [];
  var_0[0] = (15946, -71, -469);
  var_0[1] = (16829, -8996, -333);
  var_0[2] = (16531, -13847, -154);
  var_0[3] = (24472, -14782, -134);
  var_0[4] = (22373, -19948, -36);
  var_0[5] = (18250, -2057, -439);
  var_0[6] = (17549, -4262, -432);
  var_0[7] = (19147, -11546, -257);
  var_0[8] = (19845, -21990, -98);
  var_0[9] = (19838, -18100, -23);
  var_0[10] = (21978, -11276, -58);

  foreach(var_2 in level.ammorestocklocs) {
    var_3 = 0;

    foreach(var_5 in var_0) {
      if(var_3) {
        break;
      }

      if(distance2dsquared(var_2.origin, var_5) < 10000)
        var_3 = 1;
    }

    if(var_3) {
      var_7 = getEntArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_9 in var_7) {
        if(var_9.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
          var_9 delete();
          continue;
        }

        var_9 delete();
      }

      var_2 delete();
    }
  }
}