/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3894.gsc
**************************************/

_id_D83F() {
  scripts\engine\utility::flag_init("zerog_ascend");
  scripts\engine\utility::flag_init("zerog_descend");
  scripts\engine\utility::flag_init("zerog_grapple");
  scripts\engine\utility::flag_init("zerog_rotate");
  scripts\engine\utility::flag_init("zerog_realign");
  scripts\engine\utility::flag_init("watch_zerog_realign");
  scripts\engine\utility::flag_init("no_grapple_targets");
  scripts\engine\utility::flag_init("zerog_grenade");
  scripts\sp\utility::_id_16EB("zerog_ascend_hint", &"ZEROG_ASCEND_TUTORIAL_HINT", ::_id_13E8F);
  scripts\sp\utility::_id_16EB("zerog_descend_hint", &"ZEROG_DESCEND_TUTORIAL_HINT", ::_id_13EA1);
  scripts\sp\utility::_id_16EB("zerog_grapple_hint", &"ZEROG_GRAPPLE_TUTORIAL_HINT", ::_id_13EB2);
  scripts\sp\utility::_id_16EB("zerog_grenade_hint", &"ZEROG_GRENADE_TUTORIAL_HINT", ::_id_13EB4);
  scripts\sp\utility::_id_16EB("zerog_rotate_hint", &"ZEROG_ROTATE_TUTORIAL_HINT", ::_id_13ECD);
  scripts\sp\utility::_id_16EB("zerog_realign_hint", &"ZEROG_AUTO_LEVEL_TUTORIAL_HINT", ::_id_13ECA);
}

_id_12AB4(var_0) {
  level endon(var_0);
  level._id_13EDD = var_0;
  scripts\engine\utility::flag_clear("zerog_ascend");
  scripts\engine\utility::flag_clear("zerog_descend");
  scripts\engine\utility::flag_clear("zerog_grapple");
  scripts\engine\utility::flag_clear("zerog_rotate");
  scripts\engine\utility::flag_clear("zerog_grenade");
  thread _id_13988(var_0);
  thread _id_13986(var_0);
  thread _id_13987(var_0);
  thread _id_1398B(var_0);
  thread _id_13989(var_0);
  wait 0.5;

  if(!scripts\engine\utility::flag("zerog_grapple")) {
    thread _id_13EB1(var_0);
    scripts\engine\utility::flag_wait_or_timeout("zerog_grapple", 15);
    wait 0.5;
  }

  wait 1;
  thread scripts\sp\utility::_id_56BA("zerog_ascend_hint");
  scripts\engine\utility::flag_wait_or_timeout("zerog_ascend", 4);

  if(!scripts\engine\utility::flag("zerog_ascend"))
    scripts\engine\utility::flag_set("zerog_ascend");

  wait 1;
  thread scripts\sp\utility::_id_56BA("zerog_descend_hint");
  scripts\engine\utility::flag_wait_or_timeout("zerog_descend", 4);

  if(!scripts\engine\utility::flag("zerog_descend"))
    scripts\engine\utility::flag_set("zerog_descend");

  wait 1;
  thread _id_13EB3(var_0);
  thread _id_8971(var_0);
  thread _id_8970(var_0);
}

_id_13E8F() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_ascend") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13EA1() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_descend") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13EB2() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_grapple") || scripts\engine\utility::flag("no_grapple_targets") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13EB4() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_grenade") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13ECA() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_realign") || !scripts\engine\utility::flag("watch_zerog_realign") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13ECD() {
  return !isalive(level.player) || scripts\engine\utility::flag("zerog_rotate") || scripts\engine\utility::flag(level._id_13EDD);
}

_id_13986(var_0) {
  level endon(var_0);
  level endon("zerog_ascend");
  level.player notifyonplayercommand("zerog_ascended", "+gostand");
  level.player waittill("zerog_ascended");
  scripts\engine\utility::flag_set("zerog_ascend");
}

_id_13987(var_0) {
  level endon(var_0);
  level endon("zerog_descend");

  while(!level.player _meth_843B())
    wait 0.05;

  scripts\engine\utility::flag_set("zerog_descend");
}

_id_13988(var_0) {
  level endon("zerog_grapple");
  level endon(var_0);

  while(!level.player _id_0F31::_id_9E14())
    wait 0.05;

  scripts\engine\utility::flag_set("zerog_grapple");
}

_id_13EB1(var_0) {
  level endon(var_0);
  level endon("zerog_grapple");

  for(;;) {
    if(isDefined(level.player _meth_8544())) {
      if(!level.player scripts\sp\utility::_id_65DB("global_hint_in_use")) {
        scripts\engine\utility::flag_clear("no_grapple_targets");
        thread scripts\sp\utility::_id_56BA("zerog_grapple_hint");
      }
    } else if(!scripts\engine\utility::flag("no_grapple_targets"))
      scripts\engine\utility::flag_set("no_grapple_targets");

    wait 0.05;
  }
}

_id_13989(var_0) {
  level endon("zerog_grenade");
  level endon(var_0);
  level.player notifyonplayercommand("zerog_grenade_thrown", "+frag");
  level.player waittill("zerog_grenade_thrown");
  scripts\engine\utility::flag_set("zerog_grenade");
}

_id_13EB3(var_0) {
  level endon("zerog_grenade");
  level endon(var_0);

  if(!level.player hasweapon("trackingfragzerog")) {
    return;
  }
  level.player givemaxammo("trackingfragzerog");

  if(level.player _id_0F31::_id_9E14()) {
    while(level.player _id_0F31::_id_9E14())
      scripts\engine\utility::waitframe();
  }

  thread scripts\sp\utility::_id_56BA("zerog_grenade_hint");
  scripts\engine\utility::flag_wait_or_timeout("zerog_grenade", 4);

  if(!scripts\engine\utility::flag("zerog_grenade"))
    scripts\engine\utility::flag_set("zerog_grenade");
}

_id_8971(var_0) {
  level endon("zerog_rotate");
  level endon(var_0);
  thread scripts\sp\utility::_id_56BA("zerog_rotate_hint");
  scripts\engine\utility::flag_wait_or_timeout("zerog_rotate", 4);

  if(!scripts\engine\utility::flag("zerog_rotate"))
    scripts\engine\utility::flag_set("zerog_rotate");
}

_id_8970(var_0) {
  var_1 = 1.0;
  level endon("handle_zerog_realign_hint");
  level endon(var_0);
  scripts\engine\utility::flag_wait("zerog_rotate");
  level._id_13ECC = 0;

  for(;;) {
    var_2 = 0.25;
    var_3 = getdvarvector("player_zeroGravAutoLevel");

    if(lengthsquared(var_3) < 0.01) {
      wait(var_2);
      continue;
    }

    var_3 = vectorNormalize(var_3);
    var_4 = 0.0;

    for(;;) {
      var_5 = generateaxisanglesfromupvector(var_3, level.player getplayerangles());
      var_6 = level.player getplayerangles();
      var_7 = abs(angleclamp180(var_5[2] - var_6[2]));

      if(var_7 > 30) {
        var_4 = var_4 + var_2;

        if(var_4 > var_1) {
          break;
        }
      } else
        var_4 = 0.0;

      wait(var_2);
    }

    scripts\engine\utility::flag_clear("zerog_realign");
    thread _id_1398A(var_0);
    thread scripts\sp\utility::_id_56BA("zerog_realign_hint");

    for(;;) {
      var_5 = generateaxisanglesfromupvector(var_3, level.player getplayerangles());
      var_6 = level.player getplayerangles();
      var_7 = abs(angleclamp180(var_5[2] - var_6[2]));

      if(var_7 < 10) {
        level notify("watch_zerog_realign");
        scripts\engine\utility::flag_clear("watch_zerog_realign");
        break;
      }

      scripts\engine\utility::waitframe();
    }
  }
}

_id_1398B(var_0) {
  level endon("zerog_rotate");
  level endon(var_0);
  level.player notifyonplayercommand("zerog_rotate", "+actionslot 3");
  level.player notifyonplayercommand("zerog_rotate", "+actionslot 4");
  level.player waittill("zerog_rotate");
  scripts\engine\utility::flag_set("zerog_rotate");
}

_id_1398A(var_0) {
  level notify("watch_zerog_realign");
  level endon("zerog_realign");
  level endon(var_0);
  scripts\engine\utility::flag_set("watch_zerog_realign");
  level.player notifyonplayercommand("zerog_realign", "+actionslot 1");
  level endon("watch_zerog_realign");
  level.player waittill("zerog_realign");
  level._id_13ECC++;

  if(level._id_13ECC >= 2) {
    level notify("zerog_rotate");
    level notify("handle_zerog_realign_hint");
  }

  scripts\engine\utility::flag_set("zerog_realign");
}