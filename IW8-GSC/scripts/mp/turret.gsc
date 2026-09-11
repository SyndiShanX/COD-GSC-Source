/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\turret.gsc
***********************************************/

function init() {
  var_0 = getEntArray("turret_mp", "targetname");

  if(level.gametype == "br") {
    foreach(var_2 in var_0) {
      var_2 delete();
    }

    return;
  }

  foreach(var_2 in var_3) {
    add_turret(var_2);
  }
}

function add_turret(var_0) {
  var_0 makeunusable();
  var_0 setnodeploy(1);
  var_0 setdefaultdroppitch(0);
  var_1 = getcompleteweaponname(var_0.weaponinfo);
  var_0.objweapon = var_1;

  if(isDefined(var_0.script_noteworthy)) {
    var_2 = strtok(var_0.script_noteworthy, ",");

    foreach(var_4 in var_2) {
      var_5 = strtok(var_4, "|");

      if(isDefined(var_5)) {
        if(var_5[0] == "arc") {
          if(isDefined(var_5[1]) && var_5[1] != "0") {
            var_0 setleftarc(int(var_5[1]));
          }

          if(isDefined(var_5[2]) && var_5[2] != "0") {
            var_0 setrightarc(int(var_5[2]));
          }

          if(isDefined(var_5[3]) && var_5[3] != "0") {
            var_0 settoparc(int(var_5[3]));
          }

          if(isDefined(var_5[4]) && var_5[4] != "0") {
            var_0 setbottomarc(int(var_5[4]));
          }
        }
      }
    }
  }

  var_7 = var_0 gettagorigin("tag_turret_pitch");
  var_8 = scripts\mp\gameobjects::createhintobject(var_7, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var_8 linkTo(var_0, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  var_0.useobj = var_8;
  thread turretthink(var_8);
  var_9 = var_0 gettagorigin("tag_player");
  var_0.killcament = spawn("script_model", var_9);
  var_0.killcament linkTo(var_0, "tag_player", (-60, 0, 20), (0, 0, 0));
}

function turretthink(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    thread endturretonplayer(var_1);
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = createheadicon(var_0.objweapon);
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0) {
      waitframe();
    }

    var_1 controlturreton(var_0);
    thread endturretusewatch(var_1, var_0);
    self waittill("end_turret_use");

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeusable();
  }
}

function endturretusewatch(var_0, var_1) {
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

function endturretonplayer(var_0) {
  var_0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}