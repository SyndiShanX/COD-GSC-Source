/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_turret.gsc
***********************************************/

function initturrets() {
  scripts\engine\utility::flag_init("cp_turrets_initted");
  level.interaction_hintstrings["turret_anchor"] = &"CP_OBJECTIVES/USE_MANUAL_TURRET";
  scripts\cp\cp_interaction::registerinteraction("turret_anchor", &turret_hint_func, &turret_use_func, &turret_init_func);
}

function turret_hint_func(var0, var1) {
  if(isDefined(var0.turret) && !var0.turret.isinuse) {
    return &"CP_OBJECTIVES/USE_MANUAL_TURRET";
  }

  return "";
}

function turret_init_func(var0) {
  var1 = 0;

  foreach(var3 in var0) {
    var3.turret = undefined;
    var4 = scripts\engine\utility::getStructArray(var3.target, "targetname");

    foreach(var6 in var4) {
      var7 = var6.origin;
      var8 = var6.angles;
      var9 = scripts\engine\utility::spawn_tag_origin(var7, var8);
      var10 = spawnturret("misc_turret", var9.origin, var6.weaponinfo, 0);
      var10.angles = var9.angles;
      var10 linkTo(var9, "tag_origin", (0, 0, 0), (0, 0, 0));
      var10 setModel("weapon_mg_bravo50_balcony");
      var10 setnodeploy(1);
      var10 setdefaultdroppitch(0);
      var10 makeunusable();
      var10 setmode("sentry_offline");
      var10 setsentryowner(undefined);
      var10.targetname = "spawned_turret";
      var11 = getcompleteweaponname("tur_gun_mp");
      var10.objweapon = var11;

      if(isDefined(var6.script_noteworthy)) {
        var12 = strtok(var6.script_noteworthy, ",");

        foreach(var14 in var12) {
          var15 = strtok(var6.script_noteworthy, "|");

          if(isDefined(var15)) {
            if(var15[0] == "arc") {
              if(isDefined(var15[1])) {
                var10 setleftarc(int(var15[1]));
              }

              if(isDefined(var15[2])) {
                var10 setrightarc(int(var15[2]));
              }

              if(isDefined(var15[3])) {
                var10 settoparc(int(var15[3]));
              }

              if(isDefined(var15[4])) {
                var10 setbottomarc(int(var15[4]));
              }
            }
          }
        }
      }

      var10.isinuse = 0;
      var3.turret = var10;
    }

    var3.turret.turretindex = var1;
    var1++;
  }

  scripts\engine\utility::flag_set("cp_turrets_initted");
}

function turret_use_func(var0, var1) {
  var2 = var0.turret;

  if(var2.isinuse) {
    return false;
  }

  var1.prevweapon = var1 getcurrentweapon();
  var1.useweapon = createheadicon(var2.objweapon);
  var1 scripts\cp\utility::_giveweapon(var1.useweapon, undefined, undefined, 1);

  while(var1 scripts\cp\cp_weapons::switchtoweaponreliable(var1.useweapon, 1) == 0) {
    waitframe();
  }

  var1 controlturreton(var2);
  var2.isinuse = 1;
  thread endturretusewatch(var1, var2);
  thread endturretonplayer(var1, var2);
  self waittill("end_turret_use_" + var2.turretindex);

  if(isDefined(var1)) {
    var1 controlturretoff(var2);
    var1 switchtoweaponimmediate(var1.prevweapon);
    var1 scripts\cp\cp_weapons::_takeweapon(var1.useweapon);
  }

  var2.isinuse = 0;
  return true;
}

function add_turret(var0) {
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = scripts\engine\utility::spawn_tag_origin(var1, var2);
  var4 = spawnturret("misc_turret", var3.origin, var0.weaponinfo, 0);
  var4.angles = var3.angles;
  var4 linkTo(var3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var4 setModel(var0.model);
  var4 makeunusable();
  var4 setnodeploy(1);
  var4 setdefaultdroppitch(0);
  var5 = getcompleteweaponname(var0.weaponinfo);
  var4.objweapon = var5;

  if(isDefined(var0.arclimits)) {
    var6 = strtok(var0.arclimits, ",");

    foreach(var8 in var6) {
      var9 = strtok(var0.arclimits, "|");

      if(isDefined(var9)) {
        if(var9[0] == "arc") {
          if(isDefined(var9[1]) && var9[1] != "0") {
            var4 setleftarc(int(var9[1]));
          }

          if(isDefined(var9[2]) && var9[2] != "0") {
            var4 setrightarc(int(var9[2]));
          }

          if(isDefined(var9[3]) && var9[3] != "0") {
            var4 settoparc(int(var9[3]));
          }

          if(isDefined(var9[4]) && var9[4] != "0") {
            var4 setbottomarc(int(var9[4]));
          }
        }
      }
    }
  }

  var11 = var4 gettagorigin("tag_turret_pitch");
  var12 = createinteractobject(var11);
  var12 linkTo(var4, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  thread turretthink(var12);
  var0 delete();
}

function createinteractobject(var0) {
  var1 = spawn("script_model", var0);
  var1 makeusable();
  var1 setuseprioritymax();
  var1 setCursorHint("HINT_BUTTON");
  var1 sethinticon("hud_icon_turret");
  var1 setHintString(&"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var1 sethintonobstruction("hide");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(120);
  var1 setuserange(50);
  var1 setusefov(120);
  return var1;
}

function turretthink(var0) {
  for(;;) {
    self waittill("trigger", var1);
    self makeunusable();
    var1.prevweapon = var1 getcurrentweapon();
    var1.useweapon = createheadicon(var0.objweapon);
    var1 scripts\cp\utility::_giveweapon(var1.useweapon, undefined, undefined, 1);

    while(var1 scripts\cp\cp_weapons::switchtoweaponreliable(var1.useweapon, 1) == 0) {
      waitframe();
    }

    var1 controlturreton(var0);
    var0.playerowner = var1;
    thread endturretusewatch(var1, var0);
    thread endturretonplayer(var1, var0);
    self waittill("end_turret_use_" + var0.turretindex);

    if(isDefined(var1)) {
      var1 controlturretoff(var0);
      var1 switchtoweaponimmediate(var1.prevweapon);
      var1 scripts\cp\cp_weapons::_takeweapon(var1.useweapon);
    }

    var0.playerowner = undefined;
    self makeusable();
  }
}

function endturretusewatch(var0, var1) {
  var0 endon("death");
  var0 endon("last_stand");
  var0 endon("disconnect");
  self endon("end_turret_use_" + var1.turretindex);

  while(var0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var0 useButtonPressed()) {
      self notify("end_turret_use_" + var1.turretindex);
      break;
    }

    waitframe();
  }
}

function endturretonplayer(var0, var1) {
  var0 scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand");
  self notify("end_turret_use_" + var1.turretindex);
}

function aiturretthink() {
  scripts\engine\utility::flag_wait("cp_turrets_initted");
  level endon("game_ended");
  self endon("stop_ai_turret_think");
  level.ignoredbycheck = undefined;
  var0 = self.turret;

  if(!isDefined(var0)) {
    return;
  }

  var0 setmode("manual");
  var0 setconvergencetime(1, "yaw");
  var0 setconvergencetime(1, "pitch");
  var0 setturretteam("axis");
  var0.team = "axis";

  for(;;) {
    var1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
    var2 = 0;

    if(isDefined(var0.playerowner)) {
      return;
    }

    if(!aiusingturret(self)) {
      wait 0.1;
      var0 cleartargetentity();
      continue;
    }

    var3 = aiturretgettarget(var0);

    if(!isDefined(var3)) {
      wait 0.5;
      continue;
    }

    var0 settargetentity(var3);
    var0 scripts\engine\utility::ref_143b9(3, "turret_on_target");
    aiturretshoottarget(var0, var3);
  }
}

function aiturretgettarget() {
  level endon("game_ended");
  var0 = undefined;

  while(!isDefined(var0)) {
    var1 = [];

    foreach(var3 in level.players) {
      if(!aiturretcantarget(var3, (0, 0, 50))) {
        continue;
      }

      var1 = var3;
    }

    if(var1.size == 0) {
      wait 0.1;
      continue;
    }

    var0 = scripts\engine\utility::random(var1);
    break;
  }

  return var0;
}

function aiturretcantarget(var0, var1) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var2 = self gettagorigin("tag_flash");
  var3 = 0;
  var4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var5 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var6 = 0; var6 < var5.size; var6++) {
    if(!scripts\engine\trace::ray_trace_passed(var2 + var1, var5[var6], self, var4)) {
      continue;
    }

    var3 = 1;
    break;
  }

  return var3;
}

function aiturretshoottarget(var0) {
  var0 endon("last_stand");
  var0 endon("disconnect");
  self endon("death");
  var1 = 0.15;
  var2 = 20;

  if(!isDefined(self.num_shots_left)) {
    self.num_shots_left = 100;
  }

  for(var3 = 0; var3 < var2; var3++) {
    self shootturret(undefined, 2);
    wait var1;
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

function aiusingturret(var0) {
  var1 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  var2 = 0;

  foreach(var4 in var1) {
    if(distance(var4.origin, self.origin) < 55) {
      return true;
    }
  }

  return false;
}