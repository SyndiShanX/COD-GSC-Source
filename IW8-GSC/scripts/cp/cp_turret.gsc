/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_turret.gsc
***********************************************/

function initturrets() {
  scripts\engine\utility::flag_init("cp_turrets_initted");
  level.interaction_hintstrings["turret_anchor"] = &"CP_OBJECTIVES/USE_MANUAL_TURRET";
  scripts\cp\cp_interaction::registerinteraction("turret_anchor", &turret_hint_func, &turret_use_func, &turret_init_func);
}

function turret_hint_func(var_0, var_1) {
  if(isDefined(var_0.turret) && !var_0.turret.isinuse) {
    return &"CP_OBJECTIVES/USE_MANUAL_TURRET";
  }

  return "";
}

function turret_init_func(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3.turret = undefined;
    var_4 = scripts\engine\utility::getStructArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      var_7 = var_6.origin;
      var_8 = var_6.angles;
      var_9 = scripts\engine\utility::spawn_tag_origin(var_7, var_8);
      var_10 = spawnturret("misc_turret", var_9.origin, var_6.weaponinfo, 0);
      var_10.angles = var_9.angles;
      var_10 linkTo(var_9, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_10 setModel("weapon_mg_bravo50_balcony");
      var_10 setnodeploy(1);
      var_10 setdefaultdroppitch(0);
      var_10 makeunusable();
      var_10 setmode("sentry_offline");
      var_10 setsentryowner(undefined);
      var_10.targetname = "spawned_turret";
      var_11 = getcompleteweaponname("tur_gun_mp");
      var_10.objweapon = var_11;

      if(isDefined(var_6.script_noteworthy)) {
        var_12 = strtok(var_6.script_noteworthy, ",");

        foreach(var_14 in var_12) {
          var_15 = strtok(var_6.script_noteworthy, "|");

          if(isDefined(var_15)) {
            if(var_15[0] == "arc") {
              if(isDefined(var_15[1])) {
                var_10 setleftarc(int(var_15[1]));
              }

              if(isDefined(var_15[2])) {
                var_10 setrightarc(int(var_15[2]));
              }

              if(isDefined(var_15[3])) {
                var_10 settoparc(int(var_15[3]));
              }

              if(isDefined(var_15[4])) {
                var_10 setbottomarc(int(var_15[4]));
              }
            }
          }
        }
      }

      var_10.isinuse = 0;
      var_3.turret = var_10;
    }

    var_3.turret.turretindex = var_1;
    var_1++;
  }

  scripts\engine\utility::flag_set("cp_turrets_initted");
}

function turret_use_func(var_0, var_1) {
  var_2 = var_0.turret;

  if(var_2.isinuse) {
    return false;
  }

  var_1.prevweapon = var_1 getcurrentweapon();
  var_1.useweapon = createheadicon(var_2.objweapon);
  var_1 scripts\cp\utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.useweapon, 1) == 0) {
    waitframe();
  }

  var_1 controlturreton(var_2);
  var_2.isinuse = 1;
  thread endturretusewatch(var_1, var_2);
  thread endturretonplayer(var_1, var_2);
  self waittill("end_turret_use_" + var_2.turretindex);

  if(isDefined(var_1)) {
    var_1 controlturretoff(var_2);
    var_1 switchtoweaponimmediate(var_1.prevweapon);
    var_1 scripts\cp\cp_weapons::_takeweapon(var_1.useweapon);
  }

  var_2.isinuse = 0;
  return true;
}

function add_turret(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  var_4 = spawnturret("misc_turret", var_3.origin, var_0.weaponinfo, 0);
  var_4.angles = var_3.angles;
  var_4 linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 setModel(var_0.model);
  var_4 makeunusable();
  var_4 setnodeploy(1);
  var_4 setdefaultdroppitch(0);
  var_5 = getcompleteweaponname(var_0.weaponinfo);
  var_4.objweapon = var_5;

  if(isDefined(var_0.arclimits)) {
    var_6 = strtok(var_0.arclimits, ",");

    foreach(var_8 in var_6) {
      var_9 = strtok(var_0.arclimits, "|");

      if(isDefined(var_9)) {
        if(var_9[0] == "arc") {
          if(isDefined(var_9[1]) && var_9[1] != "0") {
            var_4 setleftarc(int(var_9[1]));
          }

          if(isDefined(var_9[2]) && var_9[2] != "0") {
            var_4 setrightarc(int(var_9[2]));
          }

          if(isDefined(var_9[3]) && var_9[3] != "0") {
            var_4 settoparc(int(var_9[3]));
          }

          if(isDefined(var_9[4]) && var_9[4] != "0") {
            var_4 setbottomarc(int(var_9[4]));
          }
        }
      }
    }
  }

  var_11 = var_4 gettagorigin("tag_turret_pitch");
  var_12 = createinteractobject(var_11);
  var_12 linkTo(var_4, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  thread turretthink(var_12);
  var_0 delete();
}

function createinteractobject(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 makeusable();
  var_1 setuseprioritymax();
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethinticon("hud_icon_turret");
  var_1 setHintString(&"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var_1 sethintonobstruction("hide");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(120);
  var_1 setuserange(50);
  var_1 setusefov(120);
  return var_1;
}

function turretthink(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = createheadicon(var_0.objweapon);
    var_1 scripts\cp\utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.useweapon, 1) == 0) {
      waitframe();
    }

    var_1 controlturreton(var_0);
    var_0.playerowner = var_1;
    thread endturretusewatch(var_1, var_0);
    thread endturretonplayer(var_1, var_0);
    self waittill("end_turret_use_" + var_0.turretindex);

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp\cp_weapons::_takeweapon(var_1.useweapon);
    }

    var_0.playerowner = undefined;
    self makeusable();
  }
}

function endturretusewatch(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  self endon("end_turret_use_" + var_1.turretindex);

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("end_turret_use_" + var_1.turretindex);
      break;
    }

    waitframe();
  }
}

function endturretonplayer(var_0, var_1) {
  var_0 scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand");
  self notify("end_turret_use_" + var_1.turretindex);
}

function aiturretthink() {
  scripts\engine\utility::flag_wait("cp_turrets_initted");
  level endon("game_ended");
  self endon("stop_ai_turret_think");
  level.ignoredbycheck = undefined;
  var_0 = self.turret;

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setmode("manual");
  var_0 setconvergencetime(1, "yaw");
  var_0 setconvergencetime(1, "pitch");
  var_0 setturretteam("axis");
  var_0.team = "axis";

  for(;;) {
    var_1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
    var_2 = 0;

    if(isDefined(var_0.playerowner)) {
      return;
    }

    if(!aiusingturret(self)) {
      wait 0.1;
      var_0 cleartargetentity();
      continue;
    }

    var_3 = aiturretgettarget(var_0);

    if(!isDefined(var_3)) {
      wait 0.5;
      continue;
    }

    var_0 settargetentity(var_3);
    var_0 scripts\engine\utility::ref_143b9(3, "turret_on_target");
    aiturretshoottarget(var_0, var_3);
  }
}

function aiturretgettarget() {
  level endon("game_ended");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!aiturretcantarget(var_3, (0, 0, 50))) {
        continue;
      }

      var_1 = var_3;
    }

    if(var_1.size == 0) {
      wait 0.1;
      continue;
    }

    var_0 = scripts\engine\utility::random(var_1);
    break;
  }

  return var_0;
}

function aiturretcantarget(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_2 = self gettagorigin("tag_flash");
  var_3 = 0;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var_5 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!scripts\engine\trace::ray_trace_passed(var_2 + var_1, var_5[var_6], self, var_4)) {
      continue;
    }

    var_3 = 1;
    break;
  }

  return var_3;
}

function aiturretshoottarget(var_0) {
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  self endon("death");
  var_1 = 0.15;
  var_2 = 20;

  if(!isDefined(self.num_shots_left)) {
    self.num_shots_left = 100;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self shootturret(undefined, 2);
    wait var_1;
    self.num_shots_left--;

    if(!aiusingturret(self)) {
      return;
    }
  }

  if(self.num_shots_left <= 0) {
    self.num_shots_left = 100;
    wait randomintrange(5, 8);
    return;
  }
}

function aiusingturret(var_0) {
  var_1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(distance(var_4.origin, self.origin) < 55) {
      return true;
    }
  }

  return false;
}