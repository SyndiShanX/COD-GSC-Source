/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\flashpoint.gsc
***********************************************/

init() {
  level._effect["_encstr_8C131393D1B733687818B47D5329A32A9979EF4F13"] = loadfx("_encstr_95532DB319EB66845899AF95E1728F939F53CA5B80CB2BBBC23D8E78A7335217340B22822894EB73695FD126DD6898");
  level._effect["_encstr_A9131383783153A2C9986CA57DEFEA01F8E0EF6F22"] = loadfx("_encstr_8B522D67CC87F2D2BB83F5DA38E5CC1BC26E3438BD5A9B1DE5B399E1FA330EAFD95737CCB4ECD0E8BE6E19B8B333E1");
  level._effect["_encstr_BA1313C91D69903B13A7F3F5E3C9F2180C7596E352"] = loadfx("_encstr_AD692D9D663C79D2BB83FAAD1CF2CCC6856EA10EED5ADC1DCB6799877D33E0F5B3D573665AD9A13A7D9BCC7167663C");
  level._effect["_encstr_A1CF1699D816CD0D38ED4B37A3EBB3BAE6CC5AE42BAFE698"] = loadfx("_encstr_BEEC33EE555855071CAA416ACB5843FDF8E77850EF08CDBBE85BCA4336C4D3F97083E6CE1BD014E3F81372DA782937AA2A8D765691");
  level._effect["_encstr_81311A9709989B33208DE89EC36E11CB3D8B6F0766EBF0133DE30973"] = loadfx("_encstr_928D300D7B6370A087F816A8123710192A878989C71AA810E7433902F126D8D89367091787C164E8C99F20992511E2848AFB");
  level._effect["_encstr_8CC017333658E61A0E7B5A9B1DD7C157366E957D37C5AE1619"] = loadfx("_encstr_A1E12D0DBF08A6BF8B1AE7F89058277587B240CB702D46A0E2CB46809F44B3576BA399EFA1D1339238CFED25FB1D7A");
  level._effect["_encstr_99151754112ACE289998ECB01B5F77E7A2E69510514392B199"] = loadfx("_encstr_A65C2D1B4889BDD7837B3F3577A0A335E38882F39803257B70440E2898D1C33129AB4A5B60975F5B1121096624392B");
  var_0 = getDvar("_encstr_8A2716B9D89CEBCC36856E86C1DB967347D7D1ED76D96359", 0);
  level.flashpoint_objectives = getDvar("_encstr_8E151A6B32CB50C8ED910F31A81588807B696031CACFF690447E3B3F", 0) == "_encstr_A34C02BB";
  level.iconflashpointfriendly = "_encstr_91391558665746E73373A5B5E78E8EB57327A2D0622338";
  level.iconflashpointenemy = "_encstr_8D84120856CDDB793B1C38F0227FD7C97E57B55A";
  level.iconflashpointcontested = "_encstr_9717162DB17B9B7DDCEEDB2791B9EB8DEDDC8E59DCE82B91";
  level.iconflashpointneutral = "_encstr_AD67145A36B773BE9B777B4E1937BEE695AED14E2C1B";
  level.flashpoint_struct = spawnStruct();
  level.flashpoint_struct.flashpoints = [];
  level.flashpointdebugactive = getdvarint("_encstr_B4B01A3736E4EB99D8C2E61A0EDE96CD472295C4ABEC0536D1D267CA", 0);

  if(istrue(level.flashpoint_usebigmapsettings))
    level.flashpointmindist = 16777216;
  else
    level.flashpointmindist = 4194304;

  if(0 || var_0 == "_encstr_A34C02BB") {
    thread flashpoint_systemthink();
    level.flashpointactive = 1;
  } else
    level.flashpointactive = 0;

  thread flashpoint_systemtoggle();
}

flashpoint_systemtoggle() {
  for(;;) {
    if(getDvar("_encstr_8A2716B9D89CEBCC36856E86C1DB967347D7D1ED76D96359", 0) != "_encstr_934C0218") {
      if(level.flashpoint_objectives)
        thread flashpoint_systemthink();

      level.flashpointactive = 1;

      foreach(var_1 in level.players) {
        if(!isDefined(var_1.flashpoint_trackingevents))
          flashpoint_trackplayerevents(var_1);
      }
    } else {
      level notify("_encstr_9A7D138CD29B5826D895FA9963C2B93483ED5A371D");
      level.flashpointactive = 0;

      if(level.flashpoint_objectives) {
        foreach(var_4 in level.flashpoint_struct.flashpoints)
        flashpoint_shutdown(var_4);
      }
    }

    wait 1;
  }
}

flashpoint_systemthink() {
  level endon("_encstr_9A7D138CD29B5826D895FA9963C2B93483ED5A371D");

  for(;;) {
    foreach(var_1 in level.flashpoint_struct.flashpoints) {
      var_2 = gettime();

      if(var_2 - var_1.lasteventtime > 12500) {
        flashpoint_shutdown(var_1);
        continue;
      }

      if(isDefined(var_1.objective) && var_2 - var_1.lasteventtime >= 7500 && !istrue(var_1.endingsoon))
        flashpoint_endingsoon(var_1);

      var_3 = getarraykeys(var_1.events);

      foreach(var_5 in var_3) {
        if(var_2 - var_5 > 12500)
          var_1.events = scripts\engine\utility::array_remove_key(var_1.events, var_5);
      }
    }

    foreach(var_9 in level.players) {
      if(!isDefined(var_9.flashpoint_trackingevents))
        thread flashpoint_trackplayerevents(var_9);
    }

    wait 1;
  }
}

flashpoint_processnewevent(var_0, var_1, var_2, var_3) {
  if(!level.flashpointactive) {
    return;
  }
  var_4 = (0, 0, 0);

  if(0)
    var_4 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);

  if(var_3 == "_encstr_8F5D08770BFB0B5A658F") {
    var_5 = var_0.origin + (0, 0, 32);

    if(0)
      var_5 = var_5 + var_4;

    thread playvfx(var_5, "_encstr_A9131383783153A2C9986CA57DEFEA01F8E0EF6F22");
  } else {
    var_5 = (0, 0, 0);

    if(level.flashpoint_objectives)
      var_5 = vectorlerp(var_0.origin + (0, 0, 48), var_1.origin + (0, 0, 48), 0.25);
    else
      var_5 = var_1.origin + (0, 0, 48);

    if(0)
      var_5 = var_5 + var_4;

    if(level.flashpoint_objectives) {
      var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
      var_7 = var_6 scripts\engine\utility::array_sort_with_func(level.flashpoint_struct.flashpoints, ::sortlocationsbydistance);
      var_6 delete();

      foreach(var_9 in var_7) {
        if(distancesquared(var_9.curorigin, var_5) < level.flashpointmindist) {
          flashpoint_updatepoint(var_9, var_5, var_2, var_3);
          return;
        }
      }

      if(level.flashpoint_struct.flashpoints.size >= 2)
        flashpoint_clearoldestpoint();

      flashpoint_createnew(var_5, var_2, var_3);
    }

    thread playvfx(var_5, "_encstr_A9131383783153A2C9986CA57DEFEA01F8E0EF6F22");
  }
}

flashpoint_createnew(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.curorigin = var_0;
  var_3.lasteventtime = var_1;
  var_3.team = "_encstr_B40101";
  flashpoint_addeventtoqueue(var_3, var_1, var_2);
  level.flashpoint_struct.flashpoints[level.flashpoint_struct.flashpoints.size] = var_3;
}

flashpoint_createmarker(var_0) {
  var_0.objective = scripts\mp\gameobjects::createobjidobject(var_0.curorigin, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, "_encstr_9A19040BCDBC");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.objective.objidnum, 0);
  var_0.objective.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::update_objective_icon(var_0.objective.objidnum, level.iconflashpointneutral);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0.objective.objidnum, 2);
  var_0.objective.lockupdatingicons = 1;
}

flashpoint_updatepoint(var_0, var_1, var_2, var_3) {
  var_0 notify("_encstr_A29D0B567346D75D0746B04759");
  var_0 endon("_encstr_A29D0B567346D75D0746B04759");
  level endon("_encstr_9A7D138CD29B5826D895FA9963C2B93483ED5A371D");

  if(!isDefined(var_0.objective) && var_0.events.size >= 5)
    flashpoint_createmarker(var_0);

  var_0.endingsoon = 0;
  var_0.lasteventtime = gettime();

  if(isDefined(var_0.objective) && level.flashpoint_objectives)
    scripts\mp\objidpoolmanager::objective_set_pulsate(var_0.objective.objidnum, 0);
  else
    var_0.curorigin = vectorlerp(var_0.curorigin, var_1, 0.75);

  thread playvfx(var_1, "_encstr_A9131383783153A2C9986CA57DEFEA01F8E0EF6F22");
  flashpoint_addeventtoqueue(var_0, var_2, var_3);
}

flashpoint_addeventtoqueue(var_0, var_1, var_2) {
  if(!isDefined(var_0.events))
    var_0.events = [];

  var_0.events[var_1] = var_2;

  if(var_0.events.size > 8) {
    var_3 = [];
    var_4 = 0;

    foreach(var_7, var_6 in var_0.events) {
      if(var_4 > var_0.events.size - 8)
        var_3[var_7] = var_6;

      var_4++;
    }

    var_0.events = var_3;
  }
}

flashpoint_shutdown(var_0) {
  var_0 notify("_encstr_A29D0B567346D75D0746B04759");

  if(isDefined(var_0.objective) && level.flashpoint_objectives) {
    var_0.objective scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
    var_0.objective scripts\mp\gameobjects::releaseid();
    var_0.objective.visibleteam = "_encstr_8BBA05185F8B99";
    var_0.objective = undefined;
  }

  level.flashpoint_struct.flashpoints = scripts\engine\utility::array_remove(level.flashpoint_struct.flashpoints, var_0);
}

flashpoint_endingsoon(var_0) {
  var_0.endingsoon = 1;

  if(level.flashpoint_objectives)
    scripts\mp\objidpoolmanager::objective_set_pulsate(var_0.objective.objidnum, 1);
}

flashpoint_checkforownerupdate(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = "_encstr_BAC80AE125DA08BA08B0805D";
  var_4 = var_0.team;

  foreach(var_6 in var_0.events) {
    if(var_6 == "_encstr_A6830DEF97A36A614387787178C407") {
      var_1++;
      continue;
    }

    if(var_6 == "_encstr_95210FDA19C3F8C7E61371985ABD631107")
      var_2++;
  }

  if((var_1 - 1 > var_2 || var_2 == 0) && var_0.team != "_encstr_8E8405EA382B2A" && var_1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, "_encstr_8E8405EA382B2A");
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 0);
    }

    var_0.team = "_encstr_8E8405EA382B2A";
    var_3 = "_encstr_84AE15D4BB96E836A11051B780141E96B9049EBBB9AC93";
  } else if((var_2 - 1 > var_1 || var_1 == 0) && var_0.team != "_encstr_9A8507BA4040188D08" && var_2 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, "_encstr_9A8507BA4040188D08");
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 0);
    }

    var_0.team = "_encstr_9A8507BA4040188D08";
    var_3 = "_encstr_BD5317721C7BEBD3B8BA9377D2F58432D3BDC22698BF821DC3";
  } else if(var_0.team != "_encstr_A7A408B9CA5D1D4E2C63" && var_2 != 0 && var_1 != 0) {
    if(level.flashpoint_objectives) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(var_0.objidnum, undefined);
      scripts\mp\objidpoolmanager::update_objective_sethot(var_0.objidnum, 1);
    }

    var_0.team = "_encstr_A7A408B9CA5D1D4E2C63";
    var_3 = "_encstr_9B6214BB07A0F37FC3F941FA11BE97ADE09B13044BB0";
  }
}

sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.curorigin, self.origin) < distancesquared(var_1.curorigin, self.origin);
}

flashpoint_clearoldestpoint() {
  var_0 = undefined;

  foreach(var_2 in level.flashpoint_struct.flashpoints) {
    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    if(var_2.lasteventtime > var_0.lasteventtime)
      var_0 = var_2;
  }

  flashpoint_shutdown(var_0);
}

playvfx(var_0, var_1) {
  playFX(scripts\engine\utility::getfx(var_1), var_0);
}

flashpoint_trackplayerevents(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9A7D138CD29B5826D895FA9963C2B93483ED5A371D");
  var_0.flashpoint_trackingevents = 1;

  for(;;) {
    var_0 waittill("_encstr_84750DC45676D2DCAF99B4C94B9B9D");
    wait 1.0;
    flashpoint_processnewevent(var_0, undefined, gettime(), "_encstr_8F5D08770BFB0B5A658F");
    wait 0.25;
  }
}

flashpoint_spawnselectionvfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8EAE1A9B086B3A73763EE0E9C4B827078968026358DF758BC81BF6EB");
  self endon("_encstr_8EAE1A9B086B3A73763EE0E9C4B827078968026358DF758BC81BF6EB");

  while(self.inspawnselection) {
    foreach(var_1 in level.players) {
      if(!isalive(var_1)) {
        continue;
      }
      if(self.team != var_1.team) {
        if(istrue(level.spawnselectionshowenemy))
          playfxontagforclients(level._effect["_encstr_99151754112ACE289998ECB01B5F77E7A2E69510514392B199"], var_1, "_encstr_A130084D2FDAD8AA8F62", self);

        continue;
      }

      if(istrue(level.spawnselectionshowfriendly)) {
        if(self.squadindex == var_1.squadindex) {
          playfxontagforclients(level._effect["_encstr_8CC017333658E61A0E7B5A9B1DD7C157366E957D37C5AE1619"], var_1, "_encstr_A130084D2FDAD8AA8F62", self);
          continue;
        }

        playfxontagforclients(level._effect["_encstr_81311A9709989B33208DE89EC36E11CB3D8B6F0766EBF0133DE30973"], var_1, "_encstr_A130084D2FDAD8AA8F62", self);
      }
    }

    wait 1.1;
  }
}