/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2083.gsc
*************************************************/

init() {
  var_0 = getEntArray("turret_mp", "targetname");

  if(level.gametype == "br") {
    foreach(var_2 in var_0) {
      var_2 delete();
    }

    return;
  }

  foreach(var_2 in var_0) {
    _id_106A(var_2);
  }
}

_id_106A(var_0) {
  var_0 makeunusable();
  var_0 setnodeploy(1);
  var_0 setdefaultdroppitch(0);
  var_1 = makeweapon(var_0.weaponinfo);
  var_0.objweapon = var_1;

  if(isDefined(var_0._id_039B)) {
    var_2 = strtok(var_0._id_039B, ",");

    foreach(var_4 in var_2) {
      var_5 = strtok(var_4, "|");

      if(isDefined(var_5)) {
        if(var_5[0] == "arc") {
          if(isDefined(var_5[1]) && var_5[1] != "0") {
            var_0 _meth_8331(int(var_5[1]));
          }

          if(isDefined(var_5[2]) && var_5[2] != "0") {
            var_0 _meth_8372(int(var_5[2]));
          }

          if(isDefined(var_5[3]) && var_5[3] != "0") {
            var_0 _meth_8395(int(var_5[3]));
          }

          if(isDefined(var_5[4]) && var_5[4] != "0") {
            var_0 _meth_82F0(int(var_5[4]));
          }
        }
      }
    }
  }

  var_7 = var_0 gettagorigin("tag_turret_pitch");
  var_8 = _id_07D6::_id_3FF0(var_7, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var_8 linkto(var_0, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  var_0._id_FE90 = var_8;
  var_8 thread _id_F89A(var_0);
  var_9 = var_0 gettagorigin("tag_player");
  var_0.killcament = spawn("script_model", var_9);
  var_0.killcament linkto(var_0, "tag_player", (-60, 0, 20), (0, 0, 0));
}

_id_F89A(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    thread _id_5351(var_1);
    var_1._id_BC6B = var_1 getcurrentweapon();
    var_1.useweapon = getcompleteweaponname(var_0.objweapon);
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0) {
      waitframe();
    }

    thread _id_5352(var_1, var_0);
    self waittill("end_turret_use");

    if(isDefined(var_1)) {
      var_1 _meth_8292(var_0);
      var_1 switchtoweaponimmediate(var_1._id_BC6B);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeuseable();
  }
}

_id_5352(var_0, var_1) {
  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

_id_5351(var_0) {
  var_0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}