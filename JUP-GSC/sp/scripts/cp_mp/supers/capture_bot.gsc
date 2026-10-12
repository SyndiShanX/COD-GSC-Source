/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\supers\capture_bot.gsc
************************************************/



#using script_608c50392df8c7d1;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace capture_bot;

function autoexec main() {
  utility::registersharedfunc("super_capture_bot", "init", &function_67dd16c63e4dfc65);
}

function function_67dd16c63e4dfc65() {
  level.var_e0f77360ddb0ba30 = [];

  if(utility::issharedfuncdefined("team_utility", "joinTeamAggregator")) {
    [[utility::getsharedfunc("team_utility", "joinTeamAggregator")]](&function_287c3582fae35289);
  }

  level.var_92b4162e3c890dc0 = utility::default_to(level.var_92b4162e3c890dc0, []);
  level.var_92b4162e3c890dc0["capture_bot"] = &function_c66d85003c294dcf;
  utility::registersharedfunc("super_capture_bot", "captureBot_used", &capturebot_used);
  utility::registersharedfunc("super_capture_bot", "captureBot_setClaimants", &capturebot_setclaimants);
  utility::registersharedfunc("super_capture_bot", "captureBot_getTeamIndex", &capturebot_getteamindex);
  utility::registersharedfunc("super_capture_bot", "captureBot_getBotOwner", &capturebot_getteamindex);
  function_b2f29740cb52f391();
}

function function_b2f29740cb52f391() {
  setdvarifuninitialized(@ "hash_df5f30944ffffafd", 1);
}

function function_287c3582fae35289(player) {
  foreach(capturebot in level.var_e0f77360ddb0ba30) {
    if(isDefined(capturebot)) {
      capturebot function_136158ea18135f55(player);
    }
  }
}

function capturebot_used(grenade) {
  grenade endon("death");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.var_6fbd39a3be3e9cb4 = gettime();
  equipname = "equip_capture_bot";
  supername = "super_capture_bot";
  headicon = "hud_icon_fieldupgrade_ammo_box";
  grenade endon("death");
  grenade thread function_78e3ab1589a567fa();
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade thread function_4ef1bb5943972405(self);
  grenade waittill("missile_stuck", stuckto);
  grenade function_4325018d2242ad19(stuckto);
  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata[supername].id;
  grenade.bundle = supers::function_bf9c7e9dd30180e3(supername);

  if(utility::issharedfuncdefined("weapons", "onEquipmentPlanted")) {
    self[[utility::getsharedfunc("weapons", "onEquipmentPlanted")]](grenade, equipname, &function_41639d40af82c243);
  }

  level.var_e0f77360ddb0ba30[grenade getentitynumber()] = grenade;

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_714e85f59c6e39f8);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_3d80d4d22659ee31);
  }

  grenade emp_debuff::set_apply_emp_callback(&function_e9230259bf4617b2);
  grenade haywire::function_172d848d58051fdf(&function_a5cef44666db8c3f);

  if(!istrue(grenade.madedamageable)) {
    grenade function_1b3ec96c8e90d21c();
  }

  grenade.makedamageable = undefined;
  grenade function_4cee86508ff92bb5();
  grenade.var_24e84b82ab1d5516 = 0;
  grenade.var_482696b5ff815a0f = 0;
  grenade.isempd = 0;
  grenade.hacksremaining = getdvarint(@ "hash_5aa813bbab6ce3", grenade.bundle.var_fcdbf98845ac8a63);
  grenade thread function_edccceae8cca6c8d(getdvarfloat(@ "hash_553f589c514d1d1f", grenade.bundle.var_3f1a7102eef0fd38) * getdvarfloat(@ "hash_553f589c514d1d1f", grenade.bundle.var_3f1a7102eef0fd38));

  if(function_2d798bcb76b38072()) {
    grenade thread function_aabf8c1c069532();
  }

  scripts\cp_mp\challenges::function_d997435895422ecc("super_capture_bot", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  grenade.headiconid = grenade entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
}

function function_4ef1bb5943972405(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = utility::waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }

  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  tracecontents = trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  var_3a7f0173b03f5767 = -2000;
  traceend = self.origin + (0, 0, var_3a7f0173b03f5767);
  traceresults = trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

  if(traceresults["fraction"] < 1) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(is_train_ent(groundentity)) {
        self.origin = player.origin;
      }
    }
  }
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }

      if(isDefined(ent.linked_model) && ent.linked_model == hitent) {
        return true;
      }
    }
  }

  return false;
}

function function_c0e6a02651998844() {
  if(false) {
    foreach(superequip in self.plantedsuperequip) {
      if(superequip.equipmentref == "equip_capture_bot") {
        superequip thread function_41639d40af82c243(1);

        if(utility::issharedfuncdefined("weapons", "removeEquip")) {
          self[[utility::getsharedfunc("weapons", "removeEquip")]](superequip);
        }
      }
    }
  }
}

function function_41639d40af82c243(immediate, wasdestroyed) {
  if(!isDefined(immediate)) {
    immediate = !istrue(self.planted);
  }

  closetime = 0;
  deletiondelay = 0;

  if(!immediate) {
    closetime = function_f677e51f4fa22a46() + function_8e87b1379bf12c7c();
    deletiondelay = closetime + 0.1;
  } else {
    deletiondelay = 0.1;
  }

  if(isDefined(self.var_16cbcb7ef09e2111)) {
    if(utility::issharedfuncdefined("robj", "removeExistingCaptureBot")) {
      self.var_16cbcb7ef09e2111[[utility::getsharedfunc("robj", "removeExistingCaptureBot")]](self);
    }

    self.var_16cbcb7ef09e2111 = undefined;
  }

  moving_platform = undefined;
  fxoriginoffset = undefined;
  thread function_58dfa4afe1169c68(deletiondelay, wasdestroyed);

  if(isDefined(self)) {
    fxorigin = self.origin;
    fxforward = anglesToForward(self.angles);
    fxup = anglestoup(self.angles);
    var_dfdfaa4e665b31fc = self getlinkedparent();

    if(isDefined(var_dfdfaa4e665b31fc)) {
      moving_platform = var_dfdfaa4e665b31fc;
      fxoriginoffset = moving_platform.origin - fxorigin;
    }

    if(!immediate) {
      function_ae7efb31b65492c6();
    }

    self setscriptablepartstate("destroy", "active", 0);

    if(isDefined(moving_platform) && isent(moving_platform)) {
      fxorigin = moving_platform.origin - fxoriginoffset;
    }
  }
}

function function_58dfa4afe1169c68(deletiondelay, wasdestroyed) {
  self notify("death");
  wait deletiondelay;
  self.isdestroyed = 1;
  self setCanDamage(0);
  function_fabe2e590fd0eeea();

  if(isDefined(self.owner)) {
    if(utility::issharedfuncdefined("weapons", "removeEquip")) {
      self.owner[[utility::getsharedfunc("weapons", "removeEquip")]](self);
    }
  }

  self.exploding = 1;
  function_d4e56c54c8235018();
  supername = "super_capture_bot";

  if(utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    [[utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, istrue(wasdestroyed));
  }

  self.owner scripts\cp_mp\challenges::function_d997435895422ecc(supername, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.usedcount);
  self delete();
}

function capturebot_getteamindex(team) {
  assertex(isDefined(team), "getTeamIndex: team is undefined!");
  teamindex = 0;

  if(level.teambased) {
    switch (team) {
      case #"hash_7c2d091e6337bf54":
        teamindex = 1;
        break;
      case #"hash_5f54b9bf7583687f":
        teamindex = 2;
        break;
      case #"hash_11f9d28d306ceab7":
        teamindex = 3;
        break;
    }
  }

  return teamindex;
}

function capturebot_setclaimants(team, var_51f08547fa39ce14, objidnum) {
  if(function_8b221111ad9228b8()) {
    var_e600d3d36fcd2556 = function_4daa2b488e4b8604(objidnum);
    objectiveteamcount = "ui_objective_" + var_e600d3d36fcd2556 + "_capture_bot_team_count";
    omnvar_utility::function_d3cf7ff1a257e2c3(objectiveteamcount, 0, 8, var_51f08547fa39ce14[1]);
    omnvar_utility::function_d3cf7ff1a257e2c3(objectiveteamcount, 8, 8, var_51f08547fa39ce14[2]);
    omnvar_utility::function_d3cf7ff1a257e2c3(objectiveteamcount, 16, 8, var_51f08547fa39ce14[3]);
  }
}

function function_1411e5eb39a3b4b6(capturebotindex) {
  if(objective_isunlimited()) {
    return (capturebotindex == -1 || capturebotindex == 0);
  }

  return capturebotindex == -1;
}

function function_4daa2b488e4b8604(currindex) {
  var_ab487d0582646fb5 = getomnvar("ui_objective_1_capture_bot_index");
  var_ecd140b376bd5731 = getomnvar("ui_objective_2_capture_bot_index");
  var_6aa51027179c32a0 = getomnvar("ui_objective_3_capture_bot_index");
  var_2de8907a1cc0535d = getomnvar("ui_objective_4_capture_bot_index");
  var_253e657e6e5344d8 = getomnvar("ui_objective_5_capture_bot_index");
  var_1c2a2d5a99d780a3 = getomnvar("ui_objective_6_capture_bot_index");

  if(currindex == var_ab487d0582646fb5 || function_1411e5eb39a3b4b6(var_ab487d0582646fb5)) {
    if(function_1411e5eb39a3b4b6(var_ab487d0582646fb5)) {
      setomnvar("ui_objective_1_capture_bot_index", currindex);
    }

    return 1;
  }

  if(currindex == var_ecd140b376bd5731 || function_1411e5eb39a3b4b6(var_ecd140b376bd5731)) {
    if(function_1411e5eb39a3b4b6(var_ecd140b376bd5731)) {
      setomnvar("ui_objective_2_capture_bot_index", currindex);
    }

    return 2;
  }

  if(currindex == var_6aa51027179c32a0 || function_1411e5eb39a3b4b6(var_6aa51027179c32a0)) {
    if(function_1411e5eb39a3b4b6(var_6aa51027179c32a0)) {
      setomnvar("ui_objective_3_capture_bot_index", currindex);
    }

    return 3;
  }

  if(currindex == var_2de8907a1cc0535d || function_1411e5eb39a3b4b6(var_2de8907a1cc0535d)) {
    if(function_1411e5eb39a3b4b6(var_2de8907a1cc0535d)) {
      setomnvar("ui_objective_4_capture_bot_index", currindex);
    }

    return 4;
  }

  if(currindex == var_253e657e6e5344d8 || function_1411e5eb39a3b4b6(var_253e657e6e5344d8)) {
    if(function_1411e5eb39a3b4b6(var_253e657e6e5344d8)) {
      setomnvar("ui_objective_5_capture_bot_index", currindex);
    }

    return 5;
  }

  if(currindex == var_1c2a2d5a99d780a3 || function_1411e5eb39a3b4b6(var_1c2a2d5a99d780a3)) {
    if(function_1411e5eb39a3b4b6(var_1c2a2d5a99d780a3)) {
      setomnvar("ui_objective_6_capture_bot_index", currindex);
    }

    return 6;
  }

  assertmsg("Ran out of useable omnvars, will need to increase the number.");
  return;
}

function function_edccceae8cca6c8d(hackingdistsqr) {
  self endon("death");
  self endon("disable_hack");
  self.owner endon("death_or_disconnect");
  self.var_25a2efbe80ec4bf6 = [];

  if(isDefined(self.bundle.var_4c8ec3b47c6e3e6c)) {
    self.var_4c8ec3b47c6e3e6c = self.bundle.var_4c8ec3b47c6e3e6c;
  } else {
    self.var_4c8ec3b47c6e3e6c = 0;
  }

  if(isDefined(self.bundle.var_dcdf6f89d1968bfd)) {
    self.var_dcdf6f89d1968bfd = self.bundle.var_dcdf6f89d1968bfd;
  } else {
    self.var_dcdf6f89d1968bfd = 0;
  }

  if(isDefined(self.bundle.var_206e0f4b760ffb78)) {
    self.var_206e0f4b760ffb78 = self.bundle.var_206e0f4b760ffb78;
  } else {
    self.var_206e0f4b760ffb78 = 0;
  }

  if(isDefined(self.var_482696b5ff815a0f)) {
    while(!self.var_482696b5ff815a0f) {
      equipmentarray = [[level.getactiveequipmentarray]]();
      var_6c845d64be969ce8 = level.activekillstreaks;
      var_110247e38c97089b = undefined;

      if(isDefined(level.var_d381da74cc527ec5["tacticalCameraList"])) {
        foreach(team in level.teamnamelist) {
          if(team != self.owner.team) {
            if(!isDefined(var_110247e38c97089b)) {
              var_110247e38c97089b = level.var_d381da74cc527ec5["tacticalCameraList"][team];
              continue;
            }

            var_110247e38c97089b = utility::array_combine_unique(var_110247e38c97089b, level.var_d381da74cc527ec5["tacticalCameraList"][team]);
          }
        }
      }

      activeobjects = undefined;

      if(isDefined(var_6c845d64be969ce8) && isDefined(equipmentarray) && isDefined(var_110247e38c97089b)) {
        activeobjects = utility::array_combine_unique(var_6c845d64be969ce8, equipmentarray);
        activeobjects = utility::array_combine_unique(activeobjects, var_110247e38c97089b);
      } else {
        if(isDefined(var_6c845d64be969ce8)) {
          activeobjects = var_6c845d64be969ce8;
        }

        if(isDefined(equipmentarray)) {
          if(isDefined(activeobjects)) {
            activeobjects = utility::array_combine_unique(activeobjects, equipmentarray);
          } else {
            activeobjects = equipmentarray;
          }
        }

        if(isDefined(var_110247e38c97089b)) {
          if(isDefined(activeobjects)) {
            activeobjects = utility::array_combine_unique(activeobjects, var_110247e38c97089b);
          } else {
            activeobjects = var_110247e38c97089b;
          }
        }
      }

      if(!isDefined(activeobjects)) {
        continue;
      }

      foreach(var_5a425ca023be6097 in activeobjects) {
        if(!isDefined(var_5a425ca023be6097)) {
          continue;
        }

        if(istrue(var_5a425ca023be6097.exploding)) {
          continue;
        }

        if(var_5a425ca023be6097 == self) {
          continue;
        }

        if(function_654bd872537c923(var_5a425ca023be6097)) {
          continue;
        }

        var_d980f116a46c07b2 = var_5a425ca023be6097.owner;
        var_f31940d93afc41db = 1;

        if(var_f31940d93afc41db) {
          if(isDefined(var_d980f116a46c07b2) && !istrue(player_utility::playersareenemies(self.owner, var_d980f116a46c07b2))) {
            continue;
          }
        }

        if(distancesquared(var_5a425ca023be6097.origin, self.origin) > hackingdistsqr) {
          continue;
        }

        var_a9cff4a574bdbd94 = undefined;

        if(isDefined(var_5a425ca023be6097.streakname)) {
          var_a9cff4a574bdbd94 = var_5a425ca023be6097.streakname;
        } else if(isDefined(var_5a425ca023be6097.cameratype)) {
          var_a9cff4a574bdbd94 = var_5a425ca023be6097.cameratype;
        } else {
          if(isDefined(var_5a425ca023be6097.weapon_name)) {
            var_a9cff4a574bdbd94 = var_5a425ca023be6097.weapon_name;
          }

          if(!isDefined(var_a9cff4a574bdbd94) && isDefined(var_5a425ca023be6097.weapon_object)) {
            var_a9cff4a574bdbd94 = var_5a425ca023be6097.weapon_object.basename;
          }
        }

        if(isDefined(var_a9cff4a574bdbd94)) {
          switch (var_a9cff4a574bdbd94) {
            case #"hash_30c41b4430deef71":
              if(isDefined(var_5a425ca023be6097.var_24e84b82ab1d5516)) {
                if(var_5a425ca023be6097.isempd) {
                  if(utility::issharedfuncdefined("player", "doScoreEvent")) {
                    self.owner[[utility::getsharedfunc("player", "doScoreEvent")]]("capture_bot_unilateral_destruction");
                  }

                  var_5a425ca023be6097 thread function_41639d40af82c243(1, 1);
                } else if(!var_5a425ca023be6097.var_24e84b82ab1d5516) {
                  self.var_24e84b82ab1d5516 = 1;
                  self.var_482696b5ff815a0f = 1;
                  var_5a425ca023be6097.var_24e84b82ab1d5516 = 1;
                  var_5a425ca023be6097.var_482696b5ff815a0f = 1;
                  self.var_25a2efbe80ec4bf6[self.var_25a2efbe80ec4bf6.size] = var_5a425ca023be6097.owner;
                  var_5a425ca023be6097 thread function_f46e9de463ee24b5(self.owner);
                }
              }

              break;
            case #"hash_14272647c44d6052":
            case #"hash_1a5a56a6fdfa6d6b":
            case #"hash_432644fc4753dde9":
            case #"hash_435258fc47768fa7":
            case #"hash_4a85ee2b82965fe2":
            case #"hash_5e3fa526a48eaaa5":
            case #"hash_5e8f81314553dd36":
            case #"hash_6a2e4f9c54756dc7":
              if(var_5a425ca023be6097 equipment::function_f5cbee8dfc1dc4f0(self)) {
                equipment::function_24fce6c89fd2bee3(self);

                if(utility::issharedfuncdefined("equipment", "hackEquipment")) {
                  self.hacksremaining--;
                  var_5a425ca023be6097 thread[[utility::getsharedfunc("equipment", "hackEquipment")]](self);

                  if(utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
                    [[utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_5a425ca023be6097, self.owner, "capture_bot", "equipment");
                  }
                }
              }

              break;
            case #"hash_d746f684beafad9f":
              if(utility::issharedfuncdefined("super_comm_scrambler", "commScrambler_onHacked")) {
                self.hacksremaining--;
                onhackedcallback = utility::getsharedfunc("super_comm_scrambler", "commScrambler_onHacked");
                var_5a425ca023be6097 namespace_8894a0caa4c34dc6::function_888f3a0124b03ddc(self.owner, "super_comm_scrambler", "capture_bot", onhackedcallback);
              }

              break;
            case #"hash_56ee829cc162271a":
            case #"hash_c46d19aa871781fa":
              if(getdvarint(@ "hash_497f584b55da1305", self.var_4c8ec3b47c6e3e6c) == 1) {
                if(var_5a425ca023be6097 equipment::function_f5cbee8dfc1dc4f0(self)) {
                  equipment::function_24fce6c89fd2bee3(self);

                  if(utility::issharedfuncdefined("equipment", "hackEquipment")) {
                    self.hacksremaining--;
                    var_5a425ca023be6097 thread[[utility::getsharedfunc("equipment", "hackEquipment")]](self);
                  }
                }
              }

              break;
            case #"hash_de91d496aad63a86":
              if(getdvarint(@ "hash_497f584b55da1305", self.var_4c8ec3b47c6e3e6c) == 1) {
                if(utility::issharedfuncdefined("cameras", "tacticalCamera_Hack")) {
                  self.hacksremaining--;
                  var_5a425ca023be6097 thread[[utility::getsharedfunc("cameras", "tacticalCamera_Hack")]](self.owner);
                }
              }

              break;
            case #"hash_b4a17c60413030e7":
              if(getdvarint(@ "hash_36d6aab0c3496454", self.var_dcdf6f89d1968bfd) == 1) {
                if(var_5a425ca023be6097 equipment::function_f5cbee8dfc1dc4f0(self)) {
                  equipment::function_24fce6c89fd2bee3(self);

                  if(utility::issharedfuncdefined("equipment", "hackEquipment")) {
                    var_5a425ca023be6097 thread[[utility::getsharedfunc("equipment", "hackEquipment")]](self);
                    self.hacksremaining--;

                    if(utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
                      [[utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_5a425ca023be6097, self.owner, "capture_bot", "equipment");
                    }
                  }
                }
              }

              break;
            case #"hash_19dd9a3a4147e09e":
              if(getdvarint(@ "hash_97bedf9b3dc1501d", self.var_206e0f4b760ffb78) == 1) {
                if(utility::issharedfuncdefined("lrad", "LRAD_Hack")) {
                  self.hacksremaining--;
                  var_5a425ca023be6097 thread[[utility::getsharedfunc("lrad", "LRAD_Hack")]](self.owner);

                  if(utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
                    [[utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_5a425ca023be6097, self.owner, "capture_bot", "equipment");
                  }
                }
              }

              break;
            case #"hash_b571a6187bf67f9e":
              if(getdvarint(@ "hash_97bedf9b3dc1501d", self.var_206e0f4b760ffb78) == 1) {
                if(utility::issharedfuncdefined("missile_turret", "missile_turret_Hack")) {
                  self.hacksremaining--;
                  var_5a425ca023be6097 thread[[utility::getsharedfunc("missile_turret", "missile_turret_Hack")]](self.owner, var_5a425ca023be6097.owner);

                  if(utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
                    [[utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_5a425ca023be6097, self.owner, "capture_bot", "equipment");
                  }
                }
              }

              break;
          }

          if(self.hacksremaining == 0) {
            self.var_482696b5ff815a0f = 1;
          }
        }
      }

      if(isDefined(self.var_482696b5ff815a0f)) {
        if(isDefined(self.var_24e84b82ab1d5516) && self.var_24e84b82ab1d5516) {
          thread function_a3b944ae13709c67(self.var_25a2efbe80ec4bf6);
        } else if(self.var_482696b5ff815a0f) {
          thread function_41639d40af82c243(0);
        }
      }

      wait 0.25;
    }
  }
}

function function_aabf8c1c069532() {
  self endon("death");

  switch (level.gametype) {
    case #"hash_ca6516c10db2c95":
    case #"hash_1b1eecd3863a50cf":
    case #"hash_6efb0f59a62300fb":
    case #"hash_a1313b745c17c07e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa44d9f6bd7a2fa1":
      function_e126d8efe684fb33();
      break;
    case #"hash_4d60179017f5a28a":
      if(isDefined(level.current_objectives)) {
        currobjs = level.current_objectives;

        foreach(currobj in currobjs) {
          if(utility::issharedfuncdefined("robj", "identifyObjTypForCaptureBot")) {
            switch ([[utility::getsharedfunc("robj", "identifyObjTypForCaptureBot")]](currobj)) {
              case #"hash_2daf318af0c70342":
              case #"hash_74d906400c48adf8":
                if(distancesquared(self.origin, currobj.curorigin) < 26406.2) {
                  if(getdvarint(@ "hash_df5f30944ffffafd") == 0) {
                    castcontents = physics_createcontents(["physicscontents_ainosight"]);
                    castresults = physics_raycast(self.origin, currobj.curorigin, castcontents, [self], 0, "physicsquery_closest", 1);

                    if(isDefined(castresults) && castresults.size > 0) {
                      if(isDefined(castresults[0]["entity"]) && isDefined(castresults[0]["entity"].script_gameobjectname) && castresults[0]["entity"].script_gameobjectname == "robj") {
                        function_4120d7ad8ea536(currobj);
                        self.var_16cbcb7ef09e2111 = currobj;
                        self setscriptablepartstate("objective", "on_objective", 0);
                      } else {
                        self setscriptablepartstate("objective", "neutral", 0);
                      }
                    } else {
                      function_4120d7ad8ea536(currobj);
                      self.var_16cbcb7ef09e2111 = currobj;
                      self setscriptablepartstate("objective", "on_objective", 0);
                    }
                  } else {
                    function_4120d7ad8ea536(currobj);
                    self.var_16cbcb7ef09e2111 = currobj;
                    self setscriptablepartstate("objective", "on_objective", 0);
                  }
                } else {
                  self setscriptablepartstate("objective", "neutral", 0);
                  thread function_e1fe4c930d13eaec();
                }

                break;
              case #"hash_fed0dfe3f74ac025":
                break;
              case #"hash_2916b409ed596650":
                break;
              default:
                break;
            }
          }
        }
      }

      break;
    default:
      break;
  }
}

function function_4120d7ad8ea536(currentobjective) {
  if(utility::issharedfuncdefined("robj", "setUpNewCaptureBot")) {
    currentobjective[[utility::getsharedfunc("robj", "setUpNewCaptureBot")]](self);
  }
}

function function_ed4aa674488778bd() {
  self endon("death");

  while(level.zoneendtime - gettime() > 0) {
    if(level.zoneendtime - gettime() <= 500) {
      function_e126d8efe684fb33(1);
      break;
    }

    wait 0.2;
  }
}

function function_e126d8efe684fb33(var_242db34d640bf32e) {
  aitype_list = agent_utils::function_3290e192ac188e2d("capture_bot");

  if(isDefined(aitype_list)) {
    assert(aitype_list.size == 1);

    if(aitype_list.size == 1) {
      aitype = aitype_list[0];
      levelobjectives = level.objectives;

      if(isDefined(levelobjectives)) {
        foreach(obj in levelobjectives) {
          var_85193c207b79fab0 = 0;

          if(!isDefined(obj.trigger) || isDefined(obj.trigger.trigger_off) && istrue(obj.trigger.trigger_off) || isDefined(obj.cancontestclaim) && !obj.cancontestclaim) {
            continue;
          }

          switch (level.gametype) {
            case #"hash_1b1eecd3863a50cf":
            case #"hash_f4a9126c03d3385b":
              if(utility::ispointinsidecircle(self.origin, obj.trigger.origin, obj.trigger.radius)) {
                var_85193c207b79fab0 = 1;
              } else {
                var_85193c207b79fab0 = 0;
              }

              break;
            case #"hash_ca6516c10db2c95":
            case #"hash_6efb0f59a62300fb":
            case #"hash_a1313b745c17c07e":
            case #"hash_fa44d9f6bd7a2fa1":
              if(self istouching(obj.trigger)) {
                var_85193c207b79fab0 = 1;
              } else {
                var_85193c207b79fab0 = 0;
              }

              break;
            default:
              break;
          }

          if(var_85193c207b79fab0) {
            if(obj.interactteam != "enemy" && !isDefined(var_242db34d640bf32e)) {
              if(level.gametype == "koth") {
                thread function_ed4aa674488778bd();
                continue;
              }
            }

            if(utility::issharedfuncdefined("agents", "spawnNewAgentAiType")) {
              self.agent = self[[utility::getsharedfunc("agents", "spawnNewAgentAiType")]](aitype, self.origin, self.angles, self.owner.team);

              if(!isDefined(self.agent)) {
                continue;
              }
            }

            if(utility::issharedfuncdefined("player", "getUniqueId")) {
              self.agent.guid = self.agent[[utility::getsharedfunc("player", "getUniqueId")]]();
            }

            self.agent.name = self.agent.guid;
            self.agent setentityowner(self.owner);
            self.agent.owner = self.owner;
            level notify("spawned_agent", self.agent);
            self.var_b8d1c74d660fef2d = 1;

            if(isDefined(obj.objectivekey)) {
              self.currenttargetobjid = obj.objectivekey;
              self.owner setclientomnvar("ui_owned_capture_bot_capturing", 1);
              self.owner setclientomnvar("ui_owned_capture_bot_index", obj.objidnum + 1);
              self.owner.var_c252dc621d931184 = obj.objidnum;
            }

            self setscriptablepartstate("objective", "on_objective", 0);
            break;
          }

          self.owner setclientomnvar("ui_owned_capture_bot_capturing", 0);
          self.owner setclientomnvar("ui_owned_capture_bot_index", 0);
          self setscriptablepartstate("objective", "neutral", 0);
        }
      }
    }
  }
}

function function_e1fe4c930d13eaec() {
  self endon("death");
  level waittill("new_robj_location");

  if(isDefined(level.current_objectives)) {
    currobjs = level.current_objectives;

    foreach(currobj in currobjs) {
      if(utility::issharedfuncdefined("robj", "identifyObjTypForCaptureBot")) {
        switch ([[utility::getsharedfunc("robj", "identifyObjTypForCaptureBot")]](currobj)) {
          case #"hash_2daf318af0c70342":
          case #"hash_74d906400c48adf8":
            if(distancesquared(self.origin, currobj.trigger.origin) < 26406.2) {
              function_4120d7ad8ea536(currobj);
              self.var_16cbcb7ef09e2111 = currobj;
              self setscriptablepartstate("objective", "on_objective", 0);
            } else {
              thread function_e1fe4c930d13eaec();
              self setscriptablepartstate("objective", "neutral", 0);
            }

            break;
          case #"hash_fed0dfe3f74ac025":
            break;
          case #"hash_2916b409ed596650":
            break;
          default:
            break;
        }
      }
    }
  }
}

function function_2d798bcb76b38072() {
  gametype = level.gametype;

  switch (level.gametype) {
    case #"hash_ca6516c10db2c95":
    case #"hash_1b1eecd3863a50cf":
    case #"hash_4d60179017f5a28a":
    case #"hash_6efb0f59a62300fb":
    case #"hash_a1313b745c17c07e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa44d9f6bd7a2fa1":
      return 1;
    default:
      return 0;
  }
}

function function_8b221111ad9228b8() {
  switch (level.gametype) {
    case #"hash_ca6516c10db2c95":
    case #"hash_4d60179017f5a28a":
    case #"hash_6efb0f59a62300fb":
    case #"hash_a1313b745c17c07e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa44d9f6bd7a2fa1":
      return 1;
    default:
      return 0;
  }
}

function function_654bd872537c923(var_5a425ca023be6097) {
  var_a9cff4a574bdbd94 = undefined;

  if(isDefined(var_5a425ca023be6097.streakname)) {
    var_a9cff4a574bdbd94 = var_5a425ca023be6097.streakname;
  } else if(isDefined(var_5a425ca023be6097.cameratype)) {
    var_a9cff4a574bdbd94 = var_5a425ca023be6097.cameratype;
  } else {
    if(isDefined(var_5a425ca023be6097.weapon_name)) {
      var_a9cff4a574bdbd94 = var_5a425ca023be6097.weapon_name;
    }

    if(!isDefined(var_a9cff4a574bdbd94) && isDefined(var_5a425ca023be6097.weapon_object)) {
      var_a9cff4a574bdbd94 = var_5a425ca023be6097.weapon_object.basename;
    }
  }

  if(isDefined(var_a9cff4a574bdbd94)) {
    switch (var_a9cff4a574bdbd94) {
      case #"hash_b4a17c60413030e7":
        if(getdvarint(@ "hash_36d6aab0c3496454", self.var_dcdf6f89d1968bfd) == 1) {
          return false;
        } else {
          return true;
        }

        break;
      case #"hash_56ee829cc162271a":
      case #"hash_c46d19aa871781fa":
        if(getdvarint(@ "hash_497f584b55da1305", self.var_4c8ec3b47c6e3e6c) == 1) {
          return false;
        } else {
          return true;
        }

        break;
      case #"hash_de91d496aad63a86":
        if(getdvarint(@ "hash_497f584b55da1305", self.var_4c8ec3b47c6e3e6c) == 1) {
          return false;
        } else {
          return true;
        }

        break;
      case #"hash_19dd9a3a4147e09e":
      case #"hash_b571a6187bf67f9e":
        if(getdvarint(@ "hash_97bedf9b3dc1501d", self.var_206e0f4b760ffb78) == 1) {
          return false;
        } else {
          return true;
        }

        break;
      default:
        return false;
    }
  }

  return true;
}

function function_1b3ec96c8e90d21c() {
  bundle = self.bundle;
  boxmaxhealth = 100;

  if(isDefined(bundle)) {
    boxmaxhealth = utility::default_to(bundle.maxhealth, 100);
  }

  if(utility::issharedfuncdefined("damage", "monitorDamage")) {
    self thread[[utility::getsharedfunc("damage", "monitorDamage")]](boxmaxhealth, "hitequip", &function_cc6cf839252877ac, &function_79a97ee01dc267d3);
  }
}

function function_cc6cf839252877ac(data) {
  function_2c95b12fb62aed02(data.attacker);
  thread function_41639d40af82c243(1, 1);
}

function function_fd1ef4f80a8a90bc() {
  if(isDefined(self.outlineid)) {
    if(utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[utility::getsharedfunc("outline", "outlineDisable")]](self.outlineid, self);
    }
  }
}

function function_d4e56c54c8235018() {
  if(isDefined(self.headiconid)) {
    entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }
}

function function_2c95b12fb62aed02(attacker) {
  if(!isDefined(self.owner) || player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");

    if(utility::issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[utility::getsharedfunc("player", "doScoreEvent")]](#"destroyed_equipment");
    }

    if(utility::issharedfuncdefined("battlechatter", "equipmentDestroyed")) {
      [[utility::getsharedfunc("battlechatter", "equipmentDestroyed")]](self);
    }
  }
}

function function_9d62753b509a9310(player, eventname, persstat, supername) {
  if(isDefined(self.owner) && !player_utility::playersareenemies(self.owner, player)) {
    if(self.owner != player) {
      if(utility::issharedfuncdefined("player", "doScoreEvent")) {
        self.owner thread[[utility::getsharedfunc("player", "doScoreEvent")]](eventname);
      }
    }

    if(utility::issharedfuncdefined("pers", "incPersStat")) {
      self.owner[[utility::getsharedfunc("pers", "incPersStat")]](persstat, 1);
    }

    if(utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
      self.owner[[utility::getsharedfunc("supers", "combatRecordSuperMisc")]](supername);
    }

    self.usedcount++;
  }
}

function function_9269207a0488f67b(data) {
  function_41639d40af82c243(1);
}

function function_fa5b4ff59c725f9e(data) {
  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }

  superinfo = undefined;

  if(utility::issharedfuncdefined("player", "getCurrentSuper")) {
    superinfo = owner[[utility::getsharedfunc("player", "getCurrentSuper")]]();
  }

  if(isDefined(superinfo) && level.allowsupers) {
    superinfo.wasrefunded = 1;

    if(utility::issharedfuncdefined("supers", "getSuperPointsNeeded") && utility::issharedfuncdefined("supers", "setSuperBasePoints")) {
      owner[[utility::getsharedfunc("supers", "setSuperBasePoints")]](owner[[utility::getsharedfunc("supers", "getSuperPointsNeeded")]]());
    }
  }

  function_41639d40af82c243(1);
}

function function_4325018d2242ad19(stuckto) {
  data = spawnStruct();
  data.linkparent = stuckto;
  data.deathoverridecallback = &function_9269207a0488f67b;
  data.invalidparentoverridecallback = &function_fa5b4ff59c725f9e;
  data.endonstring = "death";
  data.validateaccuratetouching = 1;

  if(isDefined(stuckto) && train_utility::is_train_ent(stuckto)) {
    data.plantedontrain = 1;
    self setmissileantilagged(1);
  }

  if(utility::issharedfuncdefined("game", "handlemovingplatforms")) {
    self thread[[utility::getsharedfunc("game", "handlemovingplatforms")]](data);
  }
}

function function_78e3ab1589a567fa() {
  self endon("death");
  function_6644754dabdb7f27();

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread function_41639d40af82c243(1);
  }
}

function function_6644754dabdb7f27() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(utility::issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[utility::getsharedfunc("hostmigration", "waitLongDurationWithPause")]](getdvarfloat(@ "hash_68780fdf22059a6f", supers::function_bf9c7e9dd30180e3("super_capture_bot").maxlifetime));
  }
}

function function_e9230259bf4617b2(data) {
  data.victim endon("death");
  data.victim endon("destroyed");
  function_774ef28b06fdf891(data);
  wait getdvarfloat(@ "hash_c98fb670dab45239", self.bundle.var_a84cf5adbb56f9cf);
  function_86c56d246ccda848(data);
}

function function_714e85f59c6e39f8(data) {
  data.victim endon("death");
  data.victim endon("destroyed");
  function_774ef28b06fdf891(data);
}

function function_3d80d4d22659ee31(data) {
  function_86c56d246ccda848(data);
}

function function_774ef28b06fdf891(data) {
  if(isDefined(data.attacker)) {
    if(utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[utility::getsharedfunc("player", "doScoreEvent")]]("disabled_capture_bot");
    }
  }

  self.isempd = 1;
  data.victim notify("disable_hack");
  function_fabe2e590fd0eeea();
  data.victim function_ae7efb31b65492c6();
}

function function_86c56d246ccda848(data) {
  data.victim function_4cee86508ff92bb5();
  self.isempd = 0;
  data.victim thread function_edccceae8cca6c8d(getdvarfloat(@ "hash_553f589c514d1d1f", self.bundle.var_3f1a7102eef0fd38) * getdvarfloat(@ "hash_553f589c514d1d1f", self.bundle.var_3f1a7102eef0fd38));

  if(function_2d798bcb76b38072()) {
    data.victim thread function_aabf8c1c069532();
  }
}

function function_a5cef44666db8c3f(data) {
  attacker = data.attacker;
  function_2c95b12fb62aed02(attacker);
  thread function_41639d40af82c243(1);
}

function function_ae7efb31b65492c6() {
  self setscriptablepartstate("objective", "neutral", 0);
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("active", "neutral", 0);
  self setscriptablepartstate("deactivate", "deactivate", 0);
  wait function_f677e51f4fa22a46();
  self setscriptablepartstate("inactive", "inactive", 0);
  wait function_8e87b1379bf12c7c();
}

function function_4cee86508ff92bb5() {
  self setscriptablepartstate("deactivate", "neutral", 0);
  self setscriptablepartstate("inactive", "neutral", 0);
  self setscriptablepartstate("activate", "activate", 0);
  wait function_2f1a6016f12d412c();
  self setscriptablepartstate("active", "active", 0);
  wait function_d459d243d134c89a();
}

function function_fabe2e590fd0eeea() {
  if(isDefined(self.agent)) {
    if(utility::issharedfuncdefined("agents", "deactivateAgent")) {
      self.agent[[utility::getsharedfunc("agents", "deactivateAgent")]]();
    }

    self.agent.nocorpse = 1;
    self.agent kill();
    self.agent = undefined;
  }

  if(isDefined(self.var_b8d1c74d660fef2d)) {
    self.var_b8d1c74d660fef2d = undefined;
  }

  if(isDefined(self.currenttargetobjid)) {
    self.currenttargetobjid = undefined;
  }

  if(isDefined(self.owner)) {
    if(function_8b221111ad9228b8()) {
      var_f5c99cb09dc5c654 = self.owner getclientomnvar("ui_owned_capture_bot_index");

      if(var_f5c99cb09dc5c654 > 0) {
        omnvarindex = function_4daa2b488e4b8604(var_f5c99cb09dc5c654);
        teamindex = capturebot_getteamindex(self.team);

        if(teamindex > 0) {
          omnvar = "ui_objective_" + omnvarindex + "_capture_bot_team_count";
          oldval = omnvar_utility::function_610e0cca26bba2f(omnvar, (omnvarindex - 1) * 8, 8);

          if(oldval > 0) {
            omnvar_utility::function_d3cf7ff1a257e2c3(omnvar, (omnvarindex - 1) * 8, 8, oldval - 1);
          }
        }
      }

      self.owner setclientomnvar("ui_owned_capture_bot_index", 0);
      self.owner setclientomnvar("ui_owned_capture_bot_capturing", 0);
    }
  }
}

function function_f46e9de463ee24b5(attacker) {
  if(utility::issharedfuncdefined("player", "doScoreEvent")) {
    attacker[[utility::getsharedfunc("player", "doScoreEvent")]]("capture_bot_mutual_destruction");
  }

  thread function_41639d40af82c243(0);
}

function function_a3b944ae13709c67(attackerlist) {
  foreach(attacker in attackerlist) {
    if(utility::issharedfuncdefined("player", "doScoreEvent")) {
      attacker[[utility::getsharedfunc("player", "doScoreEvent")]]("capture_bot_mutual_destruction");
    }
  }

  thread function_41639d40af82c243(0);
}

function function_9df1056705dc708e() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_136158ea18135f55(player);
  }
}

function function_136158ea18135f55(player) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  idfaction = self.headiconfaction;

  if(!isDefined(idfaction)) {
    return;
  }

  isfriendly = undefined;

  if(utility::issharedfuncdefined("player", "isFriendly")) {
    isfriendly = [[utility::getsharedfunc("player", "isFriendly")]](self.owner.team, player);
  }

  isused = isDefined(self.playersused) && isDefined(self.playersused[player getentitynumber()]);

  if(isfriendly && !isused) {
    entityheadicons::setheadicon_removeclientfrommask(idfaction, player);
    return;
  }

  if(isfriendly) {
    entityheadicons::setheadicon_addclienttomask(idfaction, player);
    return;
  }

  entityheadicons::setheadicon_removeclientfrommask(idfaction, player);
}

function function_c66d85003c294dcf() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.touchtriggers = undefined;
  self.carryobject = undefined;
  self.canpickupobject = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.sessionteam = self.team;
  self.sessionstate = "playing";
  self.shieldbullethits = 0;
  self.recentshieldxp = 0;
  self.agent_gameparticipant = 1;
  self.var_599b158d152c358d = 1;
  self.objectivescaler = 1;

  if(utility::issharedfuncdefined("player", "initPlayerGameobjects")) {
    self[[utility::getsharedfunc("player", "initPlayerGameobjects")]]();
  }

  game_utility::addtoparticipantsarray();
  self setsolid(0);
  self hide();
  self.candamage = 0;
  self.ballowexecutions = 0;
  self.ignoreme = 1;
  self.candocombat = 0;
  self.canmove = 0;
  self.cannotmelee = 1;
  self.isvisible = 0;
}

#using_animtree("capture_bot");

function function_2f1a6016f12d412c() {
  return getanimlength(%wm_capturebot_ground_open);
}

function function_f677e51f4fa22a46() {
  return getanimlength(%wm_capturebot_ground_close);
}

function function_8e87b1379bf12c7c() {
  return getanimlength(%wm_capturebot_ground_idle_closed);
}

function function_d459d243d134c89a() {
  return getanimlength(%wm_capturebot_ground_idle_open);
}