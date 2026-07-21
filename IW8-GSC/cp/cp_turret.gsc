/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_turret.gsc
***********************************************/

initturrets() {
  scripts\engine\utility::flag_init("_encstr_93A9138D0EBE8E57E439B28E9BF52D372D8ED19523");
  level.interaction_hintstrings["_encstr_8C910EA5C3BB7D39E4F78808FF68B0B5"] = &"_encstr_95302086A0D73D9052A868A2A4ACA2A9E5AAA654D79AA039AA8231AFA2AAA49451A2";
  scripts\cp\cp_interaction::registerinteraction("_encstr_8C910EA5C3BB7D39E4F78808FF68B0B5", ::turret_hint_func, ::turret_use_func, ::turret_init_func);
}

turret_hint_func(var_0, var_1) {
  if(isDefined(var_0.turret) && !var_0.turret.isinuse)
    return &"_encstr_95302086A0D73D9052A868A2A4ACA2A9E5AAA654D79AA039AA8231AFA2AAA49451A2";
  else
    return "_encstr_B40101";
}

turret_init_func(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3.turret = undefined;
    var_4 = scripts\engine\utility::getStructArray(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      var_7 = var_6.origin;
      var_8 = var_6.angles;
      var_9 = scripts\engine\utility::spawn_tag_origin(var_7, var_8);
      var_10 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_9.origin, var_6.weaponinfo, 0);
      var_10.angles = var_9.angles;
      var_10 linkTo(var_9, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
      var_10 setModel("_encstr_97361AEE590B0EDEE6F55B3BAF4C392CECBDA603F5135836D87BDCE5");
      var_10 setnodeploy(1);
      var_10 setdefaultdroppitch(0);
      var_10 makeunusable();
      var_10 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
      var_10 setsentryowner(undefined);
      var_10.targetname = "_encstr_A1B30F47BFDE2CB8DA697733D3905A894C";
      var_11 = getcompleteweaponname("_encstr_85430BD44B30713715784912C3");
      var_10.objweapon = var_11;

      if(isDefined(var_6.script_noteworthy)) {
        var_12 = strtok(var_6.script_noteworthy, "_encstr_964C0249");

        foreach(var_14 in var_12) {
          var_15 = strtok(var_6.script_noteworthy, "_encstr_854C021F");

          if(isDefined(var_15)) {
            if(var_15[0] == "_encstr_9119045173E2") {
              if(isDefined(var_15[1]))
                var_10 setleftarc(int(var_15[1]));

              if(isDefined(var_15[2]))
                var_10 setrightarc(int(var_15[2]));

              if(isDefined(var_15[3]))
                var_10 settoparc(int(var_15[3]));

              if(isDefined(var_15[4]))
                var_10 setbottomarc(int(var_15[4]));
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

  scripts\engine\utility::flag_set("_encstr_93A9138D0EBE8E57E439B28E9BF52D372D8ED19523");
}

turret_use_func(var_0, var_1) {
  var_2 = var_0.turret;

  if(var_2.isinuse)
    return 0;

  var_1.prevweapon = var_1 getcurrentweapon();
  var_1.useweapon = createheadicon(var_2.objweapon);
  var_1 scripts\cp\utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.useweapon, 1) == 0)
    waitframe();

  var_1 controlturreton(var_2);
  var_2.isinuse = 1;
  thread endturretusewatch(var_1, var_2);
  thread endturretonplayer(var_1, var_2);
  self waittill("_encstr_828C10596D9C01C553C3F5D3F3D98DD83589" + var_2.turretindex);

  if(isDefined(var_1)) {
    var_1 controlturretoff(var_2);
    var_1 switchtoweaponimmediate(var_1.prevweapon);
    var_1 scripts\cp\cp_weapons::_takeweapon(var_1.useweapon);
  }

  var_2.isinuse = 0;
  return 1;
}

add_turret(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  var_4 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_3.origin, var_0.weaponinfo, 0);
  var_4.angles = var_3.angles;
  var_4 linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_4 setModel(var_0.model);
  var_4 makeunusable();
  var_4 setnodeploy(1);
  var_4 setdefaultdroppitch(0);
  var_5 = getcompleteweaponname(var_0.weaponinfo);
  var_4.objweapon = var_5;

  if(isDefined(var_0.arclimits)) {
    var_6 = strtok(var_0.arclimits, "_encstr_964C0249");

    foreach(var_8 in var_6) {
      var_9 = strtok(var_0.arclimits, "_encstr_854C021F");

      if(isDefined(var_9)) {
        if(var_9[0] == "_encstr_9119045173E2") {
          if(isDefined(var_9[1]) && var_9[1] != "_encstr_934C0218")
            var_4 setleftarc(int(var_9[1]));

          if(isDefined(var_9[2]) && var_9[2] != "_encstr_934C0218")
            var_4 setrightarc(int(var_9[2]));

          if(isDefined(var_9[3]) && var_9[3] != "_encstr_934C0218")
            var_4 settoparc(int(var_9[3]));

          if(isDefined(var_9[4]) && var_9[4] != "_encstr_934C0218")
            var_4 setbottomarc(int(var_9[4]));
        }
      }
    }
  }

  var_11 = var_4 gettagorigin("_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2");
  var_12 = createinteractobject(var_11);
  var_12 linkTo(var_4, "_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2", (0, 0, 5), (0, 0, 0));
  var_12 thread turretthink(var_4);
  var_0 delete();
}

createinteractobject(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 makeusable();
  var_1 setuseprioritymax();
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethinticon("_encstr_922B1009ADCF297B4732705EEB77AE182704");
  var_1 setHintString(&"_encstr_9AD1207C0B2970EB3751DFD7818FAF789B3033E2D0FF38CE1F39A7A759676DB1EF59");
  var_1 sethintonobstruction("_encstr_BECC055CF3811A");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(120);
  var_1 setuserange(50);
  var_1 setusefov(120);
  return var_1;
}

turretthink(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = createheadicon(var_0.objweapon);
    var_1 scripts\cp\utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_1.useweapon, 1) == 0)
      waitframe();

    var_1 controlturreton(var_0);
    var_0.playerowner = var_1;
    thread endturretusewatch(var_1, var_0);
    thread endturretonplayer(var_1, var_0);
    self waittill("_encstr_828C10596D9C01C553C3F5D3F3D98DD83589" + var_0.turretindex);

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp\cp_weapons::_takeweapon(var_1.useweapon);
    }

    var_0.playerowner = undefined;
    self makeusable();
  }
}

endturretusewatch(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_828C10596D9C01C553C3F5D3F3D98DD83589" + var_1.turretindex);

  while(var_0 useButtonPressed())
    waitframe();

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("_encstr_828C10596D9C01C553C3F5D3F3D98DD83589" + var_1.turretindex);
      break;
    }

    waitframe();
  }
}

endturretonplayer(var_0, var_1) {
  var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify("_encstr_828C10596D9C01C553C3F5D3F3D98DD83589" + var_1.turretindex);
}

aiturretthink() {
  scripts\engine\utility::flag_wait("_encstr_93A9138D0EBE8E57E439B28E9BF52D372D8ED19523");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BE5E156E2415B2D11ECB51E14BB0F6F2D477F5A8A0F0F2");
  level.ignoredbycheck = undefined;
  var_0 = self.turret;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setmode("_encstr_849007B268BD03DFD8");
  var_0 setconvergencetime(1, "_encstr_AF1904C7E3A4");
  var_0 setconvergencetime(1, "_encstr_BD6506F36A2B46B0");
  var_0 setturretteam("_encstr_8E8405EA382B2A");
  var_0.team = "_encstr_8E8405EA382B2A";

  for(;;) {
    var_1 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_2 = 0;

    if(isDefined(var_0.playerowner)) {
      return;
    }
    if(!aiusingturret(self)) {
      wait 0.1;
      var_0 cleartargetentity();
      continue;
    }

    var_3 = var_0 aiturretgettarget();

    if(!isDefined(var_3)) {
      wait 0.5;
      continue;
    }

    var_0 settargetentity(var_3);
    var_0 scripts\engine\utility::_id_143B9(3, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
    var_0 aiturretshoottarget(var_3);
  }
}

aiturretgettarget() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!aiturretcantarget(var_3, (0, 0, 50))) {
        continue;
      }
      var_1[var_1.size] = var_3;
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

aiturretcantarget(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_2 = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_3 = 0;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 0, 1);
  var_5 = [var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_0 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37")];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!scripts\engine\trace::ray_trace_passed(var_2 + var_1, var_5[var_6], self, var_4)) {
      continue;
    }
    var_3 = 1;
    break;
  }

  return var_3;
}

aiturretshoottarget(var_0) {
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 0.15;
  var_2 = 20;

  if(!isDefined(self.num_shots_left))
    self.num_shots_left = 100;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self shootturret(undefined, 2);
    wait(var_1);
    self.num_shots_left--;

    if(!aiusingturret(self))
      return;
  }

  if(self.num_shots_left <= 0) {
    self.num_shots_left = 100;
    wait(randomintrange(5, 8));
  }
}

aiusingturret(var_0) {
  var_1 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(distance(var_4.origin, self.origin) < 55)
      return 1;
  }

  return 0;
}