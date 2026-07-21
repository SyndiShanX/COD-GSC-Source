/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58258.gsc
***********************************************/

init() {
  level.delete_pipe_ents = spawnStruct();
  level.delete_pipe_ents.scriptables = [];
  level._encstr_92B319ED27EBC2C8CE04773D80437812C0E87C63633D8B4933E6CF = getdvarint("_encstr_8ED420B6474327F06D0158BA73F3A7B8D3A702EDD717DA0F289386193D233417D939", 2);
  level._encstr_8BC4180DA3A07AD756FB6AA28D250FF4C02FB39B3768C5BBF7D0 = getdvarint("_encstr_A9121FD71B537F02CD806D667BF1AA1AFB881B1398ACB11AE7A2F29769A7B2D140", 20);
  level._effect["_encstr_AC1510CE7578694BFEAB21DBA956871F78EF"] = loadfx("_encstr_8AD62F2327D2AD98742B5FF036D733471AAA602AAF119BF1411FCDC740A0EC4F62605DABD701D8C667A90F1B271713DB71");
}

wait_between_combat_action(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_1 thread vfx_htown_hadirj_blink(var_0);
  var_1 thread wait_between_stations(var_0);
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  var_1 notify("_encstr_96BE14A8527F06E061D44D7FE859B0C3D3CA23307A8B");
  thread wait_at_station(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0))
      var_0 delete();

    if(isDefined(var_1.super))
      var_1 scripts\mp\supers::superusefinished(1);

    return;
  }

  var_1 _id_1366A(var_2);

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

_id_1366A(var_0) {
  _encstr_A6461CC6D8592CCDABC1B0B1D813571D3CB64BBDCD5BDCCCDBE41D562CB5(self.team);
  _encstr_8C4317B558B92C7659D963B71385C6B6D2BD6EB5D8DEAB731D();
  var_1 = 4096;

  if(istrue(self.umbra))
    var_1 = 10000;

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, var_1));
  var_2 setModel("_encstr_921821C9DDA16923234FA3DB7BC3184058AF56CACFC05520AFE86F21A980137EA3C795");
  var_2 physicslaunchserver();
  var_2 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_BE8B08E323FB2BCD6268", 0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_2);
  var_2.visible = 1;
  var_2._encstr_9B3B102B429B47DBE40F9018E703708F73EC = 1;
  var_2.managerespawnfade = 1;
  var_2.team = self.team;
  level.delete_pipe_ents.scriptables[level.delete_pipe_ents.scriptables.size] = var_2;
  var_2 thread _id_11CFE();
  var_2 thread _id_11D0B();
  var_2 thread _id_11D17();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A54D0DD503E7F9C7261218B0BB7D51", self);
}

_encstr_A6461CC6D8592CCDABC1B0B1D813571D3CB64BBDCD5BDCCCDBE41D562CB5(var_0) {
  var_1 = [];

  foreach(var_3 in level.delete_pipe_ents.scriptables) {
    if(!isDefined(var_3) || !isDefined(var_3.team) || var_3.team != var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_5 = var_1.size - (level._encstr_92B319ED27EBC2C8CE04773D80437812C0E87C63633D8B4933E6CF - 1);

  if(var_5 <= 0) {
    return;
  }
  for(var_6 = var_5 - 1; var_6 >= 0; var_6--) {
    var_7 = var_1[var_6];
    _encstr_851C15A493B641B8BF6BA82A5354A07E183DE098CDE730(var_7);
  }
}

_encstr_8C4317B558B92C7659D963B71385C6B6D2BD6EB5D8DEAB731D() {
  if(level.delete_pipe_ents.scriptables.size >= level._encstr_8BC4180DA3A07AD756FB6AA28D250FF4C02FB39B3768C5BBF7D0)
    _encstr_851C15A493B641B8BF6BA82A5354A07E183DE098CDE730(level.delete_pipe_ents.scriptables[0]);
}

dangercircletick(var_0, var_1) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B48D064CB8E8E33A") || getdvarint("_encstr_ADE01BBBE21B60D85A9F6F63C742C828DF1A90A01BBFB818B4AA0771F5", 0) == 1) {
    return;
  }
  var_2 = var_1 * var_1;

  foreach(var_4 in level.delete_pipe_ents.scriptables) {
    if(isDefined(var_4.visible) && isDefined(var_4.origin) && distance2dsquared(var_4.origin, var_0) > var_2)
      _encstr_851C15A493B641B8BF6BA82A5354A07E183DE098CDE730(var_4);
  }
}

_encstr_851C15A493B641B8BF6BA82A5354A07E183DE098CDE730(var_0) {
  var_0 setscriptablepartstate("_encstr_9AB90F3127BEC1B1EA738CCA93D726DEE1", "_encstr_921D09D9D9C0090D7275B4");
  var_0.visible = undefined;
  var_0.disabled = 1;
  var_0 notify("_encstr_A28C1783DE9CD1853163B22DA5DEB9B5F591D2B985138D95C8");

  if(var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::gethelispawns())
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdropedtime();

  playFX(scripts\engine\utility::getfx("_encstr_AC1510CE7578694BFEAB21DBA956871F78EF"), var_0.origin);
  playsoundatpos(var_0.origin, "_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");
  level.delete_pipe_ents.scriptables = scripts\engine\utility::array_remove(level.delete_pipe_ents.scriptables, var_0);
  var_0 delete();
}

_id_11D17() {
  _id_11D18();
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_958317B5BDDC2DE8BD39A0D816F295E44AD6C1C2C6D1A87391");
  var_0 = self;

  if(isDefined(self.mountmantlemodel))
    var_0 = self.mountmantlemodel;

  var_1 = undefined;

  if(isDefined(self.owner))
    var_1 = self.owner;

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_93410E6B08AB38F713F8203D8638BF07", var_2, var_3);

    if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2)) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = var_3[2] <= -8;
      var_5 = 0;
      var_6 = undefined;

      if(var_2 tagexists("_encstr_8FE10B52092BB64F28E6B7BFFD")) {
        var_6 = var_2 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
        var_7 = self.origin + anglestoup(self.angles) * 27.5;
        var_5 = var_6[2] <= var_7[2];
      }

      if(var_4 && var_5) {
        var_8 = var_1;

        if(!isDefined(var_8))
          var_8 = var_2;
      }
    }
  }
}

_id_11D18() {
  self notify("_encstr_958317B5BDDC2DE8BD39A0D816F295E44AD6C1C2C6D1A87391");
}

_id_1273B(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"), var_0, var_1);

  if(var_2 < 150)
    self playsurfacesound("_encstr_8EC81BB5C1FAB185C995EB072C366D0BCEB27DB1DE77EBA5B583851BD1", var_3);
  else if(var_2 < 300)
    self playsurfacesound("_encstr_BD5C1BF7C0AE2B5AB5E5897ADFBF32F17180C77FF0615F82F3070EB6BD", var_3);
  else
    self playsurfacesound("_encstr_BEEB1CF5796146279E0141BBE97E77BEC8CB4F48E3784C17CB38ABD2B1CD", var_3);

  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
}

_id_11CFE() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_937320E83FEE509182F2C7640F6B83D94D43209857BBE8590BD658656B23C1C1A427");
  self endon("_encstr_937320E83FEE509182F2C7640F6B83D94D43209857BBE8590BD658656B23C1C1A427");
  var_0 = 0.1;
  thread scripts\cp_mp\killstreaks\airdrop::_id_11CFD(var_0, 8);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0"))
    var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0");

  for(;;) {
    var_5 = scripts\cp_mp\killstreaks\airdrop::registeronplayerjointeamnospectatorcallback();
    var_6 = scripts\cp_mp\killstreaks\airdrop::registeronplayerdisconnect();

    if(isDefined(var_5) && isDefined(var_6)) {
      if(var_5 <= 5.0 && var_6 <= 1.0) {
        var_1++;
        var_2 = 0;

        if(var_1 == 6) {
          self._id_12332 = 1;
          var_3 = self.origin;

          if(isDefined(var_4) && [[var_4]]()) {
            _id_11D0C();

            if(isDefined(self.killcament))
              self.killcament delete();
          }

          var_0 = 0.1;
          thread scripts\cp_mp\killstreaks\airdrop::_id_11CFD(var_0, 3, 3);
        }
      } else {
        if(isDefined(var_3)) {
          if(distancesquared(self.origin, var_3) <= 2500) {
            wait(var_0);
            continue;
          }
        }

        var_2++;
        var_1 = 0;

        if(var_2 == 1) {
          self._id_12332 = undefined;
          var_0 = 0.1;
          thread scripts\cp_mp\killstreaks\airdrop::_id_11CFD(var_0, 8);
        }
      }

      wait(var_0);
      continue;
    }

    waitframe();
  }
}

_id_11D0B(var_0) {
  _id_11D0C();
  self endon("_encstr_927011315D6253F317BB21089B3129D178853D");
  self._id_11D0E = 1;
  self playLoopSound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
  self physics_registerforcollisioncallback();
  _id_11D0D(var_0);

  if(isDefined(self))
    thread _id_11D0C();
}

_id_11D0D(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    wait(var_0);

  var_1 = 0;

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && scripts\cp_mp\killstreaks\airdrop::start_chants_on_movement(var_9)) {
      if(var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks())
        var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
    }

    if(gettime() - var_1 >= 2) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["_encstr_84BA05A8CA852B"], 9);

      if(var_11 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
        var_11 = "_encstr_AA9D0F9543A77B872312D8C04A3CAD964E";

      if(var_11 == "_encstr_9B140E63868B6317C37893AB6058EEDF")
        var_11 = "_encstr_8A9D0F4F7F25B3CF2829E2EA412836B9A5";

      _id_1273B(var_6, var_7, var_8, var_11);
    }
  }
}

_id_11D0C() {
  if(!istrue(self._id_11D0E)) {
    return;
  }
  self notify("_encstr_927011315D6253F317BB21089B3129D178853D");
  self._id_11D0E = undefined;
  self stoploopsound("_encstr_BD7A181973D84F9F5B7F2FD3A6C828096765C6CDE340330188DB");
  self physics_unregisterforcollisioncallback();
}

vfx_htown_hadirj_blink(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  wait 10;

  if(isDefined(var_0))
    var_0 delete();

  var_1 notify("_encstr_847D0C3BF35DF8F36A7FB0B0DD20");
}

wait_between_stations(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_96BE14A8527F06E061D44D7FE859B0C3D3CA23307A8B");
  var_0 waittill("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(var_1.super))
    var_1 scripts\mp\supers::superusefinished(1);
}

wait_at_station(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1 playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 21;
  var_1 playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  var_1 stoploopsound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 5;
  var_1 delete();
}