/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\light_tank_mp.gsc
***********************************************/

light_tank_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_85AD0950914BBF136ACB7F", ::light_tank_mp_activate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_AF850D78A3F7FD1197C95B03F0F2B9", ::light_tank_mp_startcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_92E80B695DACD17FD30B0B0D67", ::light_tank_mp_endcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BDD01133A5D8E8AC9C4493B71C9A380BBB37CD", ::light_tank_mp_filterdropspawns);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_870C179D561D2239B707351C2CEECD25CEDC7B4EAC98D2CD1D", ::light_tank_mp_getdropspawnignorelist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::light_tank_mp_spawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_BAF609D2739647C4853A2B", ::light_tank_mp_initlate);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("_encstr_AF390B295782C3585F1B21D8C4", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitteaminstances("_encstr_AF390B295782C3585F1B21D8C4", 3);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(scripts\cp_mp\vehicles\light_tank::light_tank_updateheadiconforplayeronjointeam);
  light_tank_mp_initmines();
  light_tank_mp_initspawning();
  light_tank_mp_initcapture();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_AF390B295782C3585F1B21D8C4", scripts\cp_mp\vehicles\light_tank::light_tank_explode);
}

light_tank_mp_initlate() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8CC008133958C81BACCB", scripts\cp_mp\vehicles\light_tank::light_tank_tryusefromstruct);
}

light_tank_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.frontextents = 115;
  var_0.backextents = 110;
  var_0.leftextents = 60;
  var_0.rightextents = 60;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
}

light_tank_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_AF390B295782C3585F1B21D8C4", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\light_tank::light_tank_timeout;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    var_0.areplayersnear = 105;
    var_0._id_12CA1 = level._id_13A58;
  } else
    var_0.areplayersnear = 40;
}

light_tank_mp_initcapture() {
  scripts\mp\playeractions::registeractionset("_encstr_A12C0FD0F708709F9217E68F2A6BCB5B6D", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_AC20072B9FA9487832", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
}

light_tank_mp_activate(var_0) {
  var_0 thread bctracking();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registerinstance(var_0);
}

light_tank_mp_startcapture(var_0, var_1, var_2) {
  if(isDefined(var_1))
    light_tank_mp_createownercaptureobject(var_0, var_1);

  if(level.teambased)
    light_tank_mp_createothercaptureobject(var_0);
}

light_tank_mp_endcapture(var_0) {
  var_0 light_tank_mp_deletecaptureobjects();
}

light_tank_mp_createownercaptureobject(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2 gettagorigin("_encstr_8E010BD97FBFB633D1F1197347"));
  var_3 linkTo(var_2);
  var_3 light_tank_mp_setupcaptureobject(0.5);
  var_3.vehicle = var_0;
  var_0.ownercaptureobject = var_3;
  var_3 thread light_tank_mp_monitorownercapture(var_1, var_0);
  var_3 thread light_tank_mp_monitorownercapturevisibility(var_1);
  return var_3;
}

light_tank_mp_createothercaptureobject(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 gettagorigin("_encstr_8E010BD97FBFB633D1F1197347"));
  var_2 linkTo(var_1);
  var_2 light_tank_mp_setupcaptureobject(3);
  var_2.vehicle = var_0;
  var_0.othercaptureobject = var_2;
  var_2 thread light_tank_mp_monitorothercapture(var_0);
  var_2 thread light_tank_mp_monitorothercapturevisibility();
  return var_2;
}

light_tank_mp_setupcaptureobject(var_0) {
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");

  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    self setHintString(&"_encstr_A6B32212D1434D3EC9E5DD1813FFE9933B153B8310D29ACF1861871BDFE6015999C7636D");

  self sethinttag("_encstr_8BBA05185F8B99");
  self sethintdisplayrange(200);
  self sethintdisplayfov(360);
  self setuserange(200);
  self setusefov(360);
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self setusehideprogressbar(1);
  self makeusable();
  self.userate = 1;
  self.curprogress = 0;
  self.usetime = var_0;
  self.inuse = 0;
  self.playerusing = undefined;
  self.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
}

light_tank_mp_deletecaptureobject() {
  if(isDefined(self.playerusing))
    light_tank_mp_playerstopcapture(self.playerusing);

  self delete();
}

light_tank_mp_deletecaptureobjects() {
  if(isDefined(self.ownercaptureobject))
    self.ownercaptureobject light_tank_mp_deletecaptureobject();

  if(isDefined(self.othercaptureobject))
    self.othercaptureobject light_tank_mp_deletecaptureobject();
}

light_tank_mp_monitorownercapture(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.vehicle = var_1;

  for(;;) {
    self waittillmatch("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(light_tank_mp_canstartcapture(var_0)) {
      self.playerusing = var_0;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var_0);
      var_2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;
      light_tank_mp_playerstopcapture(var_0);

      if(istrue(var_2))
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var_1, var_0);

      waitframe();
    }
  }
}

light_tank_mp_monitorothercapture(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(light_tank_mp_canstartcapture(var_1)) {
      self.playerusing = var_1;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(var_1);
      var_2 = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;

      if(isDefined(var_1))
        light_tank_mp_playerstopcapture(var_1);

      if(istrue(var_2))
        thread scripts\cp_mp\vehicles\light_tank::light_tank_capture(var_0, var_1);

      waitframe();
    }
  }
}

light_tank_mp_monitorcaptureinternal() {
  self.playerusing endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(light_tank_mp_cankeepcapturing()) {
    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(self.curprogress >= self.usetime)
      return 1;

    self.playerusing scripts\mp\gameobjects::updateuiprogress(self, 1);
    waitframe();
  }
}

light_tank_mp_monitorownercapturevisibility(var_0) {
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      self disableplayeruse(var_2);

      if(var_2 == var_0) {
        if(isDefined(self.playerusing)) {
          if(light_tank_mp_cankeepcapturing())
            self enableplayeruse(var_0);

          continue;
        }

        if(light_tank_mp_canstartcapture(var_0))
          self enableplayeruse(var_0);
      }
    }

    wait 0.1;
  }

  thread light_tank_mp_deletecaptureobject();
}

light_tank_mp_monitorothercapturevisibility() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(self.playerusing)) {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(var_1 == self.playerusing) {
          if(light_tank_mp_cankeepcapturing())
            self enableplayeruse(var_1);
        }
      }
    } else {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(light_tank_mp_canstartcapture(var_1))
          self enableplayeruse(var_1);
      }
    }

    wait 0.1;
  }
}

light_tank_mp_canstartcapture(var_0) {
  if(istrue(self.vehicle.isdestroyed))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  if(!var_0 scripts\common\utility::is_vehicle_use_allowed())
    return 0;

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(var_0, self.vehicle)))
    return 0;

  return 1;
}

light_tank_mp_cankeepcapturing() {
  if(istrue(self.vehicle.isdestroyed))
    return 0;

  if(!self.playerusing scripts\common\utility::is_vehicle_use_allowed())
    return 0;

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(self.playerusing, self.vehicle)))
    return 0;

  if(!self.playerusing useButtonPressed())
    return 0;

  if(self.playerusing isonladder())
    return 0;

  if(self.playerusing meleeButtonPressed())
    return 0;

  if(distancesquared(self.playerusing.origin, self.origin) > 90000)
    return 0;

  return 1;
}

light_tank_mp_playerstartcapture(var_0) {
  var_0 scripts\mp\playeractions::allowactionset("_encstr_A12C0FD0F708709F9217E68F2A6BCB5B6D", 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

light_tank_mp_playerstopcapture(var_0) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    var_0 scripts\mp\playeractions::allowactionset("_encstr_A12C0FD0F708709F9217E68F2A6BCB5B6D", 1);

  var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
}

light_tank_mp_shouldawardattacker(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(level.teambased && var_1.team == var_0.team)
    return 0;

  if(isDefined(var_0.owner) && var_1 == var_0.owner)
    return 0;

  return 1;
}

bctracking() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(scripts\mp\utility\teams::isgameplayteam(self.team)) {
      var_0 = scripts\common\utility::playersinsphere(self.origin, 3000);

      foreach(var_2 in var_0) {
        var_3 = isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && scripts\mp\utility\player::isenemy(var_2);

        if(!var_3) {
          continue;
        }
        var_4 = anglesToForward(var_2 getplayerangles());
        var_5 = scripts\engine\math::anglebetweenvectors(var_4, self.origin - var_2.origin);

        if(isDefined(var_5) && var_5 <= 60) {
          if(self sightconetrace(var_2 getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

light_tank_mp_spawncallback(var_0, var_1) {
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_0);

  if(!isDefined(var_0.spawnmethod))
    var_0.spawnmethod = "_encstr_B813195051C942790FB923A7D920974723C3159399431857D9BFB5";

  if(!isDefined(var_0.showheadicon))
    var_0.showheadicon = 0;

  var_0.cantimeout = 0;
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::light_tank_mp_ondeathrespawncallback;

  return var_2;
}

light_tank_mp_ondeathrespawncallback() {
  thread light_tank_mp_waitandspawn();
}

light_tank_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  scripts\cp_mp\vehicles\light_tank::light_tank_copyspawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_AF390B295782C3585F1B21D8C4", var_1, var_2);

  if(isDefined(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
      if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::droptank_playincomingdialog(var_1);

      if(istrue(level._id_13377))
        _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_1413B(var_3, var_3.team);

      foreach(var_5 in level.players) {
        if(var_5.team == var_3.team)
          var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(62, undefined, 5);
      }
    }
  }
}

light_tank_mp_filterdropspawns(var_0) {
  var_1 = var_0;

  if(isDefined(level.vehspawnvol)) {
    var_1 = [];

    foreach(var_3 in var_0) {
      if(ispointinvolume(var_3.origin, level.vehspawnvol))
        var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

light_tank_mp_getdropspawnignorelist(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;

  if(isDefined(level.helis))
    var_1[var_1.size] = level.helis;

  if(isDefined(level.littlebirds))
    var_1[var_1.size] = level.littlebirds;

  if(isDefined(level.supportdrones))
    var_1[var_1.size] = level.supportdrones;

  var_1[var_1.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_8F2C0AB2DA1CD74639B7372B");
  var_1[var_1.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_B270105ECB28E94BC5CFABAB937D524C5053");
  return scripts\engine\utility::array_combine_multiple(var_1);
}