/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4272.gsc
**************************************/

_id_CE83(var_0, var_1, var_2) {
  level endon("ja_vo_interrupt");

  if(isDefined(var_1) && var_1 && scripts\engine\utility::flag("jackal_assault_vo_playing")) {
    return;
  }
  _id_13510();

  if(isDefined(var_2)) {
    wait(var_2);
  }

  [[var_0]]();
  _id_134D2();
}

_id_CE88(var_0, var_1, var_2) {
  level endon("ja_vo_interrupt");

  if(isDefined(var_2) && var_2 && scripts\engine\utility::flag("jackal_assault_vo_playing")) {
    return;
  }
  _id_13510();
  [[var_0]](var_1);
  _id_134D2();
}

_id_CE85(var_0) {
  level notify("ja_vo_interrupt");
  level._id_A3AB = 0;
  scripts\sp\utility::_id_DBF5();
  scripts\sp\utility::_id_D020();
  _id_134D2();
  _id_CE83(var_0);
}

_id_CE82(var_0) {
  _id_13510();
  scripts\engine\utility::flag_set("jackal_assault_vo_playing_important");
  [[var_0]]();
  scripts\engine\utility::flag_clear("jackal_assault_vo_playing_important");
  _id_134D2();
}

_id_13510() {
  level endon("ja_vo_interrupt");

  if(scripts\engine\utility::flag("jackal_assault_vo_playing")) {
    var_0 = level._id_A3AB;
    level._id_A3AB++;

    for(;;) {
      scripts\engine\utility::flag_waitopen("jackal_assault_vo_playing");

      if(var_0 == 0) {
        level._id_A3AB--;
        break;
      }

      var_0--;
      wait 0.05;
    }
  }

  if(scripts\engine\utility::flag("jackal_assault_vo_playing_important")) {
    for(;;) {
      var_0 = level._id_A3AC;
      level._id_A3AC++;
      scripts\engine\utility::flag_waitopen("jackal_assault_vo_playing_important");

      if(var_0 == 0) {
        level._id_A3AC--;
        break;
      }

      var_0--;
      wait 0.05;
    }
  }

  scripts\engine\utility::flag_set("jackal_assault_vo_playing");
  _id_0BDC::_id_A163(1);
}

_id_134D2() {
  scripts\engine\utility::flag_clear("jackal_assault_vo_playing");
  thread _id_1C6F();
}

_id_1C6F() {
  level endon("jackal_assault_vo_playing");
  wait(randomfloatrange(1.0, 3.0));
  _id_0BDC::_id_A163(0);
}

_id_114F5() {
  level.player endon("script_death");
  level._id_A3A7 = 0;

  for(;;) {
    level waittill("jackal_target_aid_callout", var_0);

    if(var_0 == "ace") {
      thread _id_CE83(::_id_134B0, 1);
    } else if(var_0 == "skelter") {
      thread _id_CE83(::_id_1350D, 1);
    } else if(var_0 == "missileboat") {
      thread _id_CE83(::_id_134EF, 1);
    } else if(var_0 == "destroyer") {
      thread _id_CE83(::_id_134C8, 1);
    }

    wait(randomfloatrange(11, 14));
  }
}

_id_1350D() {
  var_0 = ["ja_all_slt_focusontheskelters", "ja_all_slt_raiderkeephittingtheir", "ja_all_slt_needtotakeout", "ja_all_slt_takeouttheskelters", "ja_all_slt_shootdownthoseskelters"];
  var_1 = ["ja_all_slt_destroytheirskelterssir", "ja_all_slt_enemyskeltersstillin", "ja_all_slt_targetmoreofthe", "ja_all_slt_recommendengagingenemyskelters", "ja_all_slt_sirkeephittingtheir"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A9F0) && var_3 == level._id_A9F0) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A9F0 = var_3;
}

_id_134C8() {
  var_0 = ["ja_all_slt_hittheirdestroyerraider", "ja_all_slt_layintothatdestroyer", "ja_all_slt_getthedestroyer", "ja_all_slt_takeoutthedestroyer", "ja_all_slt_shootthatdestroyer"];
  var_1 = ["ja_all_slt_concentratefireonthe", "ja_all_slt_eliminatethesetdefdestroyer", "ja_all_slt_sirfocusonthe", "ja_all_slt_takedownthedestroyer", "ja_all_slt_directfireattheir"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A973) && var_3 == level._id_A973) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A973 = var_3;
}

_id_134C9() {
  var_0 = ["ja_all_slt_raiderletstakedown", "ja_all_slt_thedestroyersraider", "ja_all_slt_focusfireonthe", "ja_all_slt_letstakedownthose", "ja_all_slt_hitthedestroyers"];
  var_1 = ["ja_all_eth_takeouttheirdestroyers", "ja_all_eth_destroyersareourtop", "ja_all_eth_eliminatetheirdestroyerssir", "ja_all_eth_keepfiringonthe", "ja_all_eth_fireattheenemy"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A974) && var_3 == level._id_A974) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A974 = var_3;
}

_id_134EF() {
  var_0 = ["ja_all_slt_getthatajak", "ja_all_slt_doyouhavea", "ja_all_slt_hitthatajakraider", "ja_all_slt_takecareofthat"];
  var_1 = ["ja_all_slt_engagetheirajaksir"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A9BB) && var_3 == level._id_A9BB) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A9BB = var_3;
}

_id_134F0() {
  var_0 = ["ja_all_slt_wipeouttheajaks", "ja_all_slt_theajaksraider", "ja_all_slt_morefireontheirajaks", "ja_all_slt_hitthoseajaks", "ja_all_slt_takingfirefromenemy"];
  var_1 = ["ja_all_slt_setdefajaksstilloperational", "ja_all_slt_recommenddestroyingtheirajaks", "ja_all_slt_ajaksarethetop", "ja_all_slt_ajaksstillinthe", "ja_all_slt_eliminatetheajakssir"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A9BC) && var_3 == level._id_A9BC) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A9BC = var_3;
}

_id_134B0() {
  var_0 = ["ja_all_slt_gottatakecareof", "ja_all_slt_yougotashot", "ja_all_slt_keephuntingthatace", "ja_all_slt_dontthinkthatace"];
  var_1 = ["ja_all_eth_aceskelterstillin", "ja_all_eth_sirtryandtake", "ja_all_eth_cantletthatace", "ja_all_eth_dontforgetabouttheir"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A92E) && var_3 == level._id_A92E) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A92E = var_3;
}

_id_134B1() {
  var_0 = ["ja_all_slt_needtotakedown", "ja_all_slt_thoseacesaretrouble", "ja_all_slt_multipleaceskeltersto", "ja_all_slt_wecantleavetil", "ja_all_slt_aceskeltersstillin"];
  var_1 = ["ja_all_eth_huntdowntheirace", "ja_all_eth_recommendengagingoneof", "ja_all_eth_dontlettheiraces", "ja_all_eth_sirstillseeingmultiple", "ja_all_eth_clearoutthoseace"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A92F) && var_3 == level._id_A92F) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A92F = var_3;
}

_id_13501() {
  var_0 = ["ja_all_slt_retributionswaitingforus", "ja_all_slt_weheadingbackto", "ja_all_slt_readytoleavewhen", "ja_all_slt_letsgetbackto", "ja_all_slt_waitingforyourgo"];
  var_1 = ["ja_all_eth_retributionisreadyfor", "ja_all_eth_boardtheretributionwhen", "ja_all_eth_sirretributionisready", "ja_all_eth_returntotheretribution", "ja_all_eth_headbacktothe"];

  if(level._id_A3A7) {
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = var_0;
  }

  var_3 = randomint(var_2.size);

  if(isDefined(level._id_A9DE) && var_3 == level._id_A9DE) {
    if(var_3 == var_2.size - 1) {
      var_3 = 0;
    } else {
      var_3++;
    }
  }

  scripts\sp\utility::_id_10350(var_2[var_3]);
  level._id_A9DE = var_3;
}