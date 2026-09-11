/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\turret.gsc
***********************************************/

function init() {
  var0 = getEntArray("turret_mp", "targetname");

  if(level.gametype == "br") {
    foreach(var2 in var0) {
      var2 delete();
    }

    return;
  }

  foreach(var2 in var3) {
    add_turret(var2);
  }
}

function add_turret(var0) {
  var0 makeunusable();
  var0 setnodeploy(1);
  var0 setdefaultdroppitch(0);
  var1 = getcompleteweaponname(var0.weaponinfo);
  var0.objweapon = var1;

  if(isDefined(var0.script_noteworthy)) {
    var2 = strtok(var0.script_noteworthy, ",");

    foreach(var4 in var2) {
      var5 = strtok(var4, "|");

      if(isDefined(var5)) {
        if(var5[0] == "arc") {
          if(isDefined(var5[1]) && var5[1] != "0") {
            var0 setleftarc(int(var5[1]));
          }

          if(isDefined(var5[2]) && var5[2] != "0") {
            var0 setrightarc(int(var5[2]));
          }

          if(isDefined(var5[3]) && var5[3] != "0") {
            var0 settoparc(int(var5[3]));
          }

          if(isDefined(var5[4]) && var5[4] != "0") {
            var0 setbottomarc(int(var5[4]));
          }
        }
      }
    }
  }

  var7 = var0 gettagorigin("tag_turret_pitch");
  var8 = scripts\mp\gameobjects::createhintobject(var7, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var8 linkTo(var0, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  var0.useobj = var8;
  thread turretthink(var8);
  var9 = var0 gettagorigin("tag_player");
  var0.killcament = spawn("script_model", var9);
  var0.killcament linkTo(var0, "tag_player", (-60, 0, 20), (0, 0, 0));
}

function turretthink(var0) {
  for(;;) {
    self waittill("trigger", var1);
    self makeunusable();
    thread endturretonplayer(var1);
    var1.prevweapon = var1 getcurrentweapon();
    var1.useweapon = createheadicon(var0.objweapon);
    var1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1.useweapon, undefined, undefined, 1);

    while(var1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1.useweapon, 1) == 0) {
      waitframe();
    }

    var1 controlturreton(var0);
    thread endturretusewatch(var1, var0);
    self waittill("end_turret_use");

    if(isDefined(var1)) {
      var1 controlturretoff(var0);
      var1 switchtoweaponimmediate(var1.prevweapon);
      var1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var1.useweapon);
    }

    self makeusable();
  }
}

function endturretusewatch(var0, var1) {
  while(var0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var0 useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

function endturretonplayer(var0) {
  var0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}