/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\rally_point.gsc
***********************************************/

init() {
  level.iconrallypoint = "_encstr_934C1AB436DE73BEBBB02F1C7B4BE61DFA67ACD02D8DD8B2BE0BE036";
  level.iconrallypointheli = "_encstr_B4B922700AE59DAE9731EB6707D7B06141C39880423E21A15F54FB5DF42B196F769AB868";
}

makerallypoint(var_0) {
  if(istrue(var_0.israllypoint)) {
    return;
  }
  var_0.israllypoint = 1;
  var_0.registeredrallypointplayers = [];
  var_0.autorespawntime = getdvarint("_encstr_A10C1A38923A17A303D90375A2A76833224B80882AD5A9FB2FCD05F6");

  if(!isDefined(level.rallypoints))
    level.rallypoints = [];

  level.rallypoints[level.rallypoints.size] = var_0;
  thread watchforplayerdeath(var_0);
  thread watchforrallypointdeath(var_0);
}

registerplayerwithrallypoint(var_0, var_1) {
  if(!istrue(var_1.israllypoint)) {
    debugprint("_encstr_B82C4695222B6B78D72AA3E012FAD1BFF28A7D85BA16C3E9A873A058EF1241C79AF3FBBFD68A09C862739890B3188331A29B47932AC64DB05C72B08283715841CB16E72804FA3150");
    return;
  }

  debugprint(var_0.name + "_encstr_BD2028800DC23740135959CD8027CA9DD2E6D1B293954604DDE8A5A1089C0BB1C65E041CEDA59BA3E880" + var_1.targetname);
  var_0.rallypoint = var_1;
  var_0.beingrallyrespawned = 0;
  var_1.registeredrallypointplayers[var_1.registeredrallypointplayers.size] = var_0;
}

watchforplayerdeath(var_0) {
  while(isDefined(var_0)) {
    foreach(var_2 in var_0.registeredrallypointplayers) {
      if(!isDefined(var_2)) {
        var_0.registeredrallypointplayers = scripts\engine\utility::array_remove(var_0.registeredrallypointplayers, var_2);
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_2) && isDefined(var_2.rallypoint) && !var_2.beingrallyrespawned)
        prepareplayerforrespawn(var_2, var_0);
    }

    wait 0.1;
  }
}

prepareplayerforrespawn(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B28110A395C2D67DB2B12DAD5A37B0475919");
  var_2 = ["_encstr_A67E14DDB7A36AE8B7A360706E835FA84F47987AF8B0", "_encstr_96BC168BD273897061C07773F6937945FF6BC373DAFFB5D0"];
  var_3 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(var_2, var_1.autorespawntime);

  if(var_3 == "_encstr_96BC168BD273897061C07773F6937945FF6BC373DAFFB5D0") {
    if(isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      return;
    }
    var_4 = var_0 scripts\mp\utility\lower_message::getlowermessage();
    var_5 = var_4.time;
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(28, int(gettime() + self.timeuntilbleedout * 1000));
    waitframe();
    var_0.lowertimer settimer(var_0.timelefttospawnaction);
    return;
  }

  var_0.beingrallyrespawned = 1;
  var_6 = vectorNormalize(anglesToForward(var_1.angles));
  var_6 = var_6 * -175 + var_1.origin;
  var_0.forcespawnorigin = getclosestpointonnavmesh(var_6);
  waitframe();
  debugprint("_encstr_81B72B1A39D3837D5322E3A7A04B312BB5C31D4FB77B8BC0BB0B938B9869F85213E8E31609BFB2C943B8A7FBBA" + var_0.forcespawnorigin);
  var_0.forcespawnangles = (0, 90, 0);
  var_0 notify("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  var_0 scripts\mp\utility\player::_freezecontrols(0);
  var_0 thread scripts\mp\teamrevive::respawn();
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0.01);
  var_0.ui_securing = undefined;

  while(!scripts\mp\utility\player::isreallyalive(var_0))
    wait 0.1;

  var_0.beingrallyrespawned = 0;
}

watchforrallypointdeath(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");

  foreach(var_2 in var_0.registeredrallypointplayers) {
    var_2 notify("_encstr_96BC168BD273897061C07773F6937945FF6BC373DAFFB5D0");
    var_2 iprintlnbold("_encstr_997524FE35135BF13D5680135FBAC8A83B525361836FA3B6D5172BAD67D0EDA2C06A906037A8");
  }
}

debugprint(var_0) {
  if(1)
    return;
}

rallypointvehicle_activate(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var_0);
  var_2 = var_0.team;
  var_3 = var_1.ref;
  var_0.israllypointvehicle = 1;
  thread scripts\mp\spawnselection::_id_1424C(var_0);

  if(var_2 == "_encstr_8E8405EA382B2A") {
    scripts\mp\spawnselection::adddynamicspawnarea(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level.axisspawnareas))
      level.axisspawnareas = [];

    level.axisspawnareas[level.axisspawnareas.size] = var_3;
    scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, var_2);
  } else {
    scripts\mp\spawnselection::adddynamicspawnarea(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level.alliesspawnareas))
      level.alliesspawnareas = [];

    level.alliesspawnareas[level.alliesspawnareas.size] = var_3;
    scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, var_2);
  }

  var_0.ref = var_3;
  rallypoint_activatevehiclemarker(var_0);
  thread rallypoint_watchforvehicledeath(var_0);
  thread rallypoint_wathcforenemydiscovery(var_0);
}

rallypointvehicle_deactivate(var_0) {}

_id_129F2(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_2);
      var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
    }
  }
}

rallypoint_watchforvehicledeath(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");

  if(var_0.team == "_encstr_8E8405EA382B2A")
    level.axisspawnareas = scripts\engine\utility::array_remove(level.axisspawnareas, var_0.ref);
  else
    level.alliesspawnareas = scripts\engine\utility::array_remove(level.alliesspawnareas, var_0.ref);

  rallypoint_deacivatevehiclemarker(var_0);
  scripts\mp\spawnselection::removedynamicspawnarea(var_0.team, var_0.ref);
  scripts\mp\spawnselection::removespawnlocation(var_0.ref, var_0.team);
}

rallypoint_activatevehiclemarker(var_0) {
  var_1 = "_encstr_ACFC091AE8AB2FCBE15119";
  var_2 = var_0.origin + (0, 0, 128);
  var_3 = scripts\mp\gameobjects::createobjidobject(var_2, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_1, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_3.objidnum, var_0.team);
  var_0.marker = var_3;

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    foreach(var_5 in level.players) {
      if(var_5.team == var_0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_5);
        var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objidnum);
    thread _id_129F2(var_0);
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(var_3.objidnum, 0);
  var_3.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_3.objidnum, scripts\engine\utility::ter_op(var_0.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_0.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", level.iconrallypointheli, level.iconrallypoint));
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_3.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_0.marker.objidnum, 128);
  var_3.lockupdatingicons = 1;
  var_0.marker = var_3;
}

rallypoint_deacivatevehiclemarker(var_0) {
  var_0.marker scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_0.marker scripts\mp\gameobjects::releaseid();
  var_0.marker.visibleteam = "_encstr_8BBA05185F8B99";
}

rallypoint_wathcforenemydiscovery(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    waitframe();

  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.origin - (0, 0, 512), 0, 1024, 1536);
  var_1 thread watchrallytriggeruse(var_0);
  var_1 waittill("_encstr_AD4714AA289849BB3BE7ABAA8B08C3FDC348C98363FB");
  var_1 delete();
}

watchrallytriggeruse(var_0) {
  self endon("_encstr_AD4714AA289849BB3BE7ABAA8B08C3FDC348C98363FB");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    waitframe();

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isalive(var_1)) {
      continue;
    }
    if(var_1.team == var_0.team) {
      continue;
    }
    var_0.revealed = 1;

    foreach(var_3 in level.players)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);

    self notify("_encstr_AD4714AA289849BB3BE7ABAA8B08C3FDC348C98363FB");
  }
}

rallypoint_showtoplayer(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    waitframe();

  while(!isDefined(var_0.team) || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    waitframe();

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_2 in level.rallypointvehicles) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_0.team == var_2.team)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.marker.objidnum, var_0);
    }
  }
}