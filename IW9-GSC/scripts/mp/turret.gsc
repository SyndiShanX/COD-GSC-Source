/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\turret.gsc
***********************************************/

init() {
  array = getEntArray("turret_mp", "targetname");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    foreach(ent in array)
    ent delete();

    return;
  }

  foreach(ent in array)
  add_turret(ent);
}

add_turret(turret) {
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  objweapon = makeweapon(turret.weaponinfo);
  turret.objweapon = objweapon;

  if(isDefined(turret.script_noteworthy)) {
    types = strtok(turret.script_noteworthy, ",");

    foreach(type in types) {
      values = strtok(type, "|");

      if(isDefined(values)) {
        if(values[0] == "arc") {
          if(isDefined(values[1]) && values[1] != "0")
            turret setleftarc(int(values[1]));

          if(isDefined(values[2]) && values[2] != "0")
            turret setrightarc(int(values[2]));

          if(isDefined(values[3]) && values[3] != "0")
            turret settoparc(int(values[3]));

          if(isDefined(values[4]) && values[4] != "0")
            turret setbottomarc(int(values[4]));
        }
      }
    }
  }

  _id_861CB51E11728417 = turret gettagorigin("tag_turret_pitch");
  useobj = scripts\mp\gameobjects::createhintobject(_id_861CB51E11728417, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  useobj linkTo(turret, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  turret.useobj = useobj;
  useobj thread turretthink(turret);
  _id_8CB8B3AF44BD2DD6 = turret gettagorigin("tag_player");
  turret.killcament = spawn("script_model", _id_8CB8B3AF44BD2DD6);
  turret.killcament linkTo(turret, "tag_player", (-60, 0, 20), (0, 0, 0));
}

turretthink(turret) {
  for(;;) {
    self waittill("trigger", player);
    self makeunusable();
    thread endturretonplayer(player);
    player.prevweapon = player getcurrentweapon();
    player.useweapon = getcompleteweaponname(turret.objweapon);
    player scripts\cp_mp\utility\inventory_utility::_giveweapon(player.useweapon, undefined, undefined, 1);

    while(player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.useweapon, 1) == 0)
      waitframe();

    player controlturreton(turret);
    thread endturretusewatch(player, turret);
    self waittill("end_turret_use");

    if(isDefined(player)) {
      player controlturretoff(turret);
      player switchtoweaponimmediate(player.prevweapon);
      player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.useweapon);
    }

    self makeusable();
  }
}

endturretusewatch(player, turret) {
  while(player useButtonPressed())
    waitframe();

  for(;;) {
    if(player useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

endturretonplayer(player) {
  player waittill("death_or_disconnect");
  self notify("end_turret_use");
}