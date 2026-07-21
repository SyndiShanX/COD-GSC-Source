/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\turret.gsc
***********************************************/

init() {
  var_0 = getEntArray("_encstr_95640A1DBA4E4E9547EBD683", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.gametype == "_encstr_B607038AAB") {
    foreach(var_2 in var_0)
    var_2 delete();

    return;
  }

  foreach(var_2 in var_0)
  add_turret(var_2);
}

add_turret(var_0) {
  var_0 makeunusable();
  var_0 setnodeploy(1);
  var_0 setdefaultdroppitch(0);
  var_1 = getcompleteweaponname(var_0.weaponinfo);
  var_0.objweapon = var_1;

  if(isDefined(var_0.script_noteworthy)) {
    var_2 = strtok(var_0.script_noteworthy, "_encstr_964C0249");

    foreach(var_4 in var_2) {
      var_5 = strtok(var_4, "_encstr_854C021F");

      if(isDefined(var_5)) {
        if(var_5[0] == "_encstr_9119045173E2") {
          if(isDefined(var_5[1]) && var_5[1] != "_encstr_934C0218")
            var_0 setleftarc(int(var_5[1]));

          if(isDefined(var_5[2]) && var_5[2] != "_encstr_934C0218")
            var_0 setrightarc(int(var_5[2]));

          if(isDefined(var_5[3]) && var_5[3] != "_encstr_934C0218")
            var_0 settoparc(int(var_5[3]));

          if(isDefined(var_5[4]) && var_5[4] != "_encstr_934C0218")
            var_0 setbottomarc(int(var_5[4]));
        }
      }
    }
  }

  var_7 = var_0 gettagorigin("_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2");
  var_8 = scripts\mp\gameobjects::createhintobject(var_7, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_922B1009ADCF297B4732705EEB77AE182704", &"_encstr_9AD1207C0B2970EB3751DFD7818FAF789B3033E2D0FF38CE1F39A7A759676DB1EF59");
  var_8 linkTo(var_0, "_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2", (0, 0, 5), (0, 0, 0));
  var_0.useobj = var_8;
  var_8 thread turretthink(var_0);
  var_9 = var_0 gettagorigin("_encstr_8E010B996FB7B6B3C1D1183343");
  var_0.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9);
  var_0.killcament linkTo(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", (-60, 0, 20), (0, 0, 0));
}

turretthink(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    thread endturretonplayer(var_1);
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = createheadicon(var_0.objweapon);
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0)
      waitframe();

    var_1 controlturreton(var_0);
    thread endturretusewatch(var_1, var_0);
    self waittill("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeusable();
  }
}

endturretusewatch(var_0, var_1) {
  while(var_0 useButtonPressed())
    waitframe();

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
      break;
    }

    waitframe();
  }
}

endturretonplayer(var_0) {
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
}