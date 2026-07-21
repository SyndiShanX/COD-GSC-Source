/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\damage.gsc
***********************************************/

callback_playerdamage_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
    var_1 = undefined;

  if(isDefined(var_1) && isDefined(var_1.gunner))
    var_1 = var_1.gunner;

  if(istrue(var_2.plotarmor)) {
    return;
  }
  if(istrue(var_2._id_12058) && isDefined(var_6)) {
    if(!trial_vehicle_outline_id(var_6.basename))
      return;
  }

  if(var_5 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0) && isDefined(var_2 scripts\cp_mp\utility\player_utility::getvehicle()) && var_2 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }
  if(var_5 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_0.vehiclename) && var_0.vehiclename == "_encstr_A7B30DE187CA05B92B54B8537A15E8") {
    var_17 = 10000;
    var_18 = gettime() - var_0.birthtime;

    if(var_18 < var_17)
      return;
  }

  if(istrue(var_2.inlaststand) && istrue(level.laststandrequiresmelee) && var_5 != "_encstr_8DED0A21C79B660BC7588981") {
    return;
  }
  var_19 = var_2.health;

  if(var_4 &level.idflags_stun) {
    if(istrue(level._id_13C56))
      var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);
  } else {
    var_20 = filterdamage(var_0, var_1, var_2, var_3, var_5, var_6, var_9);

    if(isDefined(var_20)) {
      return;
    }
    var_21 = scripts\mp\utility\damage::attackerishittingteam(var_2, var_1);

    if(isDefined(var_0) && istrue(var_0.flare_activated))
      var_21 = 0;

    var_22 = isDefined(var_6) && scripts\mp\utility\weapon::iskillstreakweapon(var_6.basename);

    if(!istrue(level.allowprematchdamage)) {
      if(istrue(game["_encstr_95810CA5B9982DEC9526DEC426F2"]) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || istrue(level.stop_end_breach_fx)) {
        handledamagefeedback(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_22);
        return;
      }
    }

    if(var_21) {
      var_3 = handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_22);

      if(var_3 == 0)
        return;
    }

    if(istrue(var_2.spawnprotection) || var_2 _meth_87D3()) {
      var_23 = isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23";
      var_24 = var_5 == "_encstr_87A10C9D24E997A01F21838F3D34";

      if(!var_23 && !var_24) {
        handledamagefeedback(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_22);
        return;
      }
    }

    if(isDefined(var_1) && istrue(var_1.cranked))
      var_1 thread scripts\mp\cranked::_id_1200C(var_2);

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9" && isDefined(var_1.type) && var_1.type == "_encstr_872F0D0B92FB65A14D31958951B518") {
      return;
    }
    var_4 = var_4 | level.idflags_no_knockback;

    if((usetimeoverride(var_6) || tutorialzoneexit(var_1, var_6) || var_6 hasattachment("_encstr_ADE110F9026778319CAE7F7BC687D837B3FB", 1)) && scripts\mp\utility\damage::validshotcheck(var_5, var_1)) {
      if(isDefined(var_6.unlockableindex))
        var_2 thread mine_caves_ambusher_internal(var_9, var_1, var_6);

      if(var_6.basename != "_encstr_97F517F8C3B807B36797F54B904F9BE9D5DAB078BA43CF285B")
        var_3 = _id_13714(var_2, var_1, var_6, var_3, var_4);
      else if(var_3 == 0)
        return;
    }

    var_25 = var_6.basename;
    var_26 = scripts\mp\utility\weapon::getequipmenttype(var_25);

    if(isDefined(var_26)) {
      if(var_26 == "_encstr_B116071BCAD186858D")
        var_3 = lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      else if(var_26 == "_encstr_B68610ACC5ABA50EB5CAB9A3F5DEA30D5693") {} else if(var_26 == "_encstr_99C209E34FC743616118AB") {}

      var_27 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, var_7, var_8, undefined, var_12, undefined, var_4);
      var_28 = scripts\mp\equipment::equiponplayerdamaged(var_27);

      if(isDefined(var_28) && var_28 == 0)
        return;
    }

    if(var_2 scripts\mp\utility\game::ismatchstartprotected()) {
      var_29 = isDefined(var_6) && isDefined(var_6.basename) && var_6.basename == "_encstr_8FDA0D3880E2EF6E3F35108F39114B";

      if(!var_29) {
        var_30 = istrue(var_6.isalternate);

        if(isDefined(var_26) && !scripts\mp\utility\weapon::isthrowingknife(var_25) || var_30 || var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF") {
          var_31 = int(max(var_2.health / 5, 1));

          if(var_3 >= var_31)
            var_3 = var_31;
        }
      }
    }

    var_32 = scripts\mp\utility\weapon::getweapontype(var_25);

    if(isDefined(var_32) && var_32 == "_encstr_85CE0B9770B02C73A1760F06D2") {
      var_3 = killstreakdamagefilter(var_1, var_2, var_3, var_6, var_5);

      if(var_3 == 0) {
        return;
      }
      if(isDefined(level.gunshipplayer) && isDefined(var_1) && level.gunshipplayer == var_1)
        level notify("_encstr_977F08B02DBE380BD2E6", var_2);
    }

    if(var_5 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_1) && isDefined(var_1.streakname) && var_1.streakname == "_encstr_8F2C0AB2DA1CD74639B7372B")
      var_3 = 0;

    var_3 = modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
    var_3 = handleriotshieldhits(var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_22, var_14);

    if(var_3 == 0) {
      if(istrue(level._id_13C56))
        var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);

      return;
    }

    var_33 = var_3;

    if(!istrue(var_2.donotmodifydamage)) {
      var_34 = cac_modified_damage(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0, 0, var_4, var_22, var_14);
      var_3 = var_34[0];
      var_35 = var_34[1];
      var_36 = var_34[2];
      var_37 = var_35 != 0 || var_36 != 0;
      var_9 = var_34[3];
    } else {
      var_35 = 0;
      var_36 = 0;
      var_37 = 0;
    }

    if(unsetspecialistbonus(var_1, var_2, var_3, var_5, var_6, var_13)) {
      return;
    }
    if(isDefined(var_2.forcehitlocation)) {
      var_9 = var_2.forcehitlocation;
      var_2.forcehitlocation = undefined;
    }

    if(isPlayer(var_1) && (var_25 == "_encstr_8823119675DAFF897F878020BB99612B219D8F" || scripts\mp\utility\weapon::isthrowingknife(var_25)))
      var_1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_25, 1, "_encstr_88CC0521F3A13B");

    var_38 = var_8;

    if(isDefined(var_4) && var_4 &level.idflags_ricochet && var_3 < self.health)
      var_38 = var_2.origin - var_1.origin;

    if(unset_force_aitype_sniper(var_0))
      var_3 = 0;

    if(isDefined(var_1) && (isPlayer(var_1) || istrue(var_1.brking_getcenterofcircle)) && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      if(armorvest_washit(var_1) || helmet_washit(var_1))
        var_4 = var_4 | level.ss_circletick;

      if(armorvest_wasbroke(var_1) || helmet_wasbroke(var_1))
        var_4 = var_4 | level.sr_next_ammo_restock_time;

      if(isDefined(level._id_12067))
        var_4 = var_4 | [[level._id_12067]](var_2);
    }

    if(usecallback(var_1))
      var_3 = _id_12F86(var_1, var_3, var_5);

    if(isDefined(level._id_12066)) {
      if(![[level._id_12066]](var_5))
        return;
    }

    var_39 = 5;

    if(isPlayer(var_1) && var_1 scripts\mp\utility\perk::_hasperk("_encstr_96671CB3C285F853FA4311F3773226D1481C9889A1E7E8AF825F2BCBBF6A") && var_33 >= var_39) {
      if(isPlayer(var_2) && var_2 scripts\mp\utility\perk::_hasperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532") && var_2 != var_1)
        var_1 thread scripts\mp\perks\perkfunctions::_id_12374();
      else
        var_1 scripts\mp\perks\perkfunctions::maxmuncurrencycap(var_2);
    }

    if(isDefined(var_1) && isPlayer(var_1) && var_1 != var_2) {
      if(var_5 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_5 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215") {
        if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_9B5C1A16B2FA6F88C12B3040FF1A23DF635A0E938D432310AFCFB810") && (var_2 issupersprinting() || var_2 issprintsliding())) {
          var_40 = var_3;
          var_3 = int(var_40 * getdvarfloat("_encstr_B6E51AE251A867339DCD8F67F7B5DB80C818DBEC68B8DF2A6E9B9783", 0.85));

          if(!isagent(var_1) && !isbot(var_1))
            var_1 thread scripts\mp\perks\perkfunctions::_id_13716();
        }
      }
    }

    preplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_38, var_9, var_10, var_11, var_12);
    var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_38, var_9, var_10, var_11, var_12, var_37);
    postplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_38, var_9, var_10, var_11, var_12, var_35, var_36, var_19, var_22);
  }
}

rungwperif_plumes(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_0438(var_2);
  var_6 = _func_0439(var_0, var_1, var_5);

  if(var_5 == 0 || var_5 > 17 || var_6 > 1.1)
    return var_3;

  var_7 = var_5 - 1;

  if(var_5 - 6 > 0)
    var_7--;

  if(var_5 == 6 || var_5 == 7)
    var_7 = 4;

  if(var_5 == 12 || var_5 == 13)
    var_7 = 5;

  var_8 = _func_0439(var_0, var_1, var_7);

  if(var_8 > 1.1)
    return floor(var_4 * var_8);
  else
    return var_3;
}

mine_caves_ambusher_internal(var_0, var_1, var_2) {
  self notify("_encstr_A9081776D3A00FEB97C1C2DA2B6E933F7869F8E86360C5574E");
  self endon("_encstr_A9081776D3A00FEB97C1C2DA2B6E933F7869F8E86360C5574E");

  if(!isDefined(self.mine_caves_ambusher))
    self.mine_caves_ambusher = scripts\cp_mp\killstreaks\nuke::_id_13638();

  self.mine_caves_ambusher._id_11E62 = scripts\engine\utility::array_add(self.mine_caves_ambusher._id_11E62, var_0);
  waittillframeend;
  var_3 = [];

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.mine_caves_ambusher)) {
    var_3 = self.mine_caves_ambusher._id_11E62;
    self.mine_caves_ambusher._id_11E62 = [];
  }

  if(scripts\mp\utility\player::isreallyalive(self))
    scripts\cp_mp\killstreaks\nuke::_id_13146(var_3, var_1, var_2);
  else
    scripts\cp_mp\killstreaks\nuke::_id_13147();
}

preplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_3;
  var_2.lastweaponused = var_2 getcurrentweapon();
  var_2.wasaimingdownsightsondamage = var_2 scripts\mp\utility\player::isplayerads();

  if(isai(self))
    self[[level.bot_funcs["_encstr_8BB20BDE37D723C2DA859DACC8"]]](var_1, var_3, var_5, var_6, var_0, var_9);

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo.hits))
    var_0.streakinfo.hits++;

  scripts\mp\perks\perkfunctions::bulletoutlinecheck(var_1, var_2, var_6.basename, var_5);

  if(var_5 == "_encstr_87A10C9D24E997A01F21838F3D34")
    var_2 thread emitfalldamage(var_3);

  logattacker(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

  if(isDefined(var_0) && isDefined(var_0.owner) && var_0.owner.team != var_2.team)
    var_2.lastdamagewasfromenemy = 1;
  else
    var_2.lastdamagewasfromenemy = isDefined(var_1) && var_1 != var_2;

  if(var_2.lastdamagewasfromenemy) {
    var_14 = gettime();
    var_1.damagedplayers[var_2.guid] = var_14;
    var_2.lastdamagedtime = var_14;
  }

  var_2 thread scripts\mp\potg_events::onplayerdamaged(var_1, var_2, var_5);
  var_2 thread scripts\cp\vehicles\vehicle_compass_cp::playerdamaged(var_0, var_1, var_3, var_5, var_6, var_9);

  if(isDefined(var_1) && var_3 != 0) {
    var_1 notify("_encstr_B6B10F0D8906786367394991622F2CB89F", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_2 notify("_encstr_8D1213082A6629E87F8F6C6F9B8F71CB4D32086812", var_1, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(level.preplayerdamaged))
    var_2 thread[[level.preplayerdamaged]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

postplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  var_17 = var_3;
  var_18 = scripts\engine\utility::isbulletdamage(var_5);

  if(var_3 > 10 && isDefined(var_0) && !var_2 scripts\mp\utility\player::isusingremote() && isPlayer(var_2)) {
    var_2 thread scripts\mp\shellshock::bloodeffect(var_0.origin);

    if(isPlayer(var_0) && var_5 == "_encstr_8DED0A21C79B660BC7588981") {
      if(isalive(var_2) && !var_2 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
        var_2 thread meleestagger(var_1);
        var_2.hitwithmeleetime = gettime();
      }

      var_0 thread scripts\mp\shellshock::bloodmeleeeffect(var_6, var_2);
      var_2 playRumbleOnEntity("_encstr_8DEB14B5ED13A17B8DDB1880A2A217189F9D4D3945A7");
      var_0 playRumbleOnEntity("_encstr_8DEB14B5ED13A17B8DDB1880A2A217189F9D4D3945A7");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
      if(var_3 >= self.health)
        var_3 = self.health - 1;
      else {
        var_19 = createheadicon(var_6);
        self[[scripts\mp\agents\agent_utility::agentfunc("_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46")]](var_0, var_1, var_3, var_4, var_5, var_19, var_7, var_8, var_9, var_10);
      }
    } else {
      var_19 = createheadicon(var_6);
      self[[scripts\mp\agents\agent_utility::agentfunc("_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46")]](var_0, var_1, var_3, var_4, var_5, var_19, var_7, var_8, var_9, var_10);
    }
  }

  handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, var_13, var_14, var_16);

  if(var_18)
    var_2 thread scripts\mp\battlechatter_mp::adddamagetaken(var_1, var_6, var_3);

  if(isagent(var_1) && isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 != var_2)
    var_2 thread scripts\mp\battlechatter_mp::addrecentattacker(var_1);

  if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(var_2.health < 30)
      var_2 thread scripts\mp\battlechatter_mp::hurtbadlywait();

    if(isDefined(var_1) && var_1 != var_2 && isexplosivedamagemod(var_5)) {
      if(!isDefined(var_6) || var_6.basename != "_encstr_B8D30758E3EE7827BA")
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, "_encstr_8FF010F221D7301FBECF0F558B4B9EACE351", undefined, 0.5);
    }
  }

  scripts\mp\gamelogic::sethasdonecombat(var_2, 1);

  if(isDefined(var_1) && var_1 != var_2)
    level.usestartspawns = 0;

  if(isPlayer(var_1) && isDefined(var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
    var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]++;
  else if(isPlayer(var_1))
    var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 1;

  if(isDefined(level.cinematic_replay_recording) && isPlayer(var_0)) {
    var_22 = spawnStruct();
    var_22.victim = var_2;
    var_22.vpoint = var_7;
    var_22.vdir = var_8;
    var_22.objweapon = var_6;
    var_22.kill = !isalive(var_2);
    var_0.hitrecord[var_0.hitrecord.size] = var_22;
  }

  if(isDefined(level.matchrecording_logeventmsg) && isPlayer(var_2) && isDefined(var_0) && isPlayer(var_0) && var_18) {
    if(var_15 == var_2.maxhealth && var_2.health != self.maxhealth)
      var_2.engagementstarttime = gettime();
  }

  if(allowdamageflash(var_1, var_2, var_6, var_5, var_3))
    var_2 showuidamageflash();

  if(isDefined(var_1) && var_3 > 0) {
    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_AC11173F08972B182333F88A89BD3551FE9AA4C388352C50DF"))
      var_1 thread scripts\mp\perks\perk_mark_targets::marktarget_run(var_2, var_5);

    if(var_18 && (var_6 hasattachment("_encstr_884F0D20FA75EF988724E8F634DF83") || var_6 hasattachment("_encstr_9A671007F5A879B8632AF0F9D857D1E28367") || var_6 hasattachment("_encstr_889A0E2CD6B6DB6BED46FABBF6ABDC46")) && scripts\mp\utility\damage::islowerbodyshot(var_9, var_5, var_1))
      var_1 thread scripts\mp\perks\perkfunctions::ammodisabling_run(var_2);

    if(isPlayer(var_2) && var_1 scripts\mp\utility\perk::_hasperk("_encstr_8D33136E83B28D96C28D3ABCAF6E43C92C1CB9568D") && isshrapnelsource(var_6, var_5))
      var_2.lastshrapneltime = gettime();

    if(isPlayer(var_2) && isPlayer(var_1))
      _encstr_86F228DCC627961C47DC5EDA0EE5CEC2B6AC3AF20759CDF213397D8563E8EBADDE46CAEBCC3317B3DCB1::play_animation_old(var_1, var_2);
  }

  if(isDefined(level.onplayerdamaged))
    var_2 thread[[level.onplayerdamaged]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_15, var_7, var_8, var_9, var_10, var_11, var_12);

  if(scripts\mp\utility\player::isreallyalive(var_2)) {
    switch (var_5) {
      case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
      case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
      case "_encstr_911B0C7DA090E9A7F799FD50DD48":
      case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
      case "_encstr_84670F0D974DCF124E3F7A931851A1FB9F":
        var_2 scripts\mp\utility\stats::incpersstat("_encstr_A97813EB838A30079B0AA21DD66F53F32030F3D59A", 1);
        break;
    }
  } else if(isDefined(var_4) && var_4 &level.idflags_penetration && !(var_4 &level.ss_respawn)) {
    if(var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      var_23 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_AC410A68C2CD019167865C4E") + 1;
      var_1 scripts\mp\playerstats_interface::setplayerstatbuffered(var_23, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_AC410A68C2CD019167865C4E");
    }

    var_1 scripts\mp\utility\stats::incpersstat("_encstr_ACB011A3FF55F7D8CE52E341509EA4F02DACA3", 1);
  }
}

meleestagger_anglesviewattack(var_0, var_1) {
  var_2 = anglesToForward((0, var_0 getplayerangles()[1], 0));
  var_3 = vectorNormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  return scripts\engine\math::anglebetweenvectorssigned(var_2, var_3, (0, 0, 1));
}

isshrapnelsource(var_0, var_1) {
  if(!isDefined(var_0) || nullweapon(var_0))
    return 0;

  if(!isexplosivedamagemod(var_1))
    return 0;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0))
    return 0;

  if(scripts\mp\utility\weapon::isvehicleweapon(var_0))
    return 0;

  if(scripts\mp\utility\weapon::isgamemodeweapon(var_0))
    return 0;

  var_2 = scripts\mp\utility\weapon::getequipmenttype(var_0.basename);

  if(isDefined(var_2)) {
    if(var_2 != "_encstr_B116071BCAD186858D")
      return 0;
  }

  return 1;
}

meleestagger(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = getdvarfloat("_encstr_82881D5B2B365956D7B9E80BB33BCA39F5E61AF61BADF5325D39163A4BDB73");
  var_2 = getdvarfloat("_encstr_B25122A8FB0865875F5B8B1F3F4FE553A1998E6B88C258D4104BE288EDD0E057831730E0");
  var_3 = self getviewkickscale();

  if(isDefined(level.playerzombievehiclehittoss))
    self setviewkickscale(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), level.playerzombievehiclehittoss * 2, level.playerzombievehiclehittoss));
  else
    self setviewkickscale(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), 3, 1.5));

  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), var_1 * 1.5, var_1);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A956095B2BB1AC59FAD6C1", "_encstr_B2BE0788BAF573592F", var_4, 0, 0);
  var_5 = 0;

  if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_6 = meleestagger_anglesviewattack(self, var_0);

    if(var_6 < 15)
      var_5 = 10;
    else if(var_6 > -15)
      var_5 = -10;
  }

  var_7 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), 1.15, 1.0);
  self setplayerangles(self getplayerangles() + (-14 * var_7, var_5, 0));
  thread meleedofroutine(var_0);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self playrumbleonpositionforclient("_encstr_B1EB1099828A6E10B70ADD61B281F3B1F359", self.origin);
  self setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  wait 0.05;
  self setviewkickscale(var_3);
  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), var_2 * 1.5, var_2);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_95280FE59FD25885C6E2C3F75F6FDB5F5A", "_encstr_B2BE0788BAF573592F", var_4, 0, 0);
}

meleedofroutine(var_0) {
  self notify("_encstr_8A5C0E70676BAD7845EF9120CF35CD99");
  self endon("_encstr_8A5C0E70676BAD7845EF9120CF35CD99");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = 1;
  var_2 = 2;
  var_3 = 350;
  var_4 = 1024;
  self setdepthoffield(var_1, var_2, var_3, var_4, 10, 9);
  var_5 = getdvarfloat("_encstr_82881D5B2B365956D7B9E80BB33BCA39F5E61AF61BADF5325D39163A4BDB73");
  wait(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3"), var_5 * 3, var_5));

  while(var_4 > 350) {
    var_1 = clamp(var_1 - 100, 0, 10000);
    var_2 = clamp(var_2 - 100, 0, 10000);
    var_3 = clamp(var_3 - 100, 0, 10000);
    var_4 = clamp(var_4 - 100, 0, 10000);
    self setdepthoffield(var_1, var_2, var_3, var_4, 10, 9);
    wait 0.05;
  }

  scripts\mp\utility\player::setdof_default();
}

monitormeleeoverlay(var_0) {
  scripts\engine\utility::_id_143B9(2.0, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 destroy();
}

allowdamageflash(var_0, var_1, var_2, var_3, var_4) {
  if(isagent(var_1))
    return 0;

  if(var_4 == 0)
    return 0;

  if(_id_139B6(var_0, var_1, var_2, var_3, var_4))
    return 0;

  return 1;
}

_id_139B6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    switch (var_2.basename) {
      default:
    }
  }

  return 0;
}

_id_1458B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_3.basename;

  if(trial_vehicle_outline_id(var_7))
    return 1;

  if(isDefined(level.disable_super_in_turret) && isDefined(var_7)) {
    if(istrue(level.disable_super_in_turret._id_146BF) && var_7 == "_encstr_A9FA118BE3BF87F959E780806F65F34F438DF6" || istrue(level.disable_super_in_turret.sat_wait_for_antenna) && var_7 == "_encstr_8BFA11A8CB6A3FC0F1501B2B6171A81F604BBF")
      return 1;
  }

  if(var_4 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    return 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_953F15DDAC8583F6DC4AD9E6DBE4B2E68492A0C9B6ED27"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_953F15DDAC8583F6DC4AD9E6DBE4B2E68492A0C9B6ED27")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  return 0;
}

trial_vehicle_outline_id(var_0) {
  return isDefined(var_0) && var_0 == "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633";
}

cac_modified_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_0 notify("_encstr_996A0D2B0622B031489FAED00F2A70", var_1);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor();
  var_17 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hashelmet();

  if(isPlayer(var_1) || isDefined(var_1) && istrue(var_1.brking_getcenterofcircle)) {
    armorvest_clearhit(var_1);
    helmet_clearhit(var_1);
    armorvest_clearbroke(var_1);
    helmet_clearbroke(var_1);
  }

  if(scripts\engine\utility::isbulletdamage(var_3)) {
    var_18 = var_4.basename;
    var_19 = scripts\mp\utility\damage::isheadshot(var_7, var_3, var_1);
    var_20 = scripts\mp\utility\damage::istorsoshot(var_7, var_3, var_1);

    if(isDefined(var_4) && scripts\mp\utility\weapon::iscacprimaryorsecondary(var_18)) {
      if(isbehindmeleevictim(var_1, var_0) && isPlayer(var_0))
        level thread scripts\mp\battlechatter_mp::saytoself(var_0, "_encstr_96010D1C1B39EB86B447EB980B6C6D", undefined, 0.1);
    }

    if(isDefined(var_10) && var_10 &level.idflags_ricochet) {
      if(var_18 != "_encstr_8BBA05185F8B99" && !scripts\mp\utility\weapon::issuperweapon(var_18))
        var_2 = var_2 * 0.4;
    }

    if(isPlayer(var_1) && var_1 scripts\mp\utility\perk::_hasperk("_encstr_BA37147FF327FF6B6FE518910FA9D8CADE7029193308") && !var_11)
      var_0 thread scripts\mp\perks\perkfunctions::setpainted(var_1);

    if(scripts\mp\utility\weapon::update_health_on_spawn(var_18) && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
      var_2 = var_2 * _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::reservedplacement();

    var_21 = var_20 && var_0 scripts\mp\utility\perk::_hasperk("_encstr_8F0A1450CB9717F85F8CDD53A78743C3FD13F078536B");
    var_22 = var_19 && var_17;
    var_23 = var_19 && istrue(var_0.hasheadgear);
    var_24 = istrue(var_1.waittill_unload_complete) && scripts\mp\utility\weapon::getweaponrootname(var_4) == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD";
    var_25 = var_1 scripts\mp\utility\perk::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913") || var_24;
    var_26 = scripts\mp\utility\damage::isfmjdamage(var_4, var_3, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_92440CFD4F8310B8DBFAAB30B227", "_encstr_A2F6108A20351B4869FF5E519D3813E3551B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_92440CFD4F8310B8DBFAAB30B227", "_encstr_A2F6108A20351B4869FF5E519D3813E3551B")]](var_1, var_5, var_0);

    if(var_22 && !istrue(var_0.inlaststand)) {
      var_27 = weaponclass(var_4);
      var_28 = 0;

      if(var_27 == "_encstr_850707F7E5833355B8" || var_27 == "_encstr_A11804C86B39")
        var_28 = 1;

      var_29 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagehelmet(var_2, var_28, var_6);
      var_2 = var_2 * var_29;
    }

    if(issubstr(var_18, "_encstr_81190403FB70")) {
      var_30 = scripts\mp\utility\damage::validshotcheck(var_3, var_1);
      var_31 = var_0.br_maxarmorhealth;
      var_32 = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");

      if(scripts\mp\utility\game::unset_relic_grounded() && isDefined(var_31))
        var_32 = var_32 + var_31;

      var_33 = 1;
      var_34 = 0;
      var_35 = _func_0440(var_4, var_2, var_7, var_30, var_12, var_32, var_33, var_34);
      var_2 = var_2 + (var_35 - var_2);
    }

    if(var_25 && var_21)
      armorvest_sethit(var_1);
    else if(var_25 && var_2 > 0) {
      var_35 = applystoppingpower(var_4, var_7, var_3, var_1, var_2, 100);
      var_13 = var_13 + (var_35 - var_2);
    } else if(var_21 && !istrue(var_0.tookvesthit) && !var_26) {
      var_0.tookvesthit = 1;
      var_35 = adjustbulletstokill(var_2, 100, level.armorvestbulletdelta);
      var_13 = var_13 + (var_35 - var_2);
      helmet_sethit(var_1);
    } else if(var_23 && !var_26) {
      var_36 = scripts\mp\perks\headgear::getdamagemod();
      var_37 = scripts\mp\perks\headgear::getmaxdamage();
      var_38 = int(clamp(var_2 * var_36, 1, var_37));

      if(var_0.health > 1)
        var_38 = int(min(var_0.health - 1, var_38));

      var_39 = var_2 - var_38;
      var_13 = var_13 - var_39;
      var_0 notify("_encstr_888D0ED059C2913B2B85C9F5B985EC59");
      helmet_sethit(var_1);
    }

    if(var_0 scripts\mp\utility\killstreak::isjuggernaut())
      var_2 = _id_11C90(var_4, var_2, var_26, 0, var_1);

    if(isDefined(var_1) && isDefined(var_1._id_14258) && var_1._id_14258 == "_encstr_A7B30DE187CA05B92B54B8537A15E8")
      var_2 = int(var_2 / 3);
  } else if(isexplosivedamagemod(var_3)) {
    if(isPlayer(var_1)) {
      if(var_1 != var_0 && var_1 scripts\mp\utility\perk::_hasperk("_encstr_9AFE106EE0B2D8B42CD8A397BEE058A59BE8") && !var_11)
        var_0 thread scripts\mp\perks\perkfunctions::setpainted(var_1);
    }

    var_2 = _id_11C9A(var_2, var_8, var_4);
    var_2 = scripts\mp\equipment\claymore::claymore_modifieddamage(var_0, var_4, var_8, var_3, var_2);
    var_2 = scripts\mp\equipment\at_mine::at_mine_modified_damage(var_0, var_8, var_4, var_3, var_2);

    if(isPlayer(var_1) && weaponinheritsperks(var_4) && (var_1 scripts\mp\utility\perk::_hasperk("_encstr_97D21AA7F33FFEA116B04BD0DF9748DA8C3F37345D59DD39B0531F07") && var_0 scripts\mp\utility\perk::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19"))) {} else if(isPlayer(var_1) && weaponinheritsperks(var_4) && !var_11 && var_1 scripts\mp\utility\perk::_hasperk("_encstr_97D21AA7F33FFEA116B04BD0DF9748DA8C3F37345D59DD39B0531F07"))
      var_13 = var_13 + var_2 * level.explosivedamagemod;
    else if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_40 = _id_11C8F(var_2, var_1, var_0);
      var_13 = var_13 - (var_2 - var_40);
    }

    if(isPlayer(var_1) && var_1 == var_0 && scripts\mp\utility\weapon::iskillstreakweapon(var_4))
      var_2 = var_2 * 0.5;

    if(isDefined(level.lethaldelay) && !scripts\mp\equipment::lethaldelaypassed())
      var_2 = var_2 * level.graceperiodgrenademod;

    if(isDefined(var_0) && var_0 scripts\mp\utility\killstreak::isjuggernaut() && isDefined(var_4) && var_4.basename == "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B")
      var_2 = var_2 * 110;
  } else if(var_3 == "_encstr_9B0D099AD3887D91252954") {
    if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
      if(isDefined(var_4.basename) && var_4.basename == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1" || var_4.basename == "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579")
        var_2 = _id_11C90(var_4, var_2, 0, 1, var_1);
    }

    if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_40 = _id_11C8F(var_2, var_1, var_0);
      var_13 = var_13 - (var_2 - var_40);
    }
  }

  var_41 = _id_1458B(var_1, var_0, var_2, var_4, var_3, var_8, var_7);
  var_42 = ["_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", "_encstr_9B0D099AD3887D91252954", "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B", "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5"];
  var_43 = var_7 == "_encstr_A32D07CFD14BAA94D0" && !scripts\engine\utility::array_contains(var_42, var_3);

  if(var_16 && !istrue(var_41) && !istrue(var_0.inlaststand) && !var_43) {
    var_44 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_2);
    var_45 = int(var_2 - var_44);
    var_15 = var_45;
    var_13 = var_13 - var_45;
    var_0.tookvesthit = 1;

    if(isPlayer(var_1)) {
      armorvest_sethit(var_1);

      if(_id_1331E(self))
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B2BE0788BAF573592F", var_45);
      else if(isDefined(level._id_12001))
        var_1[[level._id_12001]](var_45);
    } else if(isDefined(var_1) && istrue(var_1.brking_getcenterofcircle))
      armorvest_sethit(var_1);
  }

  var_46 = scripts\mp\equipment\trophy_system::trophy_modifieddamage(var_1, var_0, var_4.basename, var_2, var_13);
  var_2 = var_46[0];
  var_13 = var_46[1];

  if(var_0 scripts\mp\heavyarmor::hasheavyarmor()) {
    var_46 = scripts\mp\heavyarmor::heavyarmormodifydamage(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_14 = var_46[0] > 0;
    var_2 = var_46[1];
    var_13 = var_46[2];
  }

  if(scripts\mp\lightarmor::haslightarmor(var_0)) {
    var_46 = scripts\mp\lightarmor::lightarmor_modifydamage(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_15 = var_46[0] > 0;
    var_2 = var_46[1];
    var_13 = var_46[2];
  }

  if(isPlayer(var_1) || isDefined(var_1) && istrue(var_1.brking_getcenterofcircle)) {
    var_47 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor();
    var_48 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hashelmet();

    if(var_16 && !var_47)
      armorvest_setbroke(var_1);

    if(var_17 && !var_48)
      helmet_setbroke(var_1);
  }

  if(!isPlayer(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BACB074025B01AAA28", "_encstr_A20E0F9BEB0D10491109C280E0689A7A6D"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BACB074025B01AAA28", "_encstr_A20E0F9BEB0D10491109C280E0689A7A6D")]](var_1, var_5, var_0);
  }

  if(scripts\mp\utility\damage::hashealthshield(var_0))
    var_2 = var_0 scripts\mp\utility\damage::gethealthshielddamage(var_2);

  if(istrue(var_0.inlaststand) && getdvarfloat("_encstr_8F4A214057AA3E310A9E0305325141A1F3A3F9F0C75E9199A286F1958C49A769448F78", 0) > 0) {
    var_49 = 1;

    if(isDefined(level._id_11C82)) {
      var_50 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_0, var_2, var_4, var_3, var_8);
      var_49 = self[[level._id_11C82]](var_50);
    }

    if(var_49)
      var_2 = int(ceil(var_2 / getdvarfloat("_encstr_8F4A214057AA3E310A9E0305325141A1F3A3F9F0C75E9199A286F1958C49A769448F78", 0)));
  }

  if(var_2 <= 1)
    var_2 = int(ceil(clamp(var_2, 0, 1)));
  else
    var_2 = int(var_2 + var_13);

  return [var_2, var_15, var_14, var_7];
}

_id_11C8F(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::unset_relic_grounded();
  var_4 = undefined;
  var_5 = undefined;

  if(var_3) {
    var_4 = level.completed_areas;
    var_5 = level.completecollectionquest;
  } else {
    var_4 = level.blastshieldmod;
    var_5 = level.blastshieldclamp;
  }

  var_6 = int(var_0 * var_4);

  if(var_1 != var_2)
    var_6 = clamp(var_6, 0, var_5);

  return var_6;
}

_id_11C90(var_0, var_1, var_2, var_3, var_4) {
  var_5 = weaponclass(var_0);
  var_6 = 1;

  if(isDefined(var_4) && var_4 scripts\mp\utility\killstreak::isjuggernaut() && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    var_6 = _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::remove_spawners_that_can_be_seen();

  switch (var_5) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_8D940738966ED1DB8D":
      var_1 = min(15, var_1);
      break;
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
      if(scripts\mp\utility\weapon::update_health_on_spawn(var_0.basename) && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        var_1 = min(50, var_1);
      else
        var_1 = min(20, var_1);

      break;
    case "_encstr_A1100738A33A638123":
      var_1 = min(25, var_1);
      break;
    case "_encstr_850707F7E5833355B8":
      break;
    default:
      var_1 = min(15, var_1);
      break;
  }

  var_1 = int(var_1 * var_6);

  if(istrue(var_2))
    var_1 = var_1 * level.armorpiercingmod;

  if(istrue(var_3)) {
    if(var_0.basename == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1")
      var_1 = var_1 * 6;
    else if(var_0.basename == "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579")
      var_1 = var_1 * 3;
    else if(var_0.basename == "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002")
      var_1 = var_1 * 3;
  }

  return var_1;
}

_id_11C9A(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return var_0;

  if(!nullweapon(var_2))
    return var_0;

  if(!isDefined(var_1.code_classname) || var_1.code_classname != "_encstr_96010BDCD8392D073A164C1B2B")
    return var_0;

  var_3 = var_1.classname;

  if(isDefined(var_3) && isstartstr(var_3, "_encstr_81CF0C378D4EA5C18E2C891BB2FA")) {
    var_3 = getsubstr(var_3, 11, var_3.size);
    var_4 = ["_encstr_B4781ABB7437DAB7D287F8090BFBB1F383E0E8C8E6AB91B943450FEA", "_encstr_A7351138181767F8A3678136CB450399E4B34A", "_encstr_A7281557D6BE332D27ACF5CA0FD15AE6EC572D3734599C", "_encstr_A7351138181767F8A3678136CB450399E4B34A", "_encstr_A78D218C956C7B9CF5982C27C956C6CDEBD9855BCA1CC62CCBF5998D2CADD60B26D8CA", "_encstr_935C14AB9BF51C4EDB83B0CDACD79DC2CDAF3A0B9BDA", "_encstr_AD25206AFA7E8BA45D87030228EFB903612ADD771C70CD31D242A3D705989BAE4D30", "_encstr_AA250BF3D839D6AD0182206D88", "_encstr_B6261326DB1ED777DBF619AC73FAB327CADC8519AC", "_encstr_A741131F4FB8CBE9C8B02FF28E60317398C19FB32F", "_encstr_88CB1346B21B7B93D71CE47B0785CD59D7A3589BB6", "_encstr_A6941F6D9137C809B5A288A0F90AC5C0FB2960D5270333555D8A60F1132387BB07", "_encstr_A98417E8D39B1BC367BDE8DDAF3B4BCF023A4860A973435807", "_encstr_A9A81408FCDBB0AFB3731F29573A550972D571406724", "_encstr_8BD109806AE5BF89C365A1", "_encstr_9B781072D74FF38A10808FAB30CE442A95E2", "_encstr_B1621CABD743C681E598033902C1C8863967190B974A18B93A36CBD3EFBC"];

    foreach(var_6 in var_4) {
      if(isstartstr(var_3, var_6)) {
        if(scripts\mp\utility\game::isanymlgmatch())
          return 0;
        else
          return int(min(var_0, 60));
      }
    }
  }

  return var_0;
}

unsetspecialistbonus(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0) && isPlayer(var_0) && (!isalive(var_0) || scripts\mp\utility\player::unset_relic_trex(var_0))) {
    if(istrue(var_5) && weaponclass(var_4) == "_encstr_A1100738A33A638123")
      return 1;
    else if(var_2 >= var_1.health) {
      if(var_3 == "_encstr_8DED0A21C79B660BC7588981")
        return 1;
      else if(istrue(var_5))
        return 1;
    }
  }

  return 0;
}

tutorialzoneexit(var_0, var_1) {
  return isDefined(var_1) && weaponclass(var_1) == "_encstr_965306392D3336B2" && isDefined(var_1.underbarrel) && issubstr(var_1.underbarrel, "_encstr_A11B09C4ABB15B371B57EC");
}

usetimeoverride(var_0) {
  return isDefined(var_0) && weaponclass(var_0) == "_encstr_A1100738A33A638123";
}

uavworstid(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD")
    return 1;

  return 0;
}

vehicle_collision_getleveldataforvehicle(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A")
    return 1;

  return 0;
}

turn_on_laser_trap(var_0, var_1) {
  if(var_0 hasattachment("_encstr_99E91506C9ED1A03B334A15FAF78598A02E1B3C0181637") && var_1 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9")
    return 1;

  return 0;
}

_id_132F0(var_0) {
  if(var_0 hasattachment("_encstr_A9B01326DEB13A2B0F3863F6D7C6C9DB37B9267B77"))
    return 1;

  return 0;
}

_id_1332D(var_0) {
  if(var_0 hasattachment("_encstr_BEE308C2D9C177A398E1", 1))
    return 0;

  return 1;
}

usefaillaststandmsg(var_0) {
  if(var_0.basename == "_encstr_A90C1AE6ACB63A5987AFE16BA5ADCA13C027FAE60E36B0DC86D76B07" || var_0.basename == "_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607" || var_0.basename == "_encstr_84A0166830BBFB0FB38089F0E1D84E2B5B18102BBA09B85B" || var_0.basename == "_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3" || var_0.basename == "_encstr_AD6E1AB959D6A356F0BE85B063E01AB013C8F5CDC163B0B90DBEAD83")
    return 1;
  else
    return 0;
}

_id_13714(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isDefined(var_0)) {
    if(var_4 &level.sstablet_init)
      var_5 = "_encstr_8FE10A32B133757B0F6DB9A0";
    else
      var_5 = "_encstr_A33A0ACDF077B5EBF7818B68";

    if(!isDefined(var_1._id_122F1))
      var_1._id_122F1 = [];

    var_6 = "_encstr_B40101" + var_0 getentitynumber();
    var_7 = gettime();

    foreach(var_13, var_9 in var_1._id_122F1) {
      foreach(var_12, var_11 in var_9) {
        if((var_7 - var_11.time) / 1000 > 0.1) {
          var_1._id_122F1[var_13] = scripts\engine\utility::array_remove_key(var_1._id_122F1[var_13], var_12);

          if(var_1._id_122F1[var_13].size == 0)
            var_1._id_122F1 = scripts\engine\utility::array_remove_key(var_1._id_122F1, var_13);
        }
      }
    }

    if(!isDefined(var_1._id_122F1[var_5]))
      var_1._id_122F1[var_5] = [];

    if(!isDefined(var_1._id_122F1[var_5][var_6])) {
      var_1._id_122F1[var_5][var_6] = spawnStruct();
      var_1._id_122F1[var_5][var_6].time = var_7;
      var_1._id_122F1[var_5][var_6]._id_122F0 = [];
    }

    var_14 = rotationentangles(var_1, var_2);
    var_15 = var_1._id_122F1[var_5][var_6]._id_122F0;

    if(var_1._id_122F1[var_5][var_6]._id_122F0.size >= var_14) {
      if(getdvarint("_encstr_AC1D2677F312713E435BD9412227F5D86F77C9DB9FFCF8067B61F1499AB7A4D009B06B590C67B84E", 1)) {
        foreach(var_18, var_17 in var_1._id_122F1[var_5][var_6]._id_122F0) {
          if(var_3 > var_17) {
            var_1._id_122F1[var_5][var_6]._id_122F0[var_18] = var_3;
            var_1._id_122F1[var_5][var_6]._id_122F0 = scripts\engine\utility::array_sort_with_func(var_1._id_122F1[var_5][var_6]._id_122F0, ::tromeo_death_watcher);
            return var_3 - var_17;
          }
        }
      }

      return 0;
    } else {
      var_1._id_122F1[var_5][var_6]._id_122F0 = scripts\engine\utility::array_add(var_1._id_122F1[var_5][var_6]._id_122F0, var_3);
      var_1._id_122F1[var_5][var_6]._id_122F0 = scripts\engine\utility::array_sort_with_func(var_1._id_122F1[var_5][var_6]._id_122F0, ::tromeo_death_watcher);
    }
  }

  return var_3;
}

tromeo_death_watcher(var_0, var_1) {
  return var_0 < var_1;
}

rotationentangles(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253" || var_2 == "_encstr_8D900DB477077D1C2DD736E0C28385") {
    if(var_0 isdualwielding())
      return 2;

    if(var_1 hasattachment("_encstr_A77E14C4B0C9CD867BC91DF58D432CE4B14B56DC6453"))
      return 3;

    var_3 = var_0 playerads() > 0.5;

    if(var_3) {
      return 4;
      return;
    }

    return 3;
    return;
  } else
    return 4;
}

armorvest_washit(var_0) {
  return isDefined(var_0.hitarmorvest) && gettime() == var_0.hitarmorvest;
}

armorvest_sethit(var_0) {
  var_0.hitarmorvest = gettime();
}

armorvest_clearhit(var_0) {
  var_0.hitarmorvest = undefined;
}

armorvest_wasbroke(var_0) {
  return isDefined(var_0.brokearmorvest) && gettime() == var_0.brokearmorvest;
}

armorvest_setbroke(var_0) {
  var_0.brokearmorvest = gettime();
}

armorvest_clearbroke(var_0) {
  var_0.brokearmorvest = undefined;
}

_encstr_81F016C3636EFE4F5E5299D7FD65B2B2B451037058081FA3(var_0) {
  return isDefined(var_0._encstr_87EE1203E82BC0FA738CE09EF60312823320D7FB) && gettime() == var_0._encstr_87EE1203E82BC0FA738CE09EF60312823320D7FB;
}

_encstr_930616A91D2EC0D3EF43F0B86B9B85B0034FE73B94D4F09D(var_0) {
  var_0._encstr_87EE1203E82BC0FA738CE09EF60312823320D7FB = gettime();
}

_encstr_B24D188308095EBBF30E659D76B53203F371171B90E19272DB25(var_0) {
  var_0._encstr_87EE1203E82BC0FA738CE09EF60312823320D7FB = undefined;
}

_encstr_BD2218A1ACC267F20B9C5BEDC967CACDE8BEDDB09B8927EDADCA(var_0) {
  return isDefined(var_0._encstr_ACD91426C9BD6D56432B58679716276BF69CCE2BDC8E) && gettime() == var_0._encstr_ACD91426C9BD6D56432B58679716276BF69CCE2BDC8E;
}

_encstr_96E118CB528215DB6A93F53063FB0F0FFB57EEAA233AB0089C07(var_0) {
  var_0._encstr_ACD91426C9BD6D56432B58679716276BF69CCE2BDC8E = gettime();
}

_encstr_AC091A6127A28C70A15A6038429ED8464B67EFE1DF4A5690EA75A871(var_0) {
  var_0._encstr_ACD91426C9BD6D56432B58679716276BF69CCE2BDC8E = undefined;
}

helmet_washit(var_0) {
  return isDefined(var_0.hithelmet) && gettime() == var_0.hithelmet;
}

helmet_sethit(var_0) {
  var_0.hithelmet = gettime();
}

helmet_clearhit(var_0) {
  var_0.hithelmet = undefined;
}

helmet_wasbroke(var_0) {
  return isDefined(var_0.brokehelmet) && gettime() == var_0.brokehelmet;
}

helmet_setbroke(var_0) {
  var_0.brokehelmet = gettime();
}

helmet_clearbroke(var_0) {
  var_0.brokehelmet = undefined;
}

applystoppingpower(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");
  var_6 = getbulletstokill(var_5, var_4);
  var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_6 == 2) {
    if(_id_138F2(var_0, var_1, var_2, var_3))
      return var_5;
    else
      return 0.9 * var_5;
  }

  var_8 = -1;

  if(var_6 >= 7)
    var_8 = -3;
  else if(var_6 >= 5)
    var_8 = -2;

  return adjustbulletstokill(var_4, var_5, var_8, var_7);
}

_id_138F2(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_5 = weaponclass(var_0);

  if(var_4 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD")
    return 1;
  else if(var_5 == "_encstr_850707F7E5833355B8") {
    switch (var_4) {
      case "_encstr_928210A17CC2BF6265499B129B43DFB323EF":
      case "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;

        break;
      case "_encstr_A1E90DBB8CDA89536851CF8BDD6B66":
      case "_encstr_82660D691C902EABA8293197FB038E":
      case "_encstr_A52C0E7020307103407898128DC7C6CB":
        if(scripts\mp\utility\damage::istorsoshot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;

        break;
      default:
        if(scripts\mp\utility\damage::isupperbodyshot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;
    }
  } else if(var_5 == "_encstr_8D940738966ED1DB8D") {
    switch (var_4) {
      case "_encstr_88FE0D0157202970845121C58E802F":
      case "_encstr_8D900DB477077D1C2DD736E0C28385":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;

        break;
    }
  } else if(var_5 == "_encstr_965306392D3336B2") {
    switch (var_4) {
      case "_encstr_AC5B11276F638919E0863E8278603213977BC2":
      case "_encstr_95FA0EA5EE1CFA5827D733B08DB45B16":
        if(scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;

        break;
    }

    var_6 = getweaponammopoolname(var_0);

    switch (var_6) {
      case "_encstr_9389125DA80582F427BC28A935D3EB6A31AA1D4D":
      case "_encstr_A71915D1383ED19C43AF2729D59F46D711B77209D09B47":
        if(scripts\mp\utility\damage::istorsouppershot(var_1, var_2, var_3) || scripts\mp\utility\damage::isheadshot(var_1, var_2, var_3))
          return 1;

        break;
    }
  }

  return 0;
}

adjustbulletstokill(var_0, var_1, var_2, var_3) {
  var_0 = int(var_0);
  var_2 = int(var_2);

  if(var_2 == 0)
    return var_0;

  if(var_0 <= 0)
    return var_0;

  var_4 = getbulletstokill(var_1, var_0);
  var_5 = var_4 + var_2;

  if(isDefined(var_3) && var_3 == "_encstr_A1B312733C88381B6A0EDB0692184B8B4A030B35")
    var_0 = var_0 * 1.3;
  else if(var_5 <= 0)
    var_0 = var_0 * 1.4;
  else if(var_5 == 1)
    var_0 = int(max(var_1, var_0 * 1.4));
  else {
    var_6 = scripts\engine\utility::ter_op(var_0 > var_1, var_1, var_0);
    var_7 = 0.0;

    if(var_4 == 1)
      var_7 = 0.9;
    else {
      var_8 = int(ceil(var_1 / (var_4 - 1)));
      var_9 = int(ceil(var_1 / var_4));
      var_7 = (var_6 - var_9) / (var_8 - var_9);
    }

    var_10 = int(ceil(var_1 / (var_5 - 1)));
    var_11 = int(ceil(var_1 / var_5));
    var_0 = int((var_10 - var_11) * var_7 + var_11);
  }

  return var_0;
}

getbulletstokill(var_0, var_1) {
  return int(ceil(var_0 / var_1));
}

isbehindmeleevictim(var_0, var_1) {
  var_2 = vectorNormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_3 = anglesToForward((0, var_1.angles[1], 0));
  return vectordot(var_2, var_3) > 0.4;
}

killstreakdamagefilter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(level.playgotinfectedsoundcount))
    var_5 = [[level.playgotinfectedsoundcount]](var_0, var_1, var_2, var_3, var_4);

  if(var_1 scripts\mp\utility\game::isspawnprotected() || istrue(var_5)) {
    var_6 = int(max(var_1.health / 4, 1));

    if(var_2 >= var_6 && scripts\mp\utility\weapon::iskillstreakweapon(var_3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_3) && var_4 != "_encstr_8DED0A21C79B660BC7588981")
      var_2 = var_6;
  }

  return var_2;
}

friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = 0;

  if(isDefined(var_6)) {
    switch (var_6.basename) {
      case "_encstr_8BBA05185F8B99":
        if(isDefined(var_0) && scripts\mp\utility\entity::isdronepackage(var_0))
          var_13 = 1;

        break;
      case "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583":
      case "_encstr_92EA0A290B32FF88A90170EB":
        var_13 = 1;
        break;
    }
  }

  return var_13;
}

handlefriendlyfiredamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_6) && scripts\engine\utility::isbulletdamage(var_5) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_6.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_6.basename)))
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_2, "_encstr_B621107140282E7F17C807BE3FD0893CD4B0", undefined, 0.25);

  if(isDefined(var_0) && !isPlayer(var_0)) {
    if(!isDefined(var_1)) {
      if(isDefined(var_0.owner))
        var_1 = var_0.owner;
    } else if(!isPlayer(var_1)) {
      if(isDefined(var_0.owner))
        var_1 = var_0.owner;
      else if(isDefined(var_1.owner))
        var_1 = var_1.owner;
    }
  }

  if(level.hardcoremode) {
    if(isDefined(var_4) && var_4 &level.idflags_ricochet && scripts\engine\utility::isbulletdamage(var_5))
      var_3 = int(var_3 * 0.2);
  }

  if(level.friendlyfire != 0) {
    if(level.maxallowedteamkills == -1)
      var_14 = 0;
    else
      var_14 = istrue(var_2.unset_relic_ammo_drain) || istrue(var_2.isdefusing) || istrue(var_2.isplanting);

    var_15 = unset_relic_doubletap(var_1);

    if(var_14 || var_15) {
      var_3 = int(var_3 * 0.5);

      if(var_3 < 1)
        var_3 = 1;

      var_1.lastdamagewasfromenemy = 0;
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isPlayer(var_1) && level.friendlyfire != 1 || var_6.basename == "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E")
    return 0;
  else if(level.friendlyfire == 1) {
    if(var_3 < 1)
      var_3 = 1;

    var_2.lastdamagewasfromenemy = 0;
    _id_119C0(var_2, var_1, var_3, var_5);
    var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1 handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0, var_13);
    return 0;
  } else if(level.friendlyfire == 2) {
    var_3 = int(var_3 * 0.5);

    if(var_3 < 1)
      var_3 = 1;

    var_1.lastdamagewasfromenemy = 0;

    if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12))
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    return 0;
  } else if(level.friendlyfire == 3) {
    var_3 = int(var_3 * 0.5);

    if(var_3 < 1)
      var_3 = 1;

    var_2.lastdamagewasfromenemy = 0;
    var_1.lastdamagewasfromenemy = 0;
    _id_119C0(var_2, var_1, var_3, var_5);
    var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12))
      damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    var_1 handledamagefeedback(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0, var_13);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_16 = var_1.pers["_encstr_AA9C0A1555B798EF648228C8"] >= level.maxallowedteamkills;

    if(var_16) {
      if(!friendlyfire_ignoresdamageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1)
          var_3 = 1;

        var_1.lastdamagewasfromenemy = 0;
        damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
      }

      return 0;
    }
  }

  return var_3;
}

unset_relic_doubletap(var_0) {
  if(level.ingraceperiod)
    return 1;

  if(var_0.pers["_encstr_AA9C0A1555B798EF648228C8"] > 1 && scripts\mp\utility\game::gettimepassed() < level.graceperiod * 1000 + 8000 + var_0.pers["_encstr_AA9C0A1555B798EF648228C8"] * 1000)
    return 1;

  return 0;
}

damageattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_1.friendlydamage = 1;
    var_1 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1.friendlydamage = undefined;
  }
}

_id_11C5E(var_0) {
  return var_0 == "_encstr_81CC0586952C91" || var_0 == "_encstr_A6CC076A05751852B3" || var_0 == "_encstr_9ABA05E87F4B70";
}

_id_11C92(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "_encstr_8FFC0D1F543049D2AB0740FA1B7F81" && var_1 hasattachment("_encstr_AB5C0DE17A6F71D065E76B7BCBCF42") && var_1 hasattachment("_encstr_A7540FF6785E3255920BC309C003E3F79F"))
    return var_0 * 0.75;

  return var_0;
}

_id_11C93(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "_encstr_96D20C74F8FBB7C3433793F84727" && var_1 hasattachment("_encstr_A1280CF04AA4DB49B74FA1AB43A7") && var_1 hasattachment("_encstr_81930DF1E6B2C87D8B6F673B4F424D"))
    return var_0 * 0.75;

  return var_0;
}

_id_11C9F(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1)) {
    if(turn_on_laser_trap(var_0, var_4)) {
      if(var_2.health > 0 && var_3 >= var_2.health)
        var_3 = var_2.health - 1;
    } else if(isDefined(var_0._id_136FA)) {
      if(!isDefined(var_1._id_136F5))
        var_1._id_136F5 = [];

      var_5 = "_encstr_B40101" + var_2 getentitynumber();
      var_6 = gettime();
      var_1._id_136F5[var_5] = spawnStruct();
      var_1._id_136F5[var_5].time = var_6;
      var_1._id_136F5[var_5].starcount = var_0._id_136FA.basename;
    } else if(isDefined(var_1._id_136F5)) {
      var_6 = gettime();

      foreach(var_9, var_8 in var_1._id_136F5) {
        if(var_6 != var_8.time)
          var_1._id_136F5 = scripts\engine\utility::array_remove_key(var_1._id_136F5, var_9);
      }

      var_9 = "_encstr_B40101" + var_2 getentitynumber();

      if(scripts\engine\utility::array_contains_key(var_1._id_136F5, var_9) && var_1._id_136F5[var_9].starcount == var_0.basename) {
        var_3 = 0;
        var_1._id_136F5 = scripts\engine\utility::array_remove_key(var_1._id_136F5, var_9);
      }

      if(var_1._id_136F5.size == 0)
        var_1._id_136F5 = undefined;
    }
  }

  return var_3;
}

_id_11C61(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::isanymlgmatch() && isDefined(var_0) && isPlayer(var_0) && !nullweapon(var_3) && scripts\mp\utility\weapon::isprimaryweapon(var_3) && scripts\engine\utility::isbulletdamage(var_2) && _id_11C5E(var_4)) {
    switch (var_3.classname) {
      case "_encstr_BE1904DCDA9D":
      case "_encstr_8D940738966ED1DB8D":
      case "_encstr_BE0703A54C":
      case "_encstr_965306392D3336B2":
        var_1 = int(clamp(var_1, 0, var_3.maxdamage * 1.3));
        break;
    }
  }

  return var_1;
}

_id_11C9B(var_0, var_1, var_2) {
  var_3 = var_1;

  if(isDefined(var_2) && var_2 == "_encstr_87A10C9D24E997A01F21838F3D34") {
    if(var_0 scripts\mp\utility\killstreak::isjuggernaut())
      var_3 = var_0 scripts\mp\juggernaut::vehicle_deletenextframe();
  }

  return var_3;
}

_id_11CA3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(var_2 scripts\mp\utility\killstreak::isjuggernaut())
      var_5 = var_2 scripts\mp\juggernaut::vehicle_deregister_on_death(var_3, var_4);
  }

  return var_5;
}

_id_11CA2(var_0, var_1) {
  var_2 = var_1;
  var_3 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_3))
    var_2 = scripts\cp_mp\vehicles\vehicle_damage::_id_14160(var_3, var_0, var_1);

  return var_2;
}

_id_11C97(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;

  if(isDefined(var_4) && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3") {
    if(isDefined(var_0) && isDefined(var_1) && var_0 == var_1 && var_1 scripts\mp\utility\killstreak::isjuggernaut() && var_2 scripts\mp\utility\killstreak::isjuggernaut())
      var_5 = var_2 scripts\mp\juggernaut::vehicle_deletenextframelate(var_3);
  }

  return var_5;
}

modifydamagegeneral(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_3 = _id_11C92(var_3, var_6);
  var_3 = _id_11C93(var_3, var_6);
  var_3 = _id_11C61(var_1, var_3, var_5, var_6, var_9);
  var_3 = _id_11C9B(var_2, var_3, var_5);
  var_3 = _id_11CA3(var_0, var_1, var_2, var_3, var_5);
  var_3 = _id_11CA2(var_2, var_3);
  var_3 = _id_11C97(var_0, var_1, var_2, var_3, var_5);
  var_3 = _id_11C9F(var_6, var_1, var_2, var_3, var_5);

  if(var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_3 != 1 && (isDefined(var_6) && var_6 getbaseweapon().basename != "_encstr_96AA1696BB1CFACDB6F5D1C9998DB2C643568ED1B27DDAC1")) {
    var_3 = var_3 * getdvarfloat("_encstr_957C12339F73694AF85AD35DD79258EFD8B98238");
    var_3 = int(var_3);
  }

  if(var_5 == "_encstr_A1ED0BA9FF84562B60BA073E83" && var_3 != 1) {
    if(istrue(var_6.isalternate) && scripts\mp\weapons::turretobjweapon(var_6.underbarrel)) {
      var_12 = var_0 scriptableclearparententity();
      var_13 = length(var_12);

      if(var_13 < 400)
        var_3 = 10;
    }
  }

  if(isDefined(level.modifyplayerdamage))
    var_3 = int([[level.modifyplayerdamage]](var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_11));

  if(!isDefined(var_2.donotmodifydamage))
    var_3 = int(var_3 * var_2 scripts\cp_mp\utility\damage_utility::getdamagemodifiertotal(var_0, var_1, var_2, var_3, var_5, var_6, var_9));

  if(scripts\mp\utility\damage::isheadshot(var_9, var_5, var_1))
    var_5 = "_encstr_87280E1FB705D168313D1FD197B1A799";

  if(scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_8DEF0E30E63BA241CF8A8030326521BB")) {
    if(var_5 == "_encstr_87280E1FB705D168313D1FD197B1A799")
      var_3 = 150;
  }

  return var_3;
}

handleriotshieldhits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_8 != "_encstr_A32D07CFD14BAA94D0" || istrue(var_2.should_take_damage))
    return var_3;

  var_12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, var_1, var_3, var_5, var_4, var_0, var_6, var_7, undefined, undefined, undefined, var_9);
  var_13 = istrue(var_1.ignoreriotshieldxp);

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;

    if(var_2 == var_1)
      return 0;
  }

  if(var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5") {
    if(isPlayer(var_2)) {
      var_2.lastattackedshieldplayer = var_1;
      var_2.lastattackedshieldtime = gettime();
    }

    var_1 notify("_encstr_829B0FCF9CF8BF38D0CF8D3830E7B8F9A3");

    if(scripts\mp\utility\weapon::isenvironmentweapon(var_5.basename))
      var_14 = 25;
    else {
      var_15 = cac_modified_damage(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_0, 0, var_9, var_10, var_11);
      var_14 = var_15[0];
      var_16 = var_15[1];
      var_17 = var_15[2];
      var_8 = var_15[3];
    }

    var_1 scripts\mp\utility\stats::incpersstat("_encstr_8D1D194EA5BD1DA934A5CA63C8112CB60BECB20A899BBDC94C5691", var_14);

    if(isPlayer(var_2) && isDefined(var_1.rearguardattackers)) {
      var_18 = var_2 getentitynumber();

      if(!isDefined(var_1.rearguardattackers[var_18]))
        var_1.rearguardattackers[var_18] = var_14;
      else
        var_1.rearguardattackers[var_18] = var_1.rearguardattackers[var_18] + var_14;
    }

    if(var_13)
      return 0;

    if(!scripts\mp\utility\weapon::isenvironmentweapon(var_5.basename) || scripts\engine\utility::cointoss())
      var_1.shieldbullethits++;

    var_19 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_1, var_2));

    if(var_1.shieldbullethits >= level.riotshieldxpbullets && var_19) {
      var_20 = 1.0;

      if(self.recentshieldxp > 4)
        var_20 = 1.0 / self.recentshieldxp;

      var_21 = scripts\mp\rank::getscoreinfovalue("_encstr_A94A0E37435AB2B123AFC816B5C27656");
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A94A0E37435AB2B123AFC816B5C27656", var_1.currentweapon, var_21 * var_20);
      var_1 thread giverecentshieldxp();
      var_1.shieldbullethits = 0;
    }
  }

  var_22 = isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == var_1;

  if(var_9 &level.idflags_shield_explosive_impact) {
    var_1.forcehitlocation = "_encstr_8BBA05185F8B99";

    if(!(var_9 &level.idflags_shield_explosive_impact_huge)) {
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_8D1D194EA5BD1DA934A5CA63C8112CB60BECB20A899BBDC94C5691", var_3);
      var_3 = 0;
    }
  } else if(var_9 &level.idflags_shield_explosive_splash) {
    var_1.forcehitlocation = "_encstr_8BBA05185F8B99";

    if(var_1 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var_12))
      var_3 = var_1.maxhealth;
  } else if(istrue(var_2.should_take_damage))
    return var_3;
  else
    return 0;

  if(var_4 == "_encstr_8DED0A21C79B660BC7588981" && scripts\mp\riotshield::isriotshield(var_5.basename))
    var_1 stunplayer(0.0);

  return var_3;
}

filterdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!var_3)
    return "_encstr_919F09842D8885B5C29D56";

  if(isDefined(level.hostmigrationtimer))
    return "_encstr_B8311963FDE3DAD38864E7AB8CEC320C4891DBB77F621CEB193733";

  if(isDefined(level.validateattacker))
    var_1 = [[level.validateattacker]](var_1);
  else
    var_1 = scripts\mp\utility\damage::_validateattacker(var_1);

  if(!isDefined(var_1) && var_4 != "_encstr_87A10C9D24E997A01F21838F3D34")
    return "_encstr_A7C911587D4D777BAB38C979CDDBD6227FE835";

  var_2 = scripts\mp\utility\damage::_validatevictim(var_2);

  if(!isDefined(var_2))
    return "_encstr_AAF70EF46018C9622B51CB2F474DFA0D";

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    return "_encstr_ACC41A4159BB3DA689178B47C3AF79BF1EF22B3EA74FF39B99F36F47";

  if(isDefined(var_2.sessionteam) && var_2.sessionteam == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return "_encstr_856320031CF67569B54DD351F3178B909B015B0F42460AAEE6C7309F763921CBED0B";

  if(scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_8DEF0E30E63BA241CF8A8030326521BB")) {
    if(var_6 != "_encstr_81CC0586952C91" && var_6 != "_encstr_A6CC076A05751852B3") {
      if(var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
        return "_encstr_AAA62917A003C4E3532F7CF686199A8EC990D78762312F4AAB3595BE7835C2593070FF0B20D06F63AF7FDC";
    }
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_14201(var_0, var_2, var_4, var_5))
    return "_encstr_8A4518E0710B51CAC66A7B08B3E76B51BBED573B999B306EB31F";

  var_7 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" || var_1.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

  if(!level.teambased && var_7 && isDefined(var_1.owner) && var_1.owner == var_2) {
    if(var_4 == "_encstr_8D4E0A501FCB898912CB3FA3")
      var_2 scripts\mp\utility\damage::_suicide();

    return "_encstr_AAA30C13B8A1B0A3732B7EF4850B";
  }
}

logattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1))
    addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.owner) && isPlayer(var_1.owner) && (!isDefined(var_1.scrambled) || !var_1.scrambled))
    addattacker(var_0, var_1.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.secondowner) && isDefined(var_1.scrambled) && var_1.scrambled)
    addattacker(var_0, var_1.secondowner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_2) && isDefined(var_2.owner) && isDefined(var_2.owner.guid) && isPlayer(var_1.owner)) {
    var_10 = var_2.owner.team != var_0.team || level.friendlyfire == 1;

    if(var_10 && !istrue(var_2.owner._id_1407D) && !isDefined(self.attackerdata[var_2.owner.guid]))
      addattacker(var_0, var_2.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1))
    level.lastlegitimateattacker = var_1;

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3))
    var_1 thread scripts\mp\weapons::checkhit(var_3, var_0);

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3) && var_1 != var_0) {
    var_1 thread scripts\mp\events::damagedplayer(self, var_4);
    var_0.attackerposition = var_1.origin;
  } else
    var_0.attackerposition = undefined;
}

logattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2))
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.owner) && (!isDefined(var_2.scrambled) || !var_2.scrambled)) {
    var_2 = var_2.owner;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.secondowner) && isDefined(var_2.scrambled) && var_2.scrambled) {
    var_2 = var_2.secondowner;
    addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_2))
    level.lastlegitimateattacker = var_2;

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_10) && var_2 != var_0)
    var_0.attackerposition = var_2.origin;
  else
    var_0.attackerposition = undefined;
}

loggrenadedata(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((issubstr(var_4, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF") || issubstr(var_4, "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")) && isDefined(var_0) && isDefined(var_1)) {
    var_6 = createheadicon(var_5);
    var_2.explosiveinfo = [];
    var_2.explosiveinfo["_encstr_92770B5218CB5697A9D5919D55"] = gettime();
    var_2.explosiveinfo["_encstr_84E80930977D21C752ACC5"] = var_0 getentitynumber();
    var_2.explosiveinfo["_encstr_95910F9B954D9B03AACDA7A29DDDE1BF13"] = 0;
    var_2.explosiveinfo["_encstr_ABEF0C7238ABA5EB991663492180"] = 0;
    var_2.explosiveinfo["_encstr_886D0AC60D85B4375AB4631B"] = 0;
    var_2.explosiveinfo["_encstr_BE010B1620B0A3928D2F171B79"] = 0;
    var_2.explosiveinfo["_encstr_84970E15FB02F23FA64EC2D8F2FA30DB"] = 0;
    var_2.explosiveinfo["_encstr_AF94131785B4F053738A3D8392031F80CFC3ABB134"] = 0;
    var_2.explosiveinfo["_encstr_AC20072B9FA9487832"] = var_6;
    var_7 = issubstr(var_5.basename, "_encstr_975606C28B2F2F26");

    if(var_1 != var_2) {
      if((issubstr(var_5.basename, "_encstr_AC190457A459") || issubstr(var_5.basename, "_encstr_871A158393BD87B4AD4B8E5EF52B3CE01BDE9B5A672BAF") || issubstr(var_5.basename, "_encstr_8E230A8D8D2C97D6DBC9B2D7")) && isDefined(var_0.owner)) {
        var_2.explosiveinfo["_encstr_95910F9B954D9B03AACDA7A29DDDE1BF13"] = var_0.owner == var_2;
        var_2.explosiveinfo["_encstr_ABEF0C7238ABA5EB991663492180"] = isDefined(var_0.wasdamaged);
        var_2.explosiveinfo["_encstr_886D0AC60D85B4375AB4631B"] = isDefined(var_0.waschained);
        var_2.explosiveinfo["_encstr_BEE516BB98B8546AA96F17CDED8153E103D0170391F09CC2"] = isDefined(var_0.wasdamagedfrombulletpenetration);
        var_2.explosiveinfo["_encstr_BE010B1620B0A3928D2F171B79"] = 0;
      }

      if(isDefined(var_1.lastgrenadesuicidetime) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_7)
        var_2.explosiveinfo["_encstr_AF94131785B4F053738A3D8392031F80CFC3ABB134"] = 1;
    }

    if(var_7) {
      var_2.explosiveinfo["_encstr_BE010B1620B0A3928D2F171B79"] = isDefined(var_0.iscooked);
      var_2.explosiveinfo["_encstr_84970E15FB02F23FA64EC2D8F2FA30DB"] = isDefined(var_0.threwback);
    }

    var_2.explosiveinfo["_encstr_885A0AE63AB4D8D6965A36D8"] = isDefined(var_0.isstuck) && var_0.isstuck == "_encstr_88BF06FD784A6393";
    var_2.explosiveinfo["_encstr_9A3C1277510382DB99EBC4CF40A014FBFA83F383"] = isDefined(var_0.isstuck) && var_0.isstuck == "_encstr_ACFC091AE8AB2FCBE15119";

    if(isPlayer(var_1) && var_1 != self && scripts\mp\utility\game::getgametype() != "_encstr_8D6D0768D4AB5D8DCA")
      updateinflictorstat(var_0, var_1, var_6);
  }
}

handledamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" || var_1.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

  if(var_11 && isDefined(var_1.gunner))
    var_12 = var_1.gunner;
  else if(isDefined(var_1) && isDefined(var_1.owner))
    var_12 = var_1.owner;
  else
    var_12 = var_1;

  var_13 = "_encstr_A5AE098ADB583E0AF7A5AB";

  if(isDefined(var_12) && var_12 != var_2 && var_3 + var_8 + var_9 > 0 && (!isDefined(var_6) || var_6 != "_encstr_A32D07CFD14BAA94D0")) {
    var_14 = !var_2 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var_2) && var_3 >= var_2.health;

    if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743") && isDefined(var_2.inlaststand) && var_2.inlaststand == 1 && !var_2.hasshownlaststandicon) {
      var_2.hasshownlaststandicon = 1;
      var_13 = "_encstr_BEF30DDC48FB9D412091E803212033";
    } else if(isPlayer(var_2) && var_2 _meth_87D3())
      var_13 = "_encstr_BEF30DDC48FB9D412091E803212033";
    else if(istrue(var_2._id_133EF) && !armorvest_wasbroke(var_1))
      var_13 = "_encstr_994F100430B86B13BFE7BB3B15509BB5D83B";
    else if(istrue(var_2.isjuggernaut))
      var_13 = "_encstr_9A1B0E432D3A9AEA76B35939DC855DA3";
    else if(var_2 scripts\mp\heavyarmor::hasheavyarmor() || var_2 scripts\mp\heavyarmor::hasheavyarmorinvulnerability())
      var_13 = "_encstr_A5D20E0DD2E8C2C9D6F627D09516675E";
    else if(var_7 &level.idflags_stun)
      var_13 = "_encstr_9B1905D3B92BF0";
    else if(scripts\mp\utility\damage::istacticaldamage(var_5, var_4) && var_2 scripts\mp\utility\perk::_hasperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA") && !var_2 scripts\mp\utility\perk::_hasperk("_encstr_BD0612A92DDD4809EBA3C64B5BC73001B58F350B"))
      var_13 = "_encstr_8D760DB8F77343CF62BEB7E3D01013";
    else if(var_2 scripts\mp\utility\perk::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19") && !scripts\mp\utility\damage::damage_should_ignore_blast_shield(var_1, var_2, var_5, var_4, var_0, var_6))
      var_13 = "_encstr_A3450F0B299309911663F8F8EA2C4B8D0B";
    else if(scripts\mp\utility\damage::hashealthshield(var_2))
      var_13 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(armorvest_wasbroke(var_1) && var_2 scripts\mp\utility\perk::_hasperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32"))
      var_13 = "_encstr_9A8218CA430491F6E587B5B80510C86B2742CF7F99AB1B9DF7B2";
    else if(armorvest_washit(var_1) && var_2 scripts\mp\utility\perk::_hasperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32"))
      var_13 = "_encstr_B45E1308B3C03EA3D9985BA321231B37C02DBB8D31";
    else if(var_8 > 0 && var_2 scripts\mp\utility\perk::_hasperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32"))
      var_13 = "_encstr_B45E1308B3C03EA3D9985BA321231B37C02DBB8D31";
    else if(var_8 == 0 && var_2 scripts\mp\utility\perk::_hasperk("_encstr_823218E6832B1B96C2B1A3E5BE989CFACDB2270ECAB9A3A5B956") && (var_2 issupersprinting() || var_2 issprintsliding()))
      var_13 = "_encstr_BE060EE44BE9336D43908F9B88182E1A";
    else if(armorvest_wasbroke(var_1))
      var_13 = "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F";
    else if(helmet_wasbroke(var_1))
      var_13 = "_encstr_815B14691FFB8BE8A4957953FD99C03353ABD58BD7D2";
    else if(armorvest_washit(var_1))
      var_13 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(helmet_washit(var_1))
      var_13 = "_encstr_8CFE0FD86310AC2F89689A9350536FE4A8";
    else if(var_8 > 0)
      var_13 = "_encstr_A7CA0E78BC497703A3606DD843979453";
    else if(istrue(var_2.adrenalinepoweractive))
      var_13 = "_encstr_A6EC0EF149031025DB5AC8D1324FE8F8";
    else if(var_2 scripts\mp\utility\game::isspawnprotected() && var_10 && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_5))
      var_13 = "_encstr_994F100430B86B13BFE7BB3B15509BB5D83B";

    var_15 = scripts\engine\utility::isbulletdamage(var_4);
    var_16 = scripts\engine\utility::ter_op(var_15 && scripts\mp\utility\weapon::isprimaryweapon(var_5), "_encstr_A9950FF76456783587DB7983E3137DC8AF", "_encstr_A5AE098ADB583E0AF7A5AB");
    var_17 = 0;

    if(var_13 == "_encstr_9A8218CA430491F6E587B5B80510C86B2742CF7F99AB1B9DF7B2") {
      var_17 = 1;

      if(var_16 == "_encstr_A9950FF76456783587DB7983E3137DC8AF")
        var_16 = "_encstr_BE991EC7F332100851AAB12B522A48DF3A43537B03AA68606B47B961FAEDE08E";
      else
        var_16 = "_encstr_8C1D182F40C986AA33CEE79ABDCBC256D0D8D7FF58A1D26217E6";
    } else if(var_13 == "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F") {
      var_17 = 1;

      if(var_16 == "_encstr_A9950FF76456783587DB7983E3137DC8AF")
        var_16 = "_encstr_879414B9A3C2B991C2938C6EE02795C2322C27ADB7C9";
      else
        var_16 = "_encstr_814B0EC3B18F08B59AB390C120D0B25E";
    }

    var_18 = !usetimeoverride(var_5) && scripts\mp\utility\damage::isheadshot(var_6, var_4, var_1);
    var_19 = 1;
    var_20 = var_4 == "_encstr_8DED0A21C79B660BC7588981";
    var_21 = "_encstr_B40101" + var_2 getentitynumber();
    var_22 = 0;

    if(!var_17 && usetimeoverride(var_5) && isDefined(var_12._id_122F1)) {
      foreach(var_24 in var_12._id_122F1) {
        if(isDefined(var_24[var_21]) && var_24[var_21]._id_122F0.size > 1)
          var_22 = 1;
      }
    }

    if(!var_20 && var_22) {
      if(var_14)
        var_20 = 1;
      else
        var_19 = 0;
    }

    if(var_19)
      var_12 thread scripts\mp\damagefeedback::updatedamagefeedback(var_13, var_14, var_18, var_16, var_20);
  }
}

lethalequipmentdamagemod(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, undefined, undefined, undefined, undefined, var_4);

  if(isDefined(var_0) && isDefined(var_0.damagedby))
    var_1 = var_0.damagedby;

  if(var_2 scripts\cp_mp\utility\damage_utility::isstuckdamagekill(var_7)) {
    if(var_2 scripts\mp\utility\killstreak::isjuggernaut())
      var_3 = min(300, var_3);
    else
      var_3 = var_2.maxhealth + scripts\engine\utility::ter_op(isDefined(self.br_armorhealth), self.br_armorhealth, 0);
  }

  if(isDefined(var_5) && var_5 != "_encstr_A1ED0BA9FF84562B60BA073E83") {
    if(var_2 != var_1 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_8C8D08671D451291C849" && var_2.lastspawntime + 3500 > gettime() && isDefined(var_2.lastspawnpoint) && distance(var_0.origin, var_2.lastspawnpoint.origin) < 500)
      var_3 = 0;
  }

  if(isDefined(level._id_132A4))
    var_3 = var_3 * [[level._id_132A4.removelinkdamagemodifieronlaststand]](var_0);

  loggrenadedata(var_0, var_1, var_2, var_3, var_5, var_6);
  var_1 scripts\common\utility::_id_13E0A(level._id_11B31, scripts\mp\utility\weapon::getweaponrootname(var_6), "_encstr_B2BE0788BAF573592F", min(var_2.health, var_3), -1, var_6);
  return var_3;
}

playerkilled_initdeathdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, var_7, undefined, undefined, undefined, var_4);
  var_12.hitloc = var_8;
  var_12.psoffsettime = var_9;
  var_12.deathanimduration = var_10;
  var_12.isfauxdeath = var_11;

  if(var_5 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    var_12.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(var_1);

  var_12.dokillcam = 0;
  var_12.dofinalkillcam = 1;
  var_12.killcamentity = undefined;
  var_12.killcamentityindex = -1;
  var_12.killcamentitystarttime = 0;
  var_12.inflictoragentinfo = undefined;
  var_12.killcamentstickstovictim = undefined;
  var_12.isfriendlyfire = undefined;
  var_12.primaryweapon = undefined;
  var_12.lifeid = undefined;
  var_12.attackerentnum = undefined;
  var_12.iskillstreakweapon = undefined;
  var_12.weaponfullstring = undefined;
  var_12.isnukekill = 0;
  var_12.deathscenetimesec = getdvarfloat("_encstr_8B6D15A0462287B1451A808A97E3C713C83B9EFBFB982D", 1.75);
  var_12.deathscenetimems = int(var_12.deathscenetimesec * 1000);
  var_12.deathtime = gettime();
  var_12.enemy_monitor_trialending = undefined;
  return var_12;
}

playerkilled_parameterfixup(var_0) {
  if(isDefined(var_0.objweapon)) {}

  if(scripts\mp\utility\game::gamehasneutralcrateowner(scripts\mp\utility\game::getgametype())) {
    if(var_0.victim != var_0.attacker && var_0.meansofdeath == "_encstr_8D4E0A501FCB898912CB3FA3") {
      var_0.inflictor = var_0.victim;
      var_0.attacker = var_0.victim;
      var_0.meansofdeath = "_encstr_AB590C99ED78875F650F3951034D";
      var_0.objweapon.basename = "_encstr_8BBA05185F8B99";
      var_0.hitloc = "_encstr_8BBA05185F8B99";
      var_0.victim.attackers = [];
    }
  }

  if(var_0.victim == var_0.attacker && var_0.meansofdeath == "_encstr_8D4E0A501FCB898912CB3FA3")
    var_0.meansofdeath = "_encstr_AB590C99ED78875F650F3951034D";

  if(var_0.objweapon.basename == "_encstr_8BBA05185F8B99") {
    if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.baseweapon))
      var_0.objweapon.basename = var_0.inflictor.baseweapon;
  }

  var_0.victim playerkilled_fixupattacker(var_0);

  if(scripts\mp\utility\damage::isheadshot(var_0.hitloc, var_0.meansofdeath, var_0.attacker))
    var_0.meansofdeath = "_encstr_87280E1FB705D168313D1FD197B1A799";

  if(var_0.isfauxdeath) {
    var_0.dokillcam = 0;
    var_0.deathanimduration = var_0.victim playerforcedeathanim(var_0.inflictor, var_0.meansofdeath, var_0.objweapon, var_0.hitloc, var_0.direction_vec);
  }
}

playerkilled_fixupattacker(var_0) {
  if(isDefined(level.validateattacker))
    var_0.attacker = [[level.validateattacker]](var_0.attacker);
  else
    var_0.attacker = scripts\mp\utility\damage::_validateattacker(var_0.attacker);

  var_1 = 0;

  if(!isDefined(var_0.attacker))
    var_1 = 1;
  else if(isDefined(var_0.attacker.classname) && (var_0.attacker.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_0.attacker.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    var_1 = 1;
  else if(var_0.attacker == var_0.victim)
    var_1 = 1;

  if(var_1) {
    var_2 = undefined;

    if(isDefined(var_0.victim.attackers) && self.attackers.size > 0) {
      foreach(var_4 in var_0.victim.attackers) {
        if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_4))) {
          continue;
        }
        if(!isDefined(var_0.victim.attackerdata[var_4.guid].damage)) {
          continue;
        }
        if(var_4 == var_0.victim || level.teambased && var_4.team == var_0.victim.team) {
          continue;
        }
        if(var_0.victim.attackerdata[var_4.guid].damage > 1 && !isDefined(var_2)) {
          var_2 = var_4;
          continue;
        }

        if(isDefined(var_2) && var_0.victim.attackerdata[var_4.guid].damage > var_0.victim.attackerdata[var_2.guid].damage)
          var_2 = var_4;
      }
    }

    if(!isDefined(var_2)) {
      if(isDefined(var_0.victim.debuffedbyplayers) && var_0.victim.debuffedbyplayers.size > 0) {
        var_6 = ["_encstr_A3030E6F0BBA9688DDE528418FBF80CF", "_encstr_AA830D5B0B32A731FF4BE57F38FD73", "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3", "_encstr_BDC9145E757AAF080F8FF0B1DF4A81FD021F45488DC3", "_encstr_A6E718F89D5F1A7BC1B347DF7B089DC99F56186D79C965E14031", "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E"];

        foreach(var_12, var_8 in var_6) {
          var_9 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_0.victim, var_8);

          if(isDefined(var_9) && var_9.size > 0) {
            for(var_10 = var_9.size - 1; var_10 >= 0; var_10--) {
              var_11 = var_9[var_10];

              if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_11))) {
                continue;
              }
              if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_11, var_0.victim))) {
                continue;
              }
              var_2 = var_11;

              if(!isDefined(var_0.victim.attackerdata) || !isDefined(var_0.victim.attackerdata[var_2.guid]))
                addattacker(var_0.victim, var_2, undefined, getcompleteweaponname(var_8), 0, undefined, undefined, undefined, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");

              break;
            }
          }

          if(isDefined(var_2)) {
            break;
          }
        }
      }
    }

    if(isDefined(var_2)) {
      var_0.attacker = var_2;
      var_0.attacker.assistedsuicide = 1;
      var_0.objweapon = var_0.victim.attackerdata[var_2.guid].objweapon;
      var_0.direction_vec = var_0.victim.attackerdata[var_2.guid].vdir;
      var_0.hitloc = var_0.victim.attackerdata[var_2.guid].shitloc;
      var_0.psoffsettime = var_0.victim.attackerdata[var_2.guid].psoffsettime;
      var_0.meansofdeath = var_0.victim.attackerdata[var_2.guid].smeansofdeath;
      var_0.damage = var_0.victim.attackerdata[var_2.guid].damage;
      var_0.primaryweapon = var_0.victim.attackerdata[var_2.guid].sprimaryweapon;

      if(istrue(var_0.victim._id_13749) && isDefined(var_0.victim.attackerdata[var_2.guid].inflictor))
        var_0.inflictor = var_0.victim.attackerdata[var_2.guid].inflictor;

      var_0.assistedsuicide = 1;
    }
  }

  if(isDefined(var_0.attacker)) {
    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_0.attacker.owner))
      var_0.attacker = var_0.attacker.owner;

    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" && isDefined(var_0.attacker.owner)) {
      if(isDefined(var_0.attacker.vehicle))
        var_0.attacker.vehicle notify("_encstr_9A220DB5A536C62B8C28B12C972B93", var_0.victim);

      var_0.attacker = var_0.attacker.owner;
    }

    if(isagent(var_0.attacker)) {
      if(isDefined(var_0.attacker.owner))
        var_0.attacker = var_0.attacker.owner;
    }

    if(isDefined(var_0.attacker.code_classname) && var_0.attacker.code_classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;

      if(!isfriendlyfire(var_0.victim, var_0.attacker) && var_0.attacker != var_0.victim)
        var_0.attacker notify("_encstr_863D0EC7CB53BE48750FF689B55D28F3");
    }
  }

  if(isDefined(var_0.inflictor) && !isPlayer(var_0.inflictor)) {
    if(!isDefined(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner))
        var_0.attacker = var_0.inflictor.owner;
    } else if(!isPlayer(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner))
        var_0.attacker = var_0.inflictor.owner;
    }
  }

  if(isDefined(var_0.attacker) && var_0.attacker != var_0.victim) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == var_0.victim)
      var_0.inflictor = var_0.attacker;
  }

  var_0.attacker.assistedsuicide = 0;
}

playerkilled_precalc(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_2.perkoutlined = 0;
  var_2.deathspectatepos = undefined;
  var_2.deathtime = var_0.deathtime;
  var_2.attacker = var_1;
  var_2.lastdeathpos = var_2.origin;
  var_2.lastdeathangles = var_2 getplayerangles();

  if(!isPlayer(var_3) && isDefined(var_3.primaryweapon))
    var_0.primaryweapon = var_3.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon()))
    var_0.primaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  else if(var_4.isalternate)
    var_0.primaryweapon = var_4.basename;
  else
    var_0.primaryweapon = undefined;

  var_0.lifeid = var_2.matchdatalifeindex;

  if(!isDefined(var_0.lifeid))
    var_0.lifeid = level.maxlives - 1;

  if(scripts\mp\utility\entity::isgameparticipant(var_1))
    var_0.attackerentnum = var_1 getentitynumber();
  else
    var_0.attackerentnum = -1;

  var_0.iskillstreakweapon = scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename);
  var_0.weaponfullstring = createheadicon(var_4);
  var_0.isfriendlyfire = isfriendlyfire(var_2, var_1);
  var_0.isnukekill = var_4.basename == "_encstr_A29408E6D5D6CAAF5B1C";
  var_0.enemy_monitor_trialending = scripts\mp\utility\player::unset_relic_trex(var_2);
}

playerkilled_sharedlogic_early(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0.damage;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.isfauxdeath;
  var_8 = var_0.hitloc;
  var_9 = var_0.direction_vec;

  if(scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_3) && isDefined(var_4) && var_4.basename == "_encstr_8BBA05185F8B99") {}

  var_2 notify("_encstr_8EB40E4C23415AC52951730BC8E2BDC3");
  scripts\mp\outline::outlinedisableinternalall(var_2);
  var_2 showuidamageflash();
  var_2 setblurforplayer(0, 0);
  scripts\mp\outofbounds::clearoob(var_2, 1);
  var_2 scripts\mp\equipment\molotov::_id_11CB6();
  var_2 scripts\mp\equipment\throwing_knife_mp::_id_13B52();
  var_2 scripts\cp_mp\killstreaks\nuke::_id_138DB();

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\utility\print::printgameaction("_encstr_AD75063D571AE108", var_2);

  var_2 launchshield(var_5, var_6);
  var_2 scripts\mp\riotshield::riotshield_clear();

  if(var_1 != var_2) {
    if(isDefined(var_1.petwatch)) {
      var_1 scripts\cp_mp\pet_watch::addkillcharge();

      if(var_6 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
        var_1 scripts\cp_mp\pet_watch::addexecutioncharge();
      else if(var_2 _id_125F6(var_6, var_3))
        var_1 scripts\cp_mp\pet_watch::bhasriotshieldattached();
    } else if(isDefined(var_2._id_12313))
      var_2 scripts\cp_mp\utility\callback_group::onplayerkilled(var_1);
  }

  if(var_6 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_81730F174029EBDB7923453D0A6B02BCB3", 1);

    if(isDefined(var_1.operatorcustomization.title) && var_1.operatorcustomization.title == "_encstr_BD0703AF7C")
      var_10 = "_encstr_83C70FB9B2F75410FA3FBF3917629893DB";
    else
      var_10 = "_encstr_A6D1118A0C36C0F2D3A91DC023F7D58C5A8860";

    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, var_10, undefined, 1.0);
  }

  var_11 = var_2 getcurrentweapon();

  if(!var_2 scripts\mp\utility\weapon::iskillstreakweapon(var_11)) {
    scripts\mp\weapons::savetogglescopestates();
    scripts\mp\weapons::savealtstates();
  }

  var_2 scripts\mp\equipment\nvg::savenvgstate();
  scripts\mp\utility\inventory::handleweaponchangecallbacksondeath();

  if(!var_7) {
    if(isDefined(var_2.endgame))
      scripts\mp\utility\player::restorebasevisionset(2);
    else {
      scripts\mp\utility\player::restorebasevisionset(0);
      var_2 thermalvisionoff();
    }
  } else {
    var_2.fauxdead = 1;
    var_2 vehiclepinonminimap(1);
    self notify("_encstr_AD75063D571AE108");
    self notify("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  }

  scripts\mp\perks\perks::updateactiveperks(var_3, var_1, var_2, var_5, var_6, var_4, var_8, var_9);
  scripts\mp\supers::updateactivesupers(var_3, var_1, var_2, var_5, var_6, var_4, var_8, var_9);
  scripts\mp\equipment\wristrocket::wristrocketcooksuicideexplodecheck(var_3, var_1, var_2, var_6, var_4);

  if(var_6 != "_encstr_87280E1FB705D168313D1FD197B1A799" && !var_0.isnukekill) {
    if(isDefined(level.custom_death_sound))
      [[level.custom_death_sound]](var_2, var_6, var_3);
    else if(var_6 != "_encstr_8DED0A21C79B660BC7588981")
      var_2 scripts\mp\utility\sound::playdeathsound(var_6);
  }

  if(isDefined(level.custom_death_effect))
    [[level.custom_death_effect]](var_2, var_6, var_3);

  if(var_6 != "_encstr_AB590C99ED78875F650F3951034D" && (scripts\mp\utility\entity::isaigameparticipant(var_2) || scripts\mp\utility\entity::isaigameparticipant(var_1)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_8ABD11AAA9893FC76098B0A3C31AC33F8D93B1"])) {
    var_12 = [[level.bot_funcs["_encstr_8ABD11AAA9893FC76098B0A3C31AC33F8D93B1"]]](var_1, var_3);

    if(isDefined(var_12)) {
      if(scripts\mp\utility\entity::isaigameparticipant(var_2))
        var_2 botmemoryevent("_encstr_AD75063D571AE108", var_0.weaponfullstring, var_12.origin, var_2.origin, var_12);

      if(scripts\mp\utility\entity::isaigameparticipant(var_1)) {
        var_13 = 1;

        if(isDefined(var_12.classname) && (var_12.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_12.helitype) || var_12.classname == "_encstr_8D8A07F05F6987BF4B" || var_12.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E"))
          var_13 = 0;

        if(var_13)
          var_1 botmemoryevent("_encstr_ABD70578F3D02C", var_0.weaponfullstring, var_12.origin, var_2.origin, var_2);
      }
    }
  }

  if((scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !istrue(var_2.hvtnorevive) && istrue(var_2.inlaststand))
    scripts\mp\laststand::ondeath(var_0);

  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(var_6 == "_encstr_87A10C9D24E997A01F21838F3D34" && var_2 scripts\mp\teamrevive::isvalidrevivetriggerspawnposition())
      var_2 scripts\mp\teamrevive::_id_13285();

    var_14 = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(!var_14)
      var_15 = var_2 scripts\mp\class::respawnitems_saveplayeritemstostruct();
    else
      var_15 = self.juggcontext;

    var_2 scripts\mp\class::respawnitems_assignrespawnitems(var_15);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB") {
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD");
      var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_82A71120EA74DD99472EF07507F380971DC280");

      if(istrue(level.br_prematchstarted) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
        _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyscorelaunchonly(self, "_encstr_8D510D83935F5EB81ADFD9353334C0");
    }
  }

  var_16 = scripts\engine\utility::ter_op(scripts\mp\utility\killstreak::isplayerkillstreak(var_2), var_2.playerproxyagent, var_2);

  if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3"))
    var_16 thread scripts\mp\weapons::dropscavengerfordeath(var_1, var_0.meansofdeath);

  var_16[[level.weapondropfunction]](var_1, var_6, undefined, var_5);

  if(!var_7) {
    var_2 scripts\mp\utility\player::updatesessionstate("_encstr_84670547C3E9F4");

    if(isPlayer(var_1))
      var_2 setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", var_1 getentitynumber());
    else if(isDefined(var_1.classname) && (var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
      var_2 setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", var_2 getentitynumber());
    else if(isagent(var_1)) {
      if(isDefined(var_1.asm) && var_1.asm.archetype == "_encstr_87E80E37DE63915AB2E4BED8EEF59893")
        var_2 setclientomnvar("_encstr_A71C17C0FAB9A758CBEC363FF5DFC06BDD12C8D022489710C3", -1);
    }
  }

  var_17 = istrue(var_2.fauxdead) && istrue(var_2.switching_teams);

  if(!var_17) {
    if(!isDefined(level._id_11C76) || [[level._id_11C76]](var_2))
      var_2 scripts\mp\playerlogic::removefromalivecount(0, "_encstr_AFAD0DB220A0D1F2A60F373B59C52A");
  }

  if(!isDefined(var_2.switching_teams)) {
    if(!istrue(level.ignorescoring) && !var_0.isfriendlyfire) {
      var_2 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");

      if(var_2.pers["_encstr_8E0607055DBFB3919A"] < 999) {
        var_2 scripts\mp\utility\stats::incpersstat("_encstr_8E0607055DBFB3919A", 1);
        var_2.deaths = var_2 scripts\mp\utility\stats::getpersstat("_encstr_8E0607055DBFB3919A");
        var_2 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8E0607055DBFB3919A", var_2.deaths, level.ignorekdrstats);
      }
    }
  }

  var_18 = var_6;

  if(isDefined(var_0.idflags) && var_0.idflags &level.idflags_penetration && !(var_0.idflags &level.ss_respawn)) {
    if(isDefined(var_1.bulletkillsinaframecount) && var_1.bulletkillsinaframecount == 0) {
      var_18 = "_encstr_8DA410A6F422FA058AE4A2A849822A29E99C";

      if(isPlayer(var_1)) {
        if(var_4 hasattachment("_encstr_B2601058F5783BF14B604173BBBA9DACEB3A")) {
          var_19 = scripts\mp\rank::getscoreinfovalue("_encstr_B4761161E5E5504DBB7AEB70A2F390687C74D1") * getdvarfloat("_encstr_8BC61D2BF650013FBBE8772B436771B15334F449179B49731F41C09D50155A", 2.0);
          var_1 thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_B4761161E5E5504DBB7AEB70A2F390687C74D1", var_19);
        } else
          var_1 thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_B4761161E5E5504DBB7AEB70A2F390687C74D1");
      }
    }
  } else if((var_4.basename == "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0" || var_4.basename == "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B") && var_0.hitloc == "_encstr_81CC0586952C91" || var_0.hitloc == "_encstr_A6CC076A05751852B3")
    var_18 = "_encstr_87280E1FB705D168313D1FD197B1A799";

  if(isDefined(var_0.inflictor) && (istrue(var_0.inflictor.vehicle_collision_getignoreevent) || istrue(var_0.inflictor.vehicle_collision_geteventdata)))
    var_18 = "_encstr_8D4E0A501FCB898912CB3FA3";

  if(level.gametype == "_encstr_B607038AAB") {
    var_20 = [];

    if(isDefined(var_2)) {
      var_21 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_2.team, var_2.squadindex);

      if(isDefined(var_21))
        var_20 = var_21;
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_22 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1.team, var_1.squadindex);

      if(isDefined(var_22) && var_2.team != var_1.team)
        var_20 = scripts\engine\utility::array_combine(var_22, var_20);
    }

    if(var_20.size > 0) {
      var_23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_14104(var_0), "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_18);

      if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0) || getdvarint("_encstr_A614141F9B6A09DE2311F1588BBF01D087F53FBF1852", 0))
        var_23 = _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_11BA8(var_0, var_23);

      obituary(var_2, var_1, var_4, var_23, var_20);
    }
  } else {
    var_24 = var_4;

    if(isDefined(var_18) && var_18 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" && (!isDefined(var_24) || nullweapon(var_24)))
      var_24 = getcompleteweaponname("_encstr_9B730F8FF59B6B7708120A15E860998365");

    var_23 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_14104(var_0), "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_18);
    obituary(var_2, var_1, var_24, var_23);
  }

  var_2 updatedeathdetails(var_2.attackers, var_2.attackerdata, var_1);
  var_2.lastbounty = scripts\mp\bounty::playergetbountypoints();
  var_2 scripts\mp\bounty::playerresetbountypoints();
  var_2 scripts\mp\bounty::playerresetbountystreak();
  var_2 thread scripts\mp\supers::handledeath();
  var_2 scripts\mp\battlechatter_mp::onplayerkilled(var_3, var_1, var_5, var_6, var_4, var_0.direction_vec, var_0.hitloc, var_0.psoffsettime, var_0.deathanimduration, var_0.lifeid);
  var_2 thread[[level.onplayerkilledcommon]](var_3, var_1, var_5, var_6, var_4, var_0.direction_vec, var_0.hitloc, var_0.psoffsettime, var_0.deathanimduration, var_0.lifeid, scripts\mp\utility\weapon::iskillstreakweapon(var_11));

  if(isai(var_2) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_96330A95DD7FB43840C92ACD"]))
    var_2 thread[[level.bot_funcs["_encstr_96330A95DD7FB43840C92ACD"]]](var_3, var_1, var_5, var_6, var_0.weaponfullstring, var_0.direction_vec, var_0.hitloc, var_0.psoffsettime, var_0.deathanimduration, var_0.lifeid);

  var_25 = (var_0.deathtime - var_2.spawntime) / 1000;

  if(isDefined(var_2.pers["_encstr_AD270D8B6A78E3E34BDF63A433CB83"])) {
    if(var_2.pers["_encstr_AD270D8B6A78E3E34BDF63A433CB83"] == 0 || var_25 < var_2.pers["_encstr_AD270D8B6A78E3E34BDF63A433CB83"])
      var_2.pers["_encstr_AD270D8B6A78E3E34BDF63A433CB83"] = var_25;
  }

  if(isDefined(var_2.pers["_encstr_AD270D8B6A78E3E34BDF63A433CB83"])) {
    if(var_2.pers["_encstr_A7A20CB1DE9BD9AC6EA3984B992B"] == 0 || var_25 > var_2.pers["_encstr_A7A20CB1DE9BD9AC6EA3984B992B"])
      var_2.pers["_encstr_A7A20CB1DE9BD9AC6EA3984B992B"] = var_25;
  }
}

playerkilled_logkill(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0.weaponfullstring;
  var_6 = var_0.meansofdeath;
  var_7 = var_0.lifeid;
  var_2 scripts\common\utility::_id_13E0A(level.heavydamageawardlaunchonly, var_1);

  if(!istrue(level.ignorescoring))
    var_2 scripts\common\utility::_id_13E0A(level._id_11B2D, var_7, var_1, var_0.damage, var_6, var_5, var_0.primaryweapon, var_0.hitloc, var_4);

  var_2 scripts\mp\analyticslog::logevent_path();
  var_2 scripts\mp\analyticslog::logevent_playerdeath(var_1, var_6, var_5);

  if(isPlayer(var_1))
    var_1 scripts\mp\analyticslog::logevent_playerkill(var_2, var_6, var_5);

  if(isPlayer(var_1) && var_1 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    var_8 = var_2.lastdroppableweaponobj;
    var_8 = scripts\mp\utility\weapon::mapweapon(var_8, var_3);
    var_9 = createheadicon(var_8);
    thread scripts\mp\gamelogic::trackleaderboarddeathstats(var_1, var_2, var_9, var_6);
    thread scripts\mp\gamelogic::trackattackerleaderboarddeathstats(var_1, var_2, var_5, var_6);
  }

  if(isDefined(level.matchrecording_logeventmsg) && isDefined(var_3) && isPlayer(var_3) && scripts\engine\utility::isbulletdamage(var_6)) {
    var_10 = var_3.origin - var_2.origin;
    var_11 = vectorNormalize((var_10[0], var_10[1], 0));
    var_12 = anglesToForward(var_2.angles);
    var_13 = vectorNormalize((var_12[0], var_12[1], 0));
    var_14 = clamp(var_13[0] * var_11[0] + var_13[1] * var_11[1], -1.0, 1.0);
    var_15 = acos(var_14);

    if(!isDefined(var_2._id_1338F))
      var_2._id_1338F = 0;

    if(var_15 > 75.0)
      var_2._id_1338F++;

    var_16 = 0.0;

    if(isDefined(var_2.engagementstarttime))
      var_16 = gettime() - var_2.engagementstarttime;

    if(!isDefined(var_2.nuke_hostmigration_waitlongdurationwithpause)) {
      var_2.nuke_hostmigration_waitlongdurationwithpause = 0;
      var_2.nuke_explposstruct = 0;
    }

    var_2.nuke_hostmigration_waitlongdurationwithpause = var_2.nuke_hostmigration_waitlongdurationwithpause + var_16;
    var_2.nuke_explposstruct++;
    var_2.engagementstarttime = undefined;
  }

  updatecombatrecordkillstats(var_1, var_2, var_6, var_4);
}

playerkilled_finddeathtype(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;

  if(var_2 isswitchingteams())
    return "_encstr_9AD91946CA2C3AD02A9707ACFA6E77B43A1B0D5AE69D15B22C6B6E";
  else if(!isPlayer(var_1) || isPlayer(var_1) && var_4 == "_encstr_87A10C9D24E997A01F21838F3D34")
    return "_encstr_833C15DF7F8F5B63F143392D0FAFBA369884FFEA61CC19";
  else if(var_1 == var_2 || !scripts\cp_mp\utility\player_utility::playersareenemies(var_1, var_2) && scripts\mp\utility\entity::isdronepackage(var_3))
    return "_encstr_B8BB12B16ABF0D703B51C1D34FDA505B6F424919";
  else if(var_0.isfriendlyfire && var_0.objweapon.basename != "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E" && !var_0.isnukekill)
    return "_encstr_8346176F85ABDBD39FE3B2B009A62AE7F823785C311DE335C2";
  else if(istrue(var_2.inlaststand))
    return "_encstr_8E96168C23E0F353DDD2035AFEAB932548B7142369983D2B";
  else
    return "_encstr_B82D118DE7AA51B8E44F20B0EFE69095B20E71";
}

playerkilled_handledeathtype(var_0) {
  var_1 = var_0.victim;
  var_0.deathtype = playerkilled_finddeathtype(var_0);

  switch (var_0.deathtype) {
    case "_encstr_9AD91946CA2C3AD02A9707ACFA6E77B43A1B0D5AE69D15B22C6B6E":
      handleteamchangedeath();
      break;
    case "_encstr_833C15DF7F8F5B63F143392D0FAFBA369884FFEA61CC19":
      handleworlddeath(var_0, var_0.attacker, var_0.lifeid, var_0.meansofdeath, var_0.hitloc);
      break;
    case "_encstr_B8BB12B16ABF0D703B51C1D34FDA505B6F424919":
      handlesuicidedeath(var_0.meansofdeath, var_0.hitloc);
      break;
    case "_encstr_8346176F85ABDBD39FE3B2B009A62AE7F823785C311DE335C2":
      handlefriendlyfiredeath(var_0.attacker, var_0.victim);
      break;
    case "_encstr_8E96168C23E0F353DDD2035AFEAB932548B7142369983D2B":
      handleinlaststanddeath(var_0);
      break;
    case "_encstr_B82D118DE7AA51B8E44F20B0EFE69095B20E71":
      handlenormaldeath(var_0.lifeid, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.meansofdeath, var_1, var_0.iskillstreakweapon, var_0);
      break;
    default:
      break;
  }
}

playerkilled_sharedlogic_late(var_0) {
  playerkilled_handlecorpse(var_0);
  setdeathtimerlength(var_0);
  var_1 = var_0.attacker;

  if(isDefined(var_1.owner))
    var_1 = var_1.owner;

  if(!isPlayer(var_1)) {
    var_0.dokillcam = 0;
    var_0.dofinalkillcam = 0;
  }

  playerkilled_killcamsetup(var_0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_down(var_0.attacker, var_0.victim, var_0.objweapon, var_0.deathtype, var_0.meansofdeath);

  thread scripts\cp\vehicles\vehicle_compass_cp::ondeath(var_0.inflictor, var_0.attacker, var_0.damage, var_0.damageflags, var_0.meansofdeath, var_0.objweapon, var_0.hitloc, var_0.attacker.modifiers);

  if(!scripts\mp\utility\game::runleanthreadmode() || getdvarint("_encstr_8CB927376C27D74EABB91B590B73BE8336B02F59C9E8A14E2BC246AFB0C68DDE77BEB1DB9DB62D8D1B", 1))
    playerkilled_logkill(var_0);
}

playerkilled_handlecorpse(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;
  var_5 = var_0.objweapon;
  var_2 setscriptablepartstate("_encstr_87200F3B5701DA983FC9634B70315162A5", "_encstr_BA19049F4B2D");
  scripts\cp_mp\vehicles\vehicle::vehicle_playerkilledbycollision(var_0);

  if(!isDefined(self.nocorpse) && !istrue(var_2._id_133C8))
    var_2.body = var_2 cloneplayer(var_0.deathanimduration, var_1);

  if(!isDefined(self.nocorpse) && !istrue(var_2._id_133C8) && isDefined(var_2.body)) {
    var_2.body.targetname = "_encstr_A3AA0E181930D3F313C0BFC003075BA3";

    if(var_0.isnukekill) {}

    enqueueweapononkillcorpsetablefuncs(var_1, var_2, var_3, var_5, var_4);
    var_2 thread callcorpsetablefuncs();

    if(var_0.isfauxdeath) {
      var_2 playerhide();
      var_2 setsolid(0);
    }

    if(!isDefined(var_2.switching_teams)) {
      if(isDefined(var_1) && isPlayer(var_1))
        thread scripts\mp\deathicons::adddeathicon(var_1, var_2.body, var_2, var_2.team, 5.0);

      var_6 = [];

      foreach(var_9, var_8 in level.players) {
        if(isDefined(var_2) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_8, var_2)) && var_8 scripts\mp\utility\perk::_hasperk("_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD"))
          var_6[var_9] = var_8;
      }

      if(var_6.size > 0)
        thread scripts\mp\deathicons::addenemydeathicon(var_2.body, var_2, var_6, getdvarfloat("_encstr_BA8F1B07CA396DBEDA4B3636D79359E0ED4E1DAFD26CF6B97D8E4BB62B"), 1);
    }

    var_2 thread _startragdoll(var_0.victim.body, var_0.meansofdeath, var_0.inflictor);
  } else if(isDefined(var_2.nocorpse) && !istrue(var_2._id_133C8)) {
    var_2.body = var_2 cloneplayer(var_0.deathanimduration);
    var_2.body hide(1);
  }

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    var_2.streaktype = scripts\mp\class::loadout_getplayerstreaktype(var_2.streaktype);

    if(scripts\mp\killstreaks\killstreaks::streaktyperesetsondeath(var_2.streaktype)) {
      if(!level.casualscorestreaks && !var_2 scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E")) {
        var_2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
        var_2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
      } else if(level.casualscorestreaks) {
        var_10 = scripts\mp\killstreaks\killstreaks::checkcasualstreaksreset();

        if(var_10) {
          var_2 scripts\mp\killstreaks\killstreaks::resetstreakpoints();
          var_2 scripts\mp\killstreaks\killstreaks::resetstreakavailability();
        }
      }
    }
  }
}

_startragdoll(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");

  if(getdvarint("_encstr_95E00AC99E7A9396D2A2A8A2", 0) && isDefined(var_1) && (var_1 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_1 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_1 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_1 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B"))
    var_0 _meth_87C0(1);

  var_3 = var_0 getcorpseanim();
  var_4 = 0.0;

  if(animisleaf(var_3))
    var_4 = getanimlength(var_3);

  var_5 = undefined;
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = _id_125F6(var_1, var_2);
  var_8 = undefined;
  var_9 = animhasnotetrack(var_3, "_encstr_8DD20EA40BA09F1B7D3EEA12A3CFCF57");
  var_10 = animhasnotetrack(var_3, "_encstr_88E316B9B510AF5BC80F2E08C2CFE75BD63C9914C7138353");
  var_11 = animhasnotetrack(var_3, "_encstr_ABF60BCDBDFA39C23B46BDB163");
  var_12 = animhasnotetrack(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C");

  if(isDefined(var_6)) {
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_6, self);

    if(var_11 || var_12) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var_0, var_6, var_8);
      var_0 setcorpsefalling(0);
      var_0.x1ops = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E7(var_6, var_8);
    }

    if(var_9 || var_10 || var_11 || var_12) {
      var_13 = scripts\engine\utility::ter_op(var_11 || var_12, 0, 1);
      var_14 = scripts\engine\utility::ter_op(var_10, var_4, var_4 + 3);
      thread playerkilled_deletecorpseoutofvehicle(var_0, var_6, var_8, var_14, var_13);
    }
  }

  if(var_1 != "_encstr_AA230E88FD4CD19DB3AF87A383CAD073" && !var_11) {
    var_5 = 0;

    if(var_12 && var_4 > 0.0) {
      var_15 = getnotetracktimes(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C")[0];
      var_5 = var_15 * var_4;
    }

    if(var_7)
      var_5 = 0;
  }

  if(isDefined(var_5)) {
    wait(var_5);

    if(!isDefined(var_0)) {
      return;
    }
    if(isDefined(var_6)) {
      var_0 thread any_rider_still_alive_at_seat(var_6, var_8, var_9, var_10, var_5, var_4);
      var_0 notify("_encstr_969415B185B91B951BEB19593659D1CAEBD8F6E438B9AC");
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_141CC(var_0, var_6, var_8);
    } else {
      if(!var_0 isragdoll()) {
        if(var_7)
          var_0 vehswitchseatbuttonPressed(var_2);
        else
          var_0 startragdoll();
      }

      var_0 thread adson(var_9, var_10, var_5, var_4);
    }
  }
}

adson(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(var_0 || var_1) {
    var_5 = var_3;

    if(var_1)
      var_3 = var_3 + 3;

    if(isDefined(var_2))
      var_5 = var_5 - var_2;

    wait(var_5);

    if(!isDefined(var_4)) {
      return;
    }
    var_4 delete();
  } else if(!scripts\mp\utility\game::isteamreviveenabled() && !isagent(self))
    var_4 setplayercorpsedone();
}

any_rider_still_alive_at_seat(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = getdvarint("_encstr_8AD318626693B1407F84B3983951A66BBA4A6E3AD53081F32092", 1);
  var_8 = !var_7;
  var_9 = getdvarint("_encstr_AA87151E7E831FD3F90FA8F8CB1C4C839A671DAB56BB23", 1);

  if(var_7) {
    if(!var_6 isragdoll())
      var_6 startragdoll(var_9);
  }

  var_10 = getdvarfloat("_encstr_B20816F3CE3307EAB35022AA30916B8BA8A366934CF967B3", 0.1);

  if(var_10 > 0)
    wait(var_10);

  if(isDefined(var_6)) {
    if(isDefined(var_6.x1ops) && isDefined(var_0)) {
      var_11 = (0, 0, 0);
      var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E7(var_0, var_1);
      var_11 = var_12.origin - var_6.x1ops.origin;
      var_13 = var_6.origin + var_11;
      var_14 = var_12.angles;
      var_6 getcovertacpoint(var_13, var_14);
    }

    var_6 unlink();

    if(var_8)
      var_6 startragdoll(var_9);

    var_6 thread adson(var_2, var_3, var_4, var_5);
  }
}

anim_offset(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  var_3 = var_0 getcorpseanim();
  var_4 = undefined;
  var_5 = getanimlength(var_3);
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = var_1 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_2) && isDefined(var_2.vehiclename);

  if(!var_7) {
    var_8 = animhasnotetrack(var_3, "_encstr_8DD20EA40BA09F1B7D3EEA12A3CFCF57");
    var_9 = animhasnotetrack(var_3, "_encstr_88E316B9B510AF5BC80F2E08C2CFE75BD63C9914C7138353");
    var_10 = animhasnotetrack(var_3, "_encstr_ABF60BCDBDFA39C23B46BDB163");
  } else {
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
  }

  if(isDefined(var_6)) {
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_6, self);

    if(var_10)
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linkseatcorpse(var_0, var_6, var_11);

    if(var_8 || var_9) {
      var_12 = scripts\engine\utility::ter_op(var_9, var_5, var_5 + 3);
      thread playerkilled_deletecorpseoutofvehicle(var_0, var_6, var_11, var_12);
    }
  }

  if(var_1 != "_encstr_AA230E88FD4CD19DB3AF87A383CAD073" && !var_10) {
    var_4 = 0;

    if(animhasnotetrack(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C")) {
      var_13 = getnotetracktimes(var_3, "_encstr_A6B50E7F1099CAFB7FFE960FED37326C")[0];
      var_4 = var_13 * var_5;
    }
  }

  if(var_7)
    var_4 = 0;

  if(isDefined(var_4)) {
    if(var_4 > 0)
      wait(var_4);

    if(!var_0 isragdoll()) {
      if(!var_7)
        var_0 startragdoll();
      else
        var_0 vehswitchseatbuttonPressed(var_2);
    }
  }

  if(var_8 || var_9) {
    if(!var_7) {
      var_14 = var_5;

      if(var_9)
        var_5 = var_5 + 3;

      if(isDefined(var_4))
        var_14 = var_14 - var_4;

      wait(var_14);
    }

    var_0 delete();
  } else if(!scripts\mp\utility\game::isteamreviveenabled())
    var_0 setplayercorpsedone();
}

playerkilled_deletecorpseoutofvehicle(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_969415B185B91B951BEB19593659D1CAEBD8F6E438B9AC");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_assignseatcorpse(var_0, var_1, var_2, var_4);
  var_1 scripts\engine\utility::_id_143B9(var_3, "_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0 delete();
}

_id_125F6(var_0, var_1) {
  if(var_0 != "_encstr_8D4E0A501FCB898912CB3FA3")
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  return 1;
}

playerkilled_killcamsetup(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.inflictor;
  var_4 = var_0.meansofdeath;
  var_5 = var_0.objweapon;
  var_6 = var_0.executionref;

  if(var_0.attacker.assistedsuicide || level.teambased && isDefined(var_1.team) && var_1.team == var_2.team) {
    var_0.dokillcam = 0;
    var_0.dofinalkillcam = 0;
  }

  if(!isDefined(var_0.killcamentity))
    var_0.killcamentity = var_2 scripts\mp\killcam::getkillcamentity(var_1, var_3, var_5, var_4);

  if(isDefined(var_0.killcamentity)) {
    var_0.killcamentityindex = var_0.killcamentity getentitynumber();
    var_0.killcamentitystarttime = var_0.killcamentity.birthtime;

    if(!isDefined(var_0.killcamentitystarttime))
      var_0.killcamentitystarttime = 0;
  }

  if(var_0.dokillcam) {
    var_2 scripts\mp\killcam::prekillcamnotify(var_1);

    if(isDefined(var_3) && isagent(var_3)) {
      var_0.inflictoragentinfo = spawnStruct();
      var_0.inflictoragentinfo.agent_type = var_3.agent_type;
      var_0.inflictoragentinfo.lastspawntime = var_3.lastspawntime;
    }
  }

  var_0.killcamentstickstovictim = var_4 == "_encstr_A1ED0BA9FF84562B60BA073E83" || var_4 == "_encstr_87280E1FB705D168313D1FD197B1A799" && isDefined(var_3) || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || isDefined(var_2) && isDefined(var_2.stuckbygrenade) && isDefined(var_3) && var_2.stuckbygrenade == var_3 || var_5.basename == "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1";

  if(!var_0.iskillstreakweapon)
    scripts\mp\killcam::setkillcamnormalweaponomnvars(var_5, var_4, var_3, var_6);

  if(level.recordfinalkillcam && var_0.dofinalkillcam) {
    if((!isDefined(level.disable_killcam) || !level.disable_killcam) && var_4 != "_encstr_AB590C99ED78875F650F3951034D" && !(!isDefined(var_1) || var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" || var_1 == var_2))
      scripts\mp\final_killcam::recordfinalkillcam(5.0, var_2, var_1, var_0.attackerentnum, var_3, var_0.killcamentityindex, var_0.killcamentitystarttime, var_0.killcamentstickstovictim, var_5, var_0.psoffsettime, var_4);
  }
}

playerkilled_deathscene(var_0) {
  var_1 = var_0.victim;
  var_1 endon("_encstr_BA350853C128FB939DB9");

  if(!var_0.isfauxdeath) {
    if(!isDefined(var_1.respawntimerstarttime))
      var_1.respawntimerstarttime = gettime() + var_0.deathscenetimems;

    wait(var_0.deathscenetimesec);

    if(var_0.dokillcam)
      var_0.dokillcam = !scripts\mp\final_killcam::skipkillcamduringdeathtimer(0.5);

    var_1 notify("_encstr_8D831549924785F861D46379F9D07944CFBA6053AA8F35");
  } else if(!isDefined(var_1.respawntimerstarttime))
    var_1.respawntimerstarttime = gettime();
}

playerkilled_killcam(var_0) {
  var_1 = var_0;
  var_2 = var_1.victim.deathtime;

  if(getdvarint("_encstr_8C94142646BB27F8F93BE060F705B68FA2E115A0DB12", 1) && isDefined(var_1.victim.watch_for_driver_spawned)) {
    var_1 = var_1.victim.watch_for_driver_spawned;
    var_1.victim.watch_for_driver_spawned = undefined;
    var_1.dokillcam = var_0.dokillcam;
    var_2 = var_1.deathtime;
  }

  var_1.victim endon("_encstr_BA350853C128FB939DB9");
  var_3 = var_1.victim;
  var_4 = var_1.attacker;
  var_5 = (gettime() - var_2) / 1000;

  if(isDefined(level._id_11C8B))
    [[level._id_11C8B]](var_1);

  if(!(isDefined(var_3.cancelkillcam) && var_3.cancelkillcam) && var_1.dokillcam && level.killcam && game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B" && !var_3 scripts\mp\utility\player::isusingremote() && !level.showingfinalkillcam) {
    var_6 = scripts\mp\playerlogic::timeuntilspawn(1);

    if(!isDefined(var_4) || !isDefined(var_4.pers))
      var_7 = [];
    else
      var_7 = var_4.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"];

    if(!istrue(level.disablecopycatloadout))
      var_3 thread startcopycatoption(var_4);

    var_8 = 1;
    var_3 scripts\mp\killcam::killcam(var_1.inflictor, var_1.inflictoragentinfo, var_1.attackerentnum, var_1.killcamentityindex, var_1.killcamentitystarttime, undefined, var_1.killcamentstickstovictim, var_1.objweapon, var_5, var_1.psoffsettime, var_6, scripts\mp\gamelogic::timeuntilroundend(), var_4, var_3, var_1.meansofdeath, var_7, var_8);

    if(!istrue(level.disablecopycatloadout))
      var_3 thread stopcopycatoption();

    if(isDefined(level._id_12075))
      [[level._id_12075]]();
  }
}

playerkilled_spawn(var_0) {
  if(isDefined(level._id_11C7A) && [[level._id_11C7A]](var_0, 1)) {
    return;
  }
  var_1 = var_0.victim;
  var_1 endon("_encstr_BA350853C128FB939DB9");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0.attacker;
  var_1 resetplayervariables();
  var_1 resetplayeromnvarsonspawn();

  if(isDefined(var_2))
    var_1.lastattacker = var_2;
  else
    var_1.lastattacker = undefined;

  var_1.wantsafespawn = 0;

  if(game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B") {
    if(!level.showingfinalkillcam) {
      var_1 scripts\mp\utility\player::updatesessionstate("_encstr_84670547C3E9F4");
      var_1 scripts\mp\utility\player::clearkillcamstate();
    }

    return;
  }

  if(scripts\mp\class::isvalidclass(var_1.class))
    var_1 thread scripts\mp\playerlogic::spawnclient();
}

playerkilled_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_2 endon("_encstr_BA350853C128FB939DB9");

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    return;
  }
  var_12 = var_2 playerkilled_initdeathdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  playerkilled_parameterfixup(var_12);
  playerkilled_precalc(var_12);
  playerkilled_sharedlogic_early(var_12);
  playerkilled_handledeathtype(var_12);
  playerkilled_sharedlogic_late(var_12);
  playerkilled_deathscene(var_12);
  playerkilled_killcam(var_12);
  playerkilled_spawn(var_12);
}

isswitchingteams() {
  if(isDefined(self.switching_teams))
    return 1;

  return 0;
}

isteamswitchbalanced() {
  var_0 = scripts\mp\teams::countplayers();
  var_0[self.leaving_team]--;
  var_0[self.joining_team]++;
  return var_0[self.joining_team] - var_0[self.leaving_team] < 2;
}

isfriendlyfire(var_0, var_1) {
  if(!level.teambased)
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!isPlayer(var_1) && !isDefined(var_1.team))
    return 0;

  if(var_0.team != var_1.team)
    return 0;

  if(var_0 == var_1)
    return 0;

  return 1;
}

killedself(var_0) {
  if(!isPlayer(var_0))
    return 0;

  if(var_0 != self)
    return 0;

  return 1;
}

handleteamchangedeath() {
  if(!level.teambased) {
    return;
  }
  if(self.joining_team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || !isteamswitchbalanced()) {
    scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A68209DFE7B79AEC5BF76E");
    scripts\mp\utility\stats::incpersstat("_encstr_A68209DFE7B79AEC5BF76E", 1);
  }

  if(isDefined(level.onteamchangedeath))
    [[level.onteamchangedeath]](self);
}

handleworlddeath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.victim;
  var_5.deathspectatepos = var_5.origin;

  if(!isDefined(var_1)) {
    return;
  }
  scripts\mp\events::playerworlddeath(var_1, var_3);

  if(!isDefined(var_1.team) || var_1.team == "_encstr_A7A408B9CA5D1D4E2C63") {
    handlesuicidedeath(var_3, var_4);
    return;
  }

  if(level.teambased && var_1.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(var_1) || isagent(var_1)) && var_1.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      if(!level.gameended)
        [[level.onnormaldeath]](self, var_1, var_2, var_3);
    }
  }

  if(isagent(var_1))
    var_0.dokillcam = 1;
}

handlesuicidedeath(var_0, var_1) {
  scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A68209DFE7B79AEC5BF76E");
  scripts\mp\utility\stats::incpersstat("_encstr_A68209DFE7B79AEC5BF76E", 1);
  var_2 = scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_95E7116E5DD28D9623590EB79637A336ED6EB9");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_2);

  if(scripts\mp\weapons::grenadeheldatdeath() && var_0 == "_encstr_AB590C99ED78875F650F3951034D" && var_1 == "_encstr_8BBA05185F8B99")
    self.lastgrenadesuicidetime = gettime();

  if(isDefined(level.onsuicidedeath))
    [[level.onsuicidedeath]](self);

  self.suicidespawndelay = 1;

  if(isDefined(self.friendlydamage))
    self.playersetarenaomnvarwithloadout = 1;
}

handlefriendlyfiredeath(var_0, var_1) {
  if(scripts\mp\utility\game::isteamreviveenabled() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level thread scripts\mp\teamrevive::spawnrevivetrigger(var_1, var_1, "_encstr_AA7414CDCABBFAE8935A763B5939BEE6E0C2BBE659C8", "_encstr_AB590C99ED78875F650F3951034D");

  var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_8B8009D156B06BDA5A63B1");
  var_0.pers["_encstr_AA9C0A1555B798EF648228C8"] = var_0.pers["_encstr_AA9C0A1555B798EF648228C8"] + 1.0;

  if(scripts\mp\tweakables::gettweakablevalue("_encstr_8AEF05472BC2D6", "_encstr_A64512E8CA58AD6D4BB136C1DE4BE61D36F69BCD")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("_encstr_ABD70578F3D02C");
    scripts\mp\gamescore::_setplayerscore(var_0, scripts\mp\gamescore::_getplayerscore(var_0) - var_2);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }
  var_3 = var_0 scripts\mp\playerlogic::teamkilldelay();

  if(var_3 > 0) {
    var_0.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 1;
    var_0 notify("_encstr_835E111B0F57AAF772B2857B91972DCBC070DA");

    if(var_0 scripts\mp\utility\player::isusingremote())
      var_0 thread scripts\mp\utility\damage::_id_13966();
    else
      var_0 thread scripts\mp\utility\damage::_id_13965();
  }

  if(level.friendlyfire == 4 && !istrue(var_0.hitfflimit) && var_0.pers["_encstr_AA9C0A1555B798EF648228C8"] >= level.maxallowedteamkills) {
    var_0.hitfflimit = 1;
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_8EE91F44E956C4718C9D4D418CE051BCB7A1DD8E51170851D2B86767FFDCD1F61B");
  }
}

handleinlaststanddeath(var_0) {
  var_1 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB";

  if(!istrue(var_0.victim.disable_killcam))
    var_0.dokillcam = 1;

  if(!var_0.iskillstreakweapon)
    var_0.attacker thread scripts\mp\utility\points::giveunifiedpoints("_encstr_92AE10AD275BC3CE4E047725C0377812A010", var_0.objweapon, undefined, undefined, var_0.victim);

  if(isDefined(self.watch_for_attack))
    self.watch_for_attack _id_125E3();

  if(isDefined(self.watch_for_attack) && var_0.attacker != self.watch_for_attack) {
    thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(self.watch_for_attack, self.watch_for_attack, 0, var_0.damageflags, self.watch_for_level_weapons_free, self.watch_for_player_enter_puddle_trigger, var_0.hitloc, self.watch_for_damage, self.watch_for_damage_on_trap, self.watch_for_damage_on_turret);
    self.watch_for_attack thread scripts\mp\rank::scoreeventpopup("_encstr_91BA0FB5D21BB1AF36DB37995AE4DACA8C");
  }

  if(var_1)
    handlenormaldeath(var_0.lifeid, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0.meansofdeath, self, var_0.iskillstreakweapon, var_0, 1);

  self.watch_for_attack = undefined;
  self.watch_for_level_weapons_free = undefined;
  self.watch_for_player_enter_puddle_trigger = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
}

handlenormaldeath_sounds(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = var_1;

  if(!isDefined(var_0.lastkillalertsoundtime)) {
    var_0.lastkillalertsoundtime = gettime();
    var_4 = 1;
  } else if(gettime() > var_0.lastkillalertsoundtime + 700) {
    var_0.lastkillalertsoundtime = gettime();
    var_4 = 1;
  }

  if(!scripts\engine\utility::isbulletdamage(var_2) || var_0 != var_3) {
    if(var_4 && !scripts\cp_mp\utility\game_utility::isrealismenabled())
      var_5 playsoundtoplayer("_encstr_AD35146B83EBB65AB1D8AF8563569C3AFAB8EA2DCAA3", var_0);
  } else if(var_2 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
    var_5 playsoundtoplayer("_encstr_88B01BF0378C501393197309AABA671BD7DB4050DB4B28CFBB31F78102", var_1);
    var_5 playsoundtoplayer("_encstr_8C69178993738990ABEF7B7BE8D6984D17DAE1116AD73388C3", var_0);

    if(var_4)
      var_5 playsoundtoplayer("_encstr_A7B112E3FBC90B6829573B50BD04813752375529", var_0);

    var_5 playsoundtoteam("_encstr_8DB01B26BAC68DACD1EB2DB683B0D81DEBD095858CDC43F63AD7CDE036", var_1.team, var_1);
    var_5 playsoundtoteam("_encstr_8DB01B26BAC68DACD1EB2DB683B0D81DEBD095858CDC43F63AD7CDE036", var_0.team, var_0);
  } else {
    var_5 playsoundtoteam("_encstr_AA1917D607EB432DE8F5161B5993E8FACCB49BC263F5DCE0B1", var_1.team);
    var_5 playsoundtoteam("_encstr_AA1917D607EB432DE8F5161B5993E8FACCB49BC263F5DCE0B1", var_0.team, var_0);

    if(var_4)
      var_5 playsoundtoplayer("_encstr_8C6C0E55704FEF130843A03F39E9234B", var_0);
  }

  if(isPlayer(var_1)) {
    if(var_2 != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      var_1 playlocalsound("_encstr_921012A70D0383A0A3294B5F90BB5F4AD3972B5C");

    var_1 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 2);
  }
}

handlenormaldeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" && var_2 == var_1)
    addattacker(var_5, var_1, var_2, var_3, var_7.damage, (0, 0, 0), var_7.direction_vec, var_7.hitloc, var_7.psoffsettime, var_4);

  var_7.dokillcam = 1;

  if(isai(var_5) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_920612633BE0DF1DC901B21A190F94733816F9E5"]))
    var_7.dokillcam = var_5[[level.bot_funcs["_encstr_920612633BE0DF1DC901B21A190F94733816F9E5"]]]();

  if(istrue(level.disable_killcam) || istrue(var_5.disable_killcam))
    var_7.dokillcam = 0;

  var_1 thread scripts\mp\events::killedplayer(var_0, self, var_3, var_4, var_2, var_7);
  _encstr_86F228DCC627961C47DC5EDA0EE5CEC2B6AC3AF20759CDF213397D8563E8EBADDE46CAEBCC3317B3DCB1::play_airport_success_vo(var_1);
  _encstr_A7232D8B3F68A4C33D63E6CA2BB8A71E38AB04F971886A76EEBBF95211E1E79360298D57CD60B25305B143CEB9C627::_id_12CBA(var_1);

  if(!istrue(level.disablestattracking)) {
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_1.modifiers)) {
      var_9 = var_1.modifiers["_encstr_87A205AF10734B"];
      var_10 = var_1.modifiers["_encstr_95A40617A8CBC38F"];
      var_11 = var_1.modifiers["_encstr_A2A406E139973007"];
    }

    var_5 thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkilled(var_2, var_1, var_7.damage, var_7.damageflags, var_4, var_3, var_7.hitloc, var_9, var_10, var_11);
    var_5.watch_for_driver_death = undefined;
    var_5.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"]++;

    if(var_4 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
      var_1 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_96D30A3468575BA3C307A128");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_96D30A3468575BA3C307A128", 1);
      var_1.headshots = var_1 scripts\mp\utility\stats::getpersstat("_encstr_96D30A3468575BA3C307A128");

      switch (weaponclass(var_3.basename)) {
        case "_encstr_965306392D3336B2":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A9E50C61184837F11940A8D573B7", 1);
          break;
        case "_encstr_BE1904DCDA9D":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A5A10D37B69D8459C223B91A7B1DDC", 1);
          break;
        case "_encstr_A1100738A33A638123":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_8F79114EEC0219019D5B99F84FA4DB796A93C6", 1);
          break;
        case "_encstr_BE0703A54C":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_B8C80DA3CBBC886D08712AF40878A3", 1);
          break;
        case "_encstr_850707F7E5833355B8":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A9BF1033C8B3CB5780894549F9A05CEF6503", 1);
          break;
        case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_922712C92F7B5E03686F7BDB6501B3F024F76B78", 1);
          break;
        case "_encstr_8D940738966ED1DB8D":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A2771083B4DC8EBD8D1256B019B91A7BE8DC", 1);
          break;
      }
    }

    if(isDefined(var_2) && istrue(var_2.isequipment)) {
      switch (var_2.equipmentref) {
        case "_encstr_8BBB0B9D41E718D9E922D8582A":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_97200ABE62CF3788B1E98242", 1);
          break;
        case "_encstr_8C450D955CD52D07D7DC2BB6A39587":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_88C90C37B26BA32B1ED2D263C6CD", 1);
          break;
        case "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_AC960D25770848B5A0E6995B628C56", 1);
          break;
        case "_encstr_82A70F2B3B73E33B472371FF21D7809DDF":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_AA730E6CD80BCBDA7B9C565A5A36D8E6", 1);
          break;
        case "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1":
        case "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B":
        case "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC":
        case "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_AAA91348B883F88B3303778FA5D05E67435F05290B", 1);
          var_1 scripts\cp_mp\pet_watch::begin_vo();
          break;
        case "_encstr_843D095F2B7D52B041D9A3":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_ACF908B7A2C0C318EC5A", 1);
          break;
        case "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_99560EF3B80573E58821B5933388EDCF", 1);
          break;
        case "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95":
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_93FE132BB8F73887B0A3647159D853874788726208", 1);
          break;
      }
    }
  }

  thread handlenormaldeath_sounds(var_1, var_5, var_4, var_2);
  var_12 = var_1;

  if(isDefined(var_1.commanding_bot))
    var_12 = var_1.commanding_bot;

  if(!istrue(var_8) && !isfriendlyfire(var_5, var_1)) {
    if(!istrue(level.ignorescoring)) {
      var_12 _id_125E3();

      if(isbehindmeleevictim(var_12, var_5)) {
        var_12 scripts\mp\utility\stats::incpersstat("_encstr_A940105B4B6363E6199CBD5B24B2865A3746", 1);
        var_5 scripts\mp\utility\stats::incpersstat("_encstr_83EA11A3FB9F6B40B8D58AD5A8E9956263152B", 1);
      }
    } else if(isDefined(level.prematchaddkillfunc))
      var_12[[level.prematchaddkillfunc]]();
  }

  if(!istrue(level.disablestattracking)) {
    self resetplayerconsecutivekills();

    if(isPlayer(var_1))
      var_1 increaseplayerconsecutivekills();
  }

  if(!istrue(var_12.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"]) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_3) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_3))) {
    if(!isDefined(var_12.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"]))
      var_12.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] = 1;
    else
      var_12.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"]++;

    if(var_12.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] > scripts\mp\weaponrank::reload_use_think()) {
      var_12.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"] = 1;
      var_12.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] = undefined;
      var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"] = undefined;
    } else {
      if(!isDefined(var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]))
        var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"] = [];

      var_13 = scripts\mp\utility\weapon::getweaponrootname(var_3);
      var_14 = 0;

      foreach(var_17, var_16 in var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]) {
        if(var_17 == var_13) {
          var_16.killcount++;
          var_14 = 1;
          break;
        }
      }

      if(!var_14) {
        var_16 = spawnStruct();
        var_16.killcount = 1;
        var_16.basename = var_3.basename;
        var_16._id_1213C = var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"].size;
        var_12.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"][var_13] = var_16;
      }
    }
  }

  var_18 = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];

  if(!istrue(level.ignorescoring) && (isalive(var_1) || isDefined(var_1.streaktype) && var_1.streaktype == "_encstr_B29108FB78F3394A7385")) {
    if(var_4 == "_encstr_8DED0A21C79B660BC7588981" && !var_1 scripts\mp\utility\killstreak::isjuggernaut() || var_1 scripts\mp\utility\killstreak::killshouldaddtokillstreak(var_3))
      var_1 registerkill(var_3, var_4, 1, var_6);

    if(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] > var_1 scripts\mp\utility\stats::getpersstat("_encstr_87F20E78EA85EF89E7449E053AC771BF"))
      var_1.pers["_encstr_87F20E78EA85EF89E7449E053AC771BF"] = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
  }

  var_1.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    if(!istrue(level.ignorescoring) && var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] > var_1 scripts\mp\persistence::statgetchild("_encstr_8C4606C9DBD5CD46", "_encstr_85CE0B9770B02C71A1760F06D2"))
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_85CE0B9770B02C71A1760F06D2", var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]);

    if(!istrue(level.ignorescoring) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      if(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] > var_1.bestlifetimekillstreak) {
        var_1 scripts\mp\playerstats_interface::setplayerstat(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"], "_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_85CE0B9770B02C71A1760F06D2");
        var_1.bestlifetimekillstreak = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
      }
    }
  }

  if(!var_6 && !scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_2) || scripts\mp\utility\points::unset_relic_doomslayer(var_3)) {
    var_1 thread scripts\mp\events::killeventtextpopup("_encstr_ABD70578F3D02C", 0);
    var_19 = undefined;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      var_19 = 100;

    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_ABD70578F3D02C", var_3, var_19, undefined, var_5);
    var_1 scripts\mp\bounty::bountyincreasestreak();
    var_1 scripts\mp\bounty::bountycollect(var_5.lastbounty, var_5.origin);

    if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F") && isDefined(var_1.hardlineactive) && var_1.hardlineactive["_encstr_A1F308589BCD96CD476E"] == 2)
      var_1 thread scripts\mp\utility\points::givestreakpointswithtext("_encstr_8CA910EFF003194391D09CD6AE696AD108F8", var_3, 1);
  }

  var_20 = scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_B8030F3F95EB6B583B40E7F3F0D0074367");

  if(var_1.currentweapon hasattachment("_encstr_95320FCEEA9BC159936DEB3339CA373D2F"))
    var_1 notify("_encstr_8DBB13C4AC76D2CDF593B23B59E69539161D5ADE37");

  if(isDefined(level.gunshipplayer) && level.gunshipplayer == var_1)
    level notify("_encstr_A2300A73174102F0ACDD6159", self);

  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_20);
  level notify("_encstr_8A1E178363162F2B39AF3BDB3AF5DA968DB1E61DC92B2C5BAF" + var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"], var_1);
  var_1 notify("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");

  if(istrue(var_1.inlaststand))
    var_1 thread scripts\mp\laststand::_id_1204F(var_7);

  if(isDefined(level.onnormaldeath) && (isDefined(var_1.pers) && var_1.pers["_encstr_8AEF05472BC2D6"] != "_encstr_AF8C0A1B6A1D6045925B4F7D") && !istrue(level.ignorescoring))
    [[level.onnormaldeath]](self, var_1, var_0, var_4, var_3, var_6);

  if(!var_1 scripts\mp\utility\player::isusingremote())
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, "_encstr_882A125B5A1BB1CC5AC9B6EB5A9BCC2C9BD1C9CB", undefined, 0.75);

  var_21 = undefined;

  switch (var_5.loadoutarchetype) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
      var_21 = "_encstr_827E1803CAC3A858A4942925894AA0106FB2DB49E2FF7B987F62";
      break;
  }

  if(isDefined(var_21))
    level thread scripts\mp\battlechatter_mp::saytoself(var_1, var_21, "_encstr_A69215E78C2B0E3FB43298309A8AFBC6A72D60D50A2FF1", 0.75);

  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != var_1) {
    if(gettime() - self.lastattackedshieldtime < 2500)
      self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
    else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000) {
      var_22 = vectorNormalize(anglesToForward(self.angles));
      var_23 = vectorNormalize(self.lastattackedshieldplayer.origin - self.origin);

      if(vectordot(var_23, var_22) > 0.925)
        self.lastattackedshieldplayer thread scripts\mp\gamescore::processshieldassist(self);
    }
  }

  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\gamescore::awardbuffdebuffassists(var_1, self);

  if(isDefined(self.attackers)) {
    foreach(var_25 in self.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(var_25))) {
        continue;
      }
      if(var_25 == var_1) {
        continue;
      }
      if(self == var_25) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      if(isDefined(self.watch_for_attack) && self.watch_for_attack == var_25) {
        continue;
      }
      var_26 = undefined;

      if(isDefined(self.attackerdata)) {
        var_27 = self.attackerdata[var_25.guid];

        if(isDefined(var_27))
          var_26 = var_27.objweapon;
      }

      var_28 = 0;

      if(self.attackerdata[var_25.guid].damage >= 35)
        var_28 = 1;

      if(self.attackerdata[var_25.guid].damage >= 70)
        var_28 = 2;

      var_25 thread scripts\mp\gamescore::processassist(self, var_26, var_28);

      if(var_25 scripts\mp\utility\perk::_hasperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072"))
        var_5 thread scripts\mp\perks\perkfunctions::setboominternal(var_25);
    }
  }

  if(isDefined(self.markedbyboomperk)) {
    foreach(var_25 in level.players) {
      if(var_25.team == self.team) {
        continue;
      }
      if(scripts\engine\utility::array_contains(self.attackers, var_25)) {
        continue;
      }
      if(scripts\engine\utility::array_contains_key(self.markedbyboomperk, var_25 scripts\mp\utility\player::getuniqueid()))
        var_25 thread scripts\mp\gamescore::processassist(self, var_3);
    }
  }

  if(level.teambased) {
    var_32 = undefined;
    var_33 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
      var_33 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

    if(istrue(var_33) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1) && isDefined(var_1.squadindex) && isDefined(var_1.team))
      var_32 = var_1.team + var_1.squadindex;
    else if(isDefined(var_1.team))
      var_32 = var_1.team;

    if(isDefined(var_32) && isDefined(level.uavmodels) && isDefined(level.uavmodels[var_32]) && level.uavmodels[var_32].size > 0) {
      var_34 = [];

      foreach(var_36 in level.uavmodels[var_32]) {
        if(isDefined(var_36) && isDefined(var_36.owner) && var_36.owner != var_1 && !scripts\engine\utility::array_contains(var_34, var_36.uavtype)) {
          var_37 = var_36.uavtype + "_encstr_829208718938D30A2E79";
          var_38 = undefined;

          if(!isDefined(var_36.carpunchcount))
            var_36.carpunchcount = 0;

          var_39 = scripts\engine\utility::ter_op(var_36.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", 15, 10);

          if(var_36.carpunchcount < var_39)
            var_36.owner thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, var_38, undefined, undefined, undefined, var_36.streakinfo);
          else
            var_36.owner thread scripts\mp\utility\points::sec_sys_struct_1(var_37, var_38);

          var_36.carpunchcount++;

          switch (var_36.uavtype) {
            case "_encstr_851904B59B34":
              var_36.owner scripts\mp\utility\stats::incpersstat("_encstr_8B2915B0848C805EAB3B33C3A741BF99799A3B48AAFC9B", 1);
              break;
            case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
              var_36.owner scripts\mp\utility\stats::incpersstat("_encstr_B2DD16FA5F91ABF789D599865740CDA9714118F0D9426433", 1);
              break;
          }

          var_34[var_34.size] = var_36.uavtype;
          scripts\cp\vehicles\vehicle_compass_cp::processuavassist(var_36.owner, var_36.uavtype);
          var_36.owner scripts\mp\utility\script::bufferednotify("_encstr_99851BD51C4685A3ACD7D5C29D7D0B6EDC4B3747D713BA333356C92B32");
          var_36.owner combatrecordkillstreakstat(var_36.uavtype);
        }
      }
    }

    if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
      foreach(var_42 in level.supportdrones) {
        if(level.teambased && var_42.team == var_1.team && var_42.owner != var_1) {
          if(isDefined(var_42.enemiesmarked) && isDefined(var_42.enemiesmarked[self getentitynumber()])) {
            var_42.owner thread scripts\mp\utility\points::giveunifiedpoints(var_42.streakinfo.streakname + "_encstr_829208718938D30A2E79");
            var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_1207C();
          }
        }

        if(var_42.helperdronetype == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
          if(var_1 != var_42.owner) {
            var_37 = var_42.streakinfo.streakname + "_encstr_829208718938D30A2E79";

            if(!isDefined(var_42.carpunchcount))
              var_42.carpunchcount = 0;

            if(var_42.carpunchcount < 10)
              var_42.owner thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, undefined, undefined, undefined, undefined, var_42.streakinfo);
            else
              var_42.owner thread scripts\mp\utility\points::sec_sys_struct_1(var_37);

            var_42.carpunchcount++;
            var_42.owner scripts\mp\utility\stats::incpersstat("_encstr_BA0316ADD2631BCD3A9CCAB05B34AA146514379B5ADCE837", 1);
            continue;
          }

          if(isDefined(var_42.owner) && var_1 == var_42.owner) {
            if(!istrue(var_1._id_12C3D)) {
              var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_A56327E8E4FAD8D0F576C6F689C263EBAD2D6363EBCD1BE4C2DA3163B291FAB237566B4B2BDC7DE698", 1);
              continue;
            }

            var_1._id_12C3D = undefined;
          }
        }
      }
    }

    _debug_rooftop_activesat::close_teleport_room_door(var_1, self);

    if(isDefined(var_1.team) && isDefined(level.activewpzones) && level.activewpzones.size > 0) {
      var_44 = level.activewpzones[0];
      var_45 = var_44.owner;
      var_46 = var_44.team;

      if(var_1.team == var_46 && var_1 != var_45) {
        if(istrue(var_5.wpdisorient) || istrue(var_5.wpburning)) {
          var_37 = "_encstr_9A97180F711CD39B39F740E792217A7BA208CB0971CF622A9040";

          if(!isDefined(var_44.carpunchcount))
            var_44.carpunchcount = 0;

          if(var_44.carpunchcount < 15)
            var_45 thread scripts\mp\utility\points::giveunifiedpoints(var_37, undefined, undefined, undefined, undefined, undefined, var_44.streakinfo);
          else
            var_45 thread scripts\mp\utility\points::sec_sys_struct_1(var_37);

          var_44.carpunchcount++;
          var_45 scripts\mp\utility\stats::incpersstat("_encstr_8E2427DA5AD863E63A27560BAD5D345A1DAC41D07B9B1CD0B7E4B75D9B694BD8D8DC826E37B4CD3A37", 1);
        }
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_B81B11BA2DFAB6A5C61B958CD73836852F56C9", self getentitynumber());
    var_1 setclientomnvar("_encstr_854418D573597C0F9938EA8226EF53B630C36A77E53043D7B4B2", gettime());
  }
}

_id_125E3() {
  var_0 = self;
  var_0 scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");

  if(var_0.pers["_encstr_8E8D0697EB01F243"] < 14999) {
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_8E8D0697EB01F243", 1);
    var_0.kills = var_0 scripts\mp\utility\stats::getpersstat("_encstr_8E8D0697EB01F243");
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8E8D0697EB01F243", var_0.kills, level.ignorekdrstats);
  }
}

callback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0);
}

launchshield(var_0, var_1) {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    if(isDefined(self.riotshieldmodel))
      scripts\mp\riotshield::riotshield_detach(1);

    if(isDefined(self.riotshieldmodelstowed))
      scripts\mp\riotshield::riotshield_detach(0);
  }
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.watch_for_driver_death = undefined;
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  self.killcountthislife = 0;
  self.intel_guys = 0;
  self._id_11BC2 = 0;
  self._id_1341B = 0;
  self.showplunderextracticonsinworld = 0;
  self.getanimsforplanefacing = undefined;

  if(!isDefined(self.chopper_watch_death))
    self._id_1202B = 0;

  self.vip_questthink_iconposition = undefined;
  self.vip_respawnplayer = undefined;
  self.vip_removequestinstance = undefined;
  self.vipbot_movesup = undefined;
  self.vip_playerremoved = undefined;
  self._id_1288A = undefined;
  self._id_1288B = undefined;
  self._id_1458D = undefined;
  self.numpropsperarea = undefined;
  self.weapon_xp_iw8_sh_dpapa12 = undefined;
  self._id_13BDC = undefined;
  self._id_1237B = undefined;
  self.cargo_truck_mg_addgunnerdamagemod = undefined;
  self._id_14072 = undefined;
  self.watch_for_attack = undefined;
  self.watch_for_damage = undefined;
  self.watch_for_damage_on_trap = undefined;
  self.watch_for_damage_on_turret = undefined;
  self._id_12A0C = undefined;
  self.get_tv_station_infil_rider_start_targetname = undefined;
  self._id_13B5B = undefined;
  scripts\mp\gameobjects::detachusemodels();
}

resetplayeromnvarsonspawn() {
  scripts\mp\playerlogic::resetuiomnvarscommon();
  self setclientomnvar("_encstr_A24213BAA57D63B466CAEBB5B41BD8BED8DEBA731D", 0);
  self setclientomnvar("_encstr_9BAB14D596FADCA1E4B0C137AC63BEF6B3954E8D2CF2", 0);
  self setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

hitlocdebug(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;

  if(!getdvarint("_encstr_A58711937A8A77FCA823D9378EAF30186825AF")) {
    return;
  }
  if(!isDefined(var_0.hitlocinited)) {
    for(var_6 = 0; var_6 < 6; var_6++)
      var_0 setclientdvar("_encstr_B8260BF3E81F843F1BB9E7E3D8" + var_6, "_encstr_B40101");

    var_0.hitlocinited = 1;
  }

  if(level.splitscreen || !isPlayer(var_0)) {
    return;
  }
  var_7 = 6;

  if(!isDefined(var_0.damageinfo)) {
    var_0.damageinfo = [];

    for(var_6 = 0; var_6 < var_7; var_6++) {
      var_0.damageinfo[var_6] = spawnStruct();
      var_0.damageinfo[var_6].damage = 0;
      var_0.damageinfo[var_6].hitloc = "_encstr_B40101";
      var_0.damageinfo[var_6].bp = 0;
      var_0.damageinfo[var_6].colorindex = 0;
    }

    var_0.damageinfocolorindex = 0;
    var_0.damageinfovictim = undefined;
  }

  for(var_6 = var_7 - 1; var_6 > 0; var_6--) {
    var_0.damageinfo[var_6].damage = var_0.damageinfo[var_6 - 1].damage;
    var_0.damageinfo[var_6].hitloc = var_0.damageinfo[var_6 - 1].hitloc;
    var_0.damageinfo[var_6].bp = var_0.damageinfo[var_6 - 1].bp;
    var_0.damageinfo[var_6].colorindex = var_0.damageinfo[var_6 - 1].colorindex;
  }

  var_0.damageinfo[0].damage = var_2;
  var_0.damageinfo[0].hitloc = var_3;
  var_0.damageinfo[0].bp = var_4 &level.idflags_penetration;

  if(isDefined(var_0.damageinfovictim) && var_0.damageinfovictim != var_1) {
    var_0.damageinfocolorindex++;

    if(var_0.damageinfocolorindex == var_5.size)
      var_0.damageinfocolorindex = 0;
  }

  var_0.damageinfovictim = var_1;
  var_0.damageinfo[0].colorindex = var_0.damageinfocolorindex;

  for(var_6 = 0; var_6 < var_7; var_6++) {
    var_8 = "_encstr_B14C0279" + var_5[var_0.damageinfo[var_6].colorindex];

    if(var_0.damageinfo[var_6].hitloc != "_encstr_B40101") {
      var_9 = var_8 + var_0.damageinfo[var_6].hitloc;

      if(var_0.damageinfo[var_6].bp)
        var_9 = var_9 + "_encstr_BE3B060441242849";

      var_0 setclientdvar("_encstr_B8260BF3E81F843F1BB9E7E3D8" + var_6, var_9);
    }

    var_0 setclientdvar("_encstr_936512DBA3FF82414DE990839748D9FAC9F8F547" + var_6, var_8 + var_0.damageinfo[var_6].damage);
  }
}

giverecentshieldxp() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_BDF9134F93EBB78AD3085AE25857FC7F6189D4F8A7");
  self endon("_encstr_BDF9134F93EBB78AD3085AE25857FC7F6189D4F8A7");
  self.recentshieldxp++;
  wait 20.0;
  self.recentshieldxp = 0;
}

updateinflictorstat(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0.alreadyhit) || !var_0.alreadyhit || !scripts\mp\utility\weapon::issinglehitweapon(var_2))
    scripts\mp\gamelogic::setinflictorstat(var_0, var_1, var_2);

  if(isDefined(var_0))
    var_0.alreadyhit = 1;
}

addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else
    var_0.attackerdata[var_1.guid].hitcount++;

  if(scripts\mp\utility\weapon::iscacprimaryweapon(var_3) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_3))
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;

  if(isDefined(var_9) && var_9 != "_encstr_8DED0A21C79B660BC7588981")
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;

  var_10 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "_encstr_B116071BCAD186858D")
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;

    if(var_10 == "_encstr_99C209E34FC743616118AB")
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
  }

  var_0.attackerdata[var_1.guid].damage = var_0.attackerdata[var_1.guid].damage + var_4;
  var_0.attackerdata[var_1.guid].weapon = createheadicon(var_3);
  var_0.attackerdata[var_1.guid].objweapon = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid].psoffsettime = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();
  var_0.attackerdata[var_1.guid].inflictor = var_2;
  var_0.attackerdata[var_1.guid]._id_11C8D = var_1 scripts\mp\events::registerhints(0, var_0, var_3, var_9, var_2);
  var_0.attackerdata[var_1.guid]._id_11C8E = var_1 scripts\mp\events::registerleveldataforvehicle(0, var_0, var_3, var_9, var_2);

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon))
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon()))
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  else
    var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

addattackerkillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isDefined(var_0.attackerdata[var_2.guid])) {
    var_0.attackers[var_2.guid] = var_2;
    var_0.attackerdata[var_2.guid] = spawnStruct();
    var_0.attackerdata[var_2.guid].damage = 0;
    var_0.attackerdata[var_2.guid].attackerent = var_2;
    var_0.attackerdata[var_2.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_2.guid].hitcount = 1;
  }

  var_0.attackerdata[var_2.guid].damage = var_0.attackerdata[var_2.guid].damage + var_1;
  var_0.attackerdata[var_2.guid].weapon = var_10;
  var_0.attackerdata[var_2.guid].vpoint = var_4;
  var_0.attackerdata[var_2.guid].vdir = var_3;
  var_0.attackerdata[var_2.guid].partname = var_8;
  var_0.attackerdata[var_2.guid].smeansofdeath = var_5;
  var_0.attackerdata[var_2.guid].attackerent = var_2;
  var_0.attackerdata[var_2.guid].lasttimedamaged = gettime();
  var_0.attackerdata[var_2.guid]._id_11C8D = 0;
  var_0.attackerdata[var_2.guid]._id_11C8E = 0;

  if(isDefined(var_2) && isPlayer(var_2) && !nullweapon(var_2 getcurrentprimaryweapon()))
    var_0.attackerdata[var_2.guid].sprimaryweapon = createheadicon(var_2 getcurrentprimaryweapon());
  else
    var_0.attackerdata[var_2.guid].sprimaryweapon = undefined;
}

resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

removeoldattackersovertime() {
  self endon("_encstr_B2BE0788BAF573592F");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.attackers)) {
    return;
  }
  for(;;) {
    var_0 = gettime();

    foreach(var_3, var_2 in self.attackers) {
      if(isDefined(var_2) && var_0 - self.attackerdata[var_3].lasttimedamaged < 2000) {
        continue;
      }
      self.attackers[var_3] = undefined;
      self.attackerdata[var_3] = undefined;
    }

    waitframe();
  }
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = gettime();
  callback_playerdamage_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

_id_12AA2(var_0, var_1, var_2, var_3) {
  if(_id_1331E(self)) {
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B2BE0788BAF573592F", var_1);

    if(!isDefined(var_0.isbecomingzombie))
      var_0.isbecomingzombie = var_1;
    else
      var_0.isbecomingzombie = var_0.isbecomingzombie + var_1;

    if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
      if(isPlayer(var_0)) {
        var_0 scripts\common\utility::_id_13E0A(level._id_11B31, scripts\mp\utility\weapon::getweaponrootname(var_3), "_encstr_B2BE0788BAF573592F", min(self.health, var_2), -1, var_3);
        scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_0, "_encstr_99F30B8C2CB50B7695887BB9CA", var_0 scripts\mp\utility\stats::getpersstat("_encstr_B2BE0788BAF573592F"));
      }
    }

    var_4 = scripts\mp\utility\weapon::mapweapon(var_3);
    var_5 = createheadicon(var_4);
    var_0 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_5, var_1, "_encstr_B6C00D57FF8B423FF199FBE77008E4");
  } else if(isDefined(level._id_12001))
    var_0[[level._id_12001]](var_1);
}

finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = int(min(var_2, self.health));

  if(isDefined(var_1) && isPlayer(var_1))
    _id_12AA2(var_1, var_13, var_2, var_5);
  else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_14 = var_0;

    if(isDefined(var_14.owner) && isPlayer(var_14.owner))
      _id_12AA2(var_14.owner, var_13, var_2, var_5);
  } else if(isDefined(var_0) && var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail()) {
    var_15 = var_0;

    if(isDefined(var_15.owner) && isPlayer(var_15.owner))
      _id_12AA2(var_15.owner, var_13, var_2, var_5);
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_5)) {
    if(scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_5) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" && istrue(level.vehicle_collision_getleveldata))
      return;
  }

  if(_id_1331E(self)) {
    var_16 = self.lastdroppableweaponobj;
    var_16 = scripts\mp\utility\weapon::mapweapon(var_16);
    var_17 = createheadicon(var_16);
    scripts\mp\utility\stats::incpersstat("_encstr_A7630C1916DAC2762BA20BB65673", var_13);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_17, 1, "_encstr_9A17121AA547F5DA2C39B52BE4B9D7A30BB556E6");
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_17, var_13, "_encstr_B2310D943398AE674DEE4B0270958B");

    if(var_13 > 1000)
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::determine_starting_breadcrumb(self, var_13, var_4);
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo.damage))
    var_0.streakinfo.damage = var_0.streakinfo.damage + var_2;

  if(scripts\mp\utility\damage::playershoulddofauxdeath() && var_2 >= self.health && !(var_3 &level.idflags_stun) && allowfauxdeath()) {
    if(!isDefined(var_7))
      var_7 = (0, 0, 0);

    if(!isDefined(var_1))
      var_1 = self;

    if(!isDefined(var_0))
      var_0 = var_1;

    playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    if(isPlayer(self)) {
      if(!isDefined(var_11))
        var_11 = "_encstr_B40101";

      if(!isDefined(var_12))
        var_12 = 0;

      if(shoulduseexplosiveindicator(var_4))
        var_3 = var_3 | level.idflags_ricochet;

      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        var_12 = 0;

      var_18 = !(var_4 != "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" && isDefined(self.update_bomb_interaction_ent));
      self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11, var_12, var_18);
      br_itemrarity(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }
  }

  if(var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
    scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_92DB0AEA3058EF97D3F8F121", "_encstr_B2BE0788BAF573592F", getdvarfloat("_encstr_8D940BB9364E7DD86E5BF6C8CA"), 0, 0);

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

shoulduseexplosiveindicator(var_0) {
  return var_0 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_0 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_0 == "_encstr_9B0D099AD3887D91252954";
}

callback_playerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\mp\weapons::impale(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

allowfauxdeath() {
  if(!isDefined(level.allowfauxdeath))
    level.allowfauxdeath = 1;

  return level.allowfauxdeath;
}

callback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = isforcedlaststand(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(!istrue(var_9)) {
    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && !istrue(self.killstreaklaststand) && (var_3 == "_encstr_8DED0A21C79B660BC7588981" && var_4.basename != "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C" && var_4.basename != "_encstr_A393109FCF38E936DA97CCE3177050314CB8"))
      return 0;

    if(var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      return 0;

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && scripts\mp\utility\damage::isheadshot(var_6, var_3, var_1))
      return 0;

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && isexplosivedamagemod(var_3))
      return 0;

    if(istrue(self.gulagarena))
      return 0;

    if(isDefined(var_1) && isDefined(var_1.classname) && (var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
      return 0;

    if(var_1 == self && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
      return 0;

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\killstreak::isjuggernaut())
      return 0;

    if(isDefined(level._id_11C6F) && !self[[level._id_11C6F]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8))
      return 0;
  }

  if(isDefined(level._id_121D1))
    self[[level._id_121D1]]();

  if(self isskydiving())
    self skydive_interrupt();

  var_10 = self.matchdatalifeindex;

  if(!isDefined(var_10))
    var_10 = level.maxlives - 1;

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname != "_encstr_BD4E0B7B104D6AD4DB384717A0") {
    if(!isPlayer(var_1)) {
      if(isDefined(var_1.owner) && isPlayer(var_1.owner))
        var_1 = var_1.owner;
      else if(isDefined(var_0) && isDefined(var_0.owner) && isPlayer(var_0.owner))
        var_1 = var_0.owner;
    }

    var_11 = playerkilled_initdeathdata(var_0, var_1, self, var_2, 0, var_3, var_4, var_5, var_6, var_7, var_8, 0);
    playerkilled_parameterfixup(var_11);
    playerkilled_precalc(var_11);
    var_11.laststandkill = 1;
    self._id_125B9 = 1;

    if(isPlayer(var_1) && var_1 != self) {
      self.watch_for_attack = var_1;
      self.watch_for_level_weapons_free = var_11.meansofdeath;
      self.watch_for_player_enter_puddle_trigger = var_4;
      var_1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var_10, self, var_4, var_3, var_0, var_11);
      self.watch_for_damage = var_1.modifiers["_encstr_87A205AF10734B"];
      self.watch_for_damage_on_trap = var_1.modifiers["_encstr_95A40617A8CBC38F"];
      self.watch_for_damage_on_turret = var_1.modifiers["_encstr_A2A406E139973007"];
    }

    self.lastbounty = scripts\mp\bounty::playergetbountypoints();
    scripts\mp\bounty::playerresetbountypoints();
    scripts\mp\bounty::playerresetbountystreak();
    var_11.isfriendlyfire = isfriendlyfire(self, var_1);

    if(getdvarint("_encstr_8C94142646BB27F8F93BE060F705B68FA2E115A0DB12", 1))
      self.watch_for_driver_spawned = var_11;

    if(!var_11.isfriendlyfire && var_1 != self) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
        if(isPlayer(var_1) && var_1 != self) {
          var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::incrementplayersdownedstat();
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_8FAE0723DEEECDCA19");
          var_12 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_4);
          var_13 = isDefined(var_12) && var_12 == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";

          if(var_13) {
            if(isDefined(var_1.brattractions))
              var_1.brattractions++;
          }

          if(var_1 ispcplayer() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
            var_1 setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 24);

          if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_816E079685517D0975" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_B18D0B5281530117EDEAC82033" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E" && level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size > 0)
            obituary(self, var_1, var_4, "_encstr_93FB096AD311EB11E9D527", level.teamdata[var_1.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]);
        }

        if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_B18D0B5281530117EDEAC82033" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_816E079685517D0975" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E") {
          if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
            var_14 = min(max(1, level.br_circle.circleindex), 6);
            var_15 = "_encstr_9AFE154CE4AF19B7EEDC2AE6CADA5E7DD8D29CC6D8ACFA" + scripts\engine\utility::string(var_14);

            if(scripts\mp\rank::isregisteredevent(var_15) && isPlayer(var_1))
              var_1 thread scripts\mp\utility\points::giveunifiedpoints(var_15, var_4);
          }
        }
      }
    }
  }

  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::brjugg_droponplayerdeath(0);

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12781(self, 0, 1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_down(var_1, self, var_4, "_encstr_8FAE0723DEEECDCA19", var_3);

    if(var_3 == "_encstr_8D4E0A501FCB898912CB3FA3" && isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
      self playSound("_encstr_A1F1119D2BA1968DC6ACD731B791CBF534961D");
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
    if(isDefined(var_1) && isPlayer(var_1) && !isbot(var_1))
      var_1 notify("_encstr_A17B13C00AB72BDA876930A074A743D19A136873C2");
  }

  if(isDefined(level.getinfilplayers)) {
    if([[level.getinfilplayers]](self))
      return 0;
  }

  thread scripts\mp\laststand::laststandthink();
  return 1;
}

isforcedlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker())
      return 1;

    if(isDefined(var_2) && isPlayer(var_2) && var_2 != var_0 && !istrue(var_2.gulag))
      var_2 thread scripts\mp\hud_message::showsplash("_encstr_AAF210E328DFE0D5D5B548D84840A356E539", undefined, var_0);

    if(var_4 == "_encstr_87A10C9D24E997A01F21838F3D34" && !istrue(self.gulagarena))
      var_8 = 1;
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func))
    var_8 = 1;

  return var_8;
}

gethitlocheight(var_0) {
  switch (var_0) {
    case "_encstr_9ABA05E87F4B70":
    case "_encstr_A6CC076A05751852B3":
    case "_encstr_81CC0586952C91":
      return 60;
    case "_encstr_BDB30AC6CA66A3FAA158CD23":
    case "_encstr_A1BD0B9C96D9D0A3F51A169B19":
    case "_encstr_8B970F1B56991DD758E4D6EB63ED77B239":
    case "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45":
    case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
    case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
    case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
    case "_encstr_8A1804DAAB75":
      return 48;
    case "_encstr_9B7A0CF35815C3971660B7CF306B":
      return 40;
    case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
    case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
      return 32;
    case "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A":
    case "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022":
      return 10;
    case "_encstr_8ECF0B734B47E3AB67AD07909B":
    case "_encstr_95E80A8D59CCD1F533DBED3A":
      return 5;
  }

  return 48;
}

damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread scripts\mp\weapons::onweapondamage(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self) && scripts\common\utility::getdamagetype(var_2) != "_encstr_A6260731BAD8D82BD1") {
    self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

    if(isDefined(var_0) && istrue(var_0.vehicle_collision_getignoreevent)) {
      self playSound("_encstr_961416FBF30F675D313DBD8857B8A5CBA74973B119D0EBD0");

      if(isDefined(level._id_145F1._id_13C8D)) {
        var_6 = level._id_145F1._id_13C8D[0].wz_tease;
        var_6 playsoundonmovingent("_encstr_A28914D9CA86FA1AB7E4CDD7C6589CB3DE8E390B2DE6");
      }
    }

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && var_2 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
      self playsoundtoplayer("_encstr_AF2F18233549299FAF039F6385B6BBC9EB5D29C906052F23D983", self);
  }
}

callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return 1;
}

emitfalldamage(var_0) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
}

gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(level.matchrules_damagemultiplier)
      var_3 = var_3 * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism) {
      var_2.health = int(min(float(var_2.maxhealth), min(var_2.health + var_3, float(var_2.health + 20))));
      var_2 notify("_encstr_96B00A7E4F82030372481F2D");
    }

    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_11 = weaponclass(var_5);

      switch (var_8) {
        case "_encstr_9ABA05E87F4B70":
        case "_encstr_A6CC076A05751852B3":
        case "_encstr_81CC0586952C91":
          if(var_11 != "_encstr_A1100738A33A638123" && var_5.basename != "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9")
            var_3 = var_3 * 2.7;

          break;
        case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
          break;
        case "_encstr_BDB30AC6CA66A3FAA158CD23":
        case "_encstr_A1BD0B9C96D9D0A3F51A169B19":
        case "_encstr_8B970F1B56991DD758E4D6EB63ED77B239":
        case "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45":
        case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
        case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
        case "_encstr_8A1804DAAB75":
          break;
        case "_encstr_9B7A0CF35815C3971660B7CF306B":
          break;
        case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
        case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
          break;
        case "_encstr_8ECF0B734B47E3AB67AD07909B":
        case "_encstr_95E80A8D59CCD1F533DBED3A":
        case "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A":
        case "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022":
          break;
      }
    }

    if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
      if(game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 0 || game["_encstr_9A40130B7B0D52D3E8CD84CB40D82A3B699B0FA7C9"] == 3) {
        if(!isbot(var_1)) {
          if(var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
            var_12 = 80;

            if(!isPlayer(var_2) || !isPlayer(var_1))
              return 0;

            var_13 = var_1 getplayerangles();
            var_14 = var_2 getplayerangles();
            var_15 = angleclamp180(var_13[1] - var_14[1]);

            if(abs(var_15) < var_12)
              var_3 = var_3 * 0.3;
          }
        }
      }
    }

    if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && isDefined(var_5)) {
      if(var_5.basename == "_encstr_A9FA118BE3BF87F959E780806F65F34F438DF6")
        var_3 = 135;
    }
  }

  return var_3;
}

registerkill(var_0, var_1, var_2, var_3) {
  self.killcountthislife++;
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]++;
  self setclientomnvar("_encstr_A24213BAA57D63B466CAEBB5B41BD8BED8DEBA731D", self.killcountthislife);
}

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");

  if(!isDefined(var_5))
    var_5 = 0;

  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = var_0;

  if(!isDefined(self.damagetaken) || istrue(var_6))
    self.damagetaken = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  for(var_7 = 1; var_7; var_7 = monitordamageoneshot(var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_21, var_1, var_2, var_3, var_4)) {
    self waittill("_encstr_B2BE0788BAF573592F", var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21);
    var_17 = scripts\mp\utility\weapon::mapweapon(var_17, var_21);

    if(var_5)
      self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");

    if(var_4) {
      var_22 = "_encstr_8BBA05185F8B99";

      if(isDefined(var_17))
        var_22 = createheadicon(var_17);

      logattackerkillstreak(self, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_22);
    }
  }
}

monitordamageend() {
  self notify("_encstr_A28411B5DEE64B1DB7E48858DA58D9B28ACD32");
  self.damagetaken = undefined;
  self.attackers = undefined;
  self.wasdamaged = undefined;
  self.wasdamagedfrombulletpenetration = undefined;
  self.wasdamagedfrombulletricochet = undefined;
  self setCanDamage(0);
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(self))
    return 0;

  if(isDefined(var_1) && isDefined(var_1.owner))
    var_1 = var_1.owner;

  if(isDefined(var_1) && !scripts\mp\utility\entity::isgameparticipant(var_1) && !istrue(var_1._id_1217B))
    return 1;

  if(isDefined(var_1) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_1)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {} else
      return 1;
  }

  var_15 = var_0;

  if(!istrue(self._id_133D4) && scripts\mp\utility\damage::non_player_should_ignore_damage(var_1, var_9, var_10, var_4))
    return 1;

  if(isDefined(var_9)) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

    if(!isDefined(var_13))
      var_13 = ::modifydamage;

    var_15 = self[[var_13]](var_16);
  }

  if(var_15 <= 0)
    return 1;

  self.wasdamaged = 1;
  self.damagetaken = self.damagetaken + int(var_15);
  self.health = 2147483647;

  if(isDefined(var_8) && var_8 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_8) && var_8 &level.idflags_ricochet)
    self.wasdamagedfrombulletricochet = 1;

  if(istrue(var_14))
    scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_9, self, var_4, var_15);

  if(isDefined(var_1)) {
    if(isPlayer(var_1))
      var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_11);
  }

  if(self.damagetaken >= self.maxhealth) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_16);
    return 0;
  }

  return 1;
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflag;

  if(isDefined(var_5) && (var_5 && level.idflags_ricochet))
    var_6 = 0.6 * var_4;
  else
    var_6 = var_4;

  var_6 = handleempdamage(var_2, var_3, var_6);
  var_6 = handlemissiledamage(var_2, var_3, var_6);
  var_6 = handlegrenadedamage(var_2, var_3, var_6);
  var_6 = handleapdamage(var_2, var_3, var_6);
  return var_6;
}

handlemissiledamage(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      self.largeprojectiledamage = 1;
      var_3 = self.maxhealth + 1;
      break;
    case "_encstr_BE1015E9AFFA8BB93814D8B07B2FD83DB36B7B29AF32CF":
      self.largeprojectiledamage = 0;
      var_3 = var_3 * 2;
      break;
  }

  return var_3;
}

handlegrenadedamage(var_0, var_1, var_2) {
  if(isexplosivedamagemod(var_1)) {
    switch (var_0.basename) {
      case "_encstr_9AAE0876FCB7603101DB":
        var_2 = var_2 * 3;
        break;
      case "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1":
      case "_encstr_92A70ABB8267F5E0D89F6351":
      case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
        var_2 = var_2 * 4;
        break;
      default:
        if(var_0.isalternate)
          var_2 = var_2 * 3;

        break;
    }
  }

  return var_2;
}

handlemeleedamage(var_0, var_1, var_2) {
  if(var_1 == "_encstr_8DED0A21C79B660BC7588981")
    return self.maxhealth + 1;

  return var_2;
}

handleempdamage(var_0, var_1, var_2) {
  return var_2;
}

handleapdamage(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;
  var_5 = level.armorpiercingmod - 1;

  if(scripts\mp\utility\damage::isfmjdamage(var_0, var_1, 1))
    var_4 = var_4 + var_5;

  var_6 = level.armorpiercingmodks - 1;

  if(isDefined(var_3) && var_3 scripts\mp\utility\perk::_hasperk("_encstr_ACA91ACF3BE01F69593170F3B96902739A76D7C03A4690BBF64C43D8") && isDefined(self.streakname) && scripts\mp\utility\weapon::isprimaryweapon(var_0) && scripts\engine\utility::isbulletdamage(var_1))
    var_4 = var_4 + var_6;

  return var_2 * var_4;
}

handleshotgundamage(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return var_2;

  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return var_2;

  if(weaponclass(var_0) != "_encstr_A1100738A33A638123")
    return var_2;

  return int(min(150, var_2));
}

onkillstreakdamaged(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1 = var_1.owner;

    if(isPlayer(var_1) && self.owner scripts\mp\utility\player::isenemy(var_1))
      var_4 = var_1;
  }

  if(isDefined(var_4))
    thread scripts\cp\vehicles\vehicle_compass_cp::killstreakdamaged(var_0, self.owner, var_4, var_2, var_3);
}

onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1 = var_1.owner;

    if(issentient(self.owner) && issentient(var_1)) {
      if(!istestclient(self.owner, var_1))
        var_10 = var_1;
    } else if(self.owner scripts\mp\utility\player::isenemy(var_1))
      var_10 = var_1;
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7))
      var_10 scripts\mp\battlechatter_mp::killstreakdestroyed(var_0);

    thread scripts\mp\events::killedkillstreak(var_0, var_10, var_2);
    thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var_0, self.owner, self, var_10, var_4, var_3, var_2, var_5);
    scripts\cp_mp\gestures::processcalloutdeath(self, var_10);
    var_9 = 1;
  }

  thread scripts\mp\events::_id_128B3(var_10);

  if(isDefined(self.owner) && isDefined(var_6))
    self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer(var_6, undefined, undefined, self.origin);

  if(!istrue(var_8))
    self notify("_encstr_AD75063D571AE108");

  return var_9;
}

updatedeathdetails(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_2.health)) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive())
      self setclientomnvar("_encstr_877F1E2DCC615921E9533889FB05DB8BAA35A6A0A70A1368C9E7C040D75493D1", 0);
    else
      self setclientomnvar("_encstr_877F1E2DCC615921E9533889FB05DB8BAA35A6A0A70A1368C9E7C040D75493D1", int(clamp(var_2.health, 0, var_2.maxhealth)) / var_2.maxhealth);
  } else
    self setclientomnvar("_encstr_877F1E2DCC615921E9533889FB05DB8BAA35A6A0A70A1368C9E7C040D75493D1", -1);

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_7, var_5 in var_0) {
      if(!isPlayer(var_5)) {
        continue;
      }
      var_6 = var_5 getentitynumber();
      self setclientomnvar("_encstr_85FD1B55B4192149810B903153DD2363029DCEC80E03D9316B5FF050D7" + var_3, var_6);
      self setclientomnvar("_encstr_8D9317BA96EB91592C1D86BEC82BD1854BC6DCF51A96A3CDFA" + var_3, int(min(var_1[var_7].hitcount, 10)));
      var_3++;

      if(var_3 >= 4) {
        break;
      }
    }
  }

  for(var_8 = var_3; var_8 < 4; var_8++)
    self setclientomnvar("_encstr_85FD1B55B4192149810B903153DD2363029DCEC80E03D9316B5FF050D7" + var_8, -1);
}

setdeathtimerlength(var_0) {
  var_1 = var_0.victim;
  var_2 = 0;

  if(var_1 scripts\mp\playerlogic::mayspawn() && !level.loadoutdefaultfiresalediscount) {
    var_3 = scripts\mp\playerlogic::timeuntilspawn(1);
    var_4 = 2.25;
    var_5 = 1;
    var_3 = max(var_3 + var_5, var_4);
    var_2 = var_3 + var_0.deathscenetimesec;
  }

  var_1.death_timer_length = int(var_2 * 10);
}

getindexfromhitloc(var_0) {
  switch (var_0) {
    case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
      return 0;
    case "_encstr_9B7A0CF35815C3971660B7CF306B":
      return 1;
    case "_encstr_A6CC076A05751852B3":
      return 2;
    case "_encstr_81CC0586952C91":
      return 3;
    case "_encstr_9ABA05E87F4B70":
      return 4;
    case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
      return 5;
    case "_encstr_8B970F1B56991DD758E4D6EB63ED77B239":
      return 6;
    case "_encstr_BDB30AC6CA66A3FAA158CD23":
      return 7;
    case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
      return 8;
    case "_encstr_970110C3DBB4827401D972BD36B0A7CB1D45":
      return 9;
    case "_encstr_A1BD0B9C96D9D0A3F51A169B19":
      return 10;
    case "_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83":
      return 11;
    case "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022":
      return 12;
    case "_encstr_95E80A8D59CCD1F533DBED3A":
      return 13;
    case "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920":
      return 14;
    case "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A":
      return 15;
    case "_encstr_8ECF0B734B47E3AB67AD07909B":
      return 16;
    case "_encstr_8A1804DAAB75":
      return 17;
    case "_encstr_8BBA05185F8B99":
      return 18;
  }

  return 0;
}

showuidamageflash() {
  self setclientomnvar("_encstr_93EF107FE046D4A2630F1F97782B8B9DC8B0", self.damageeventcount);
}

updatecombatrecordkillstats(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  if(isDefined(var_0) && isPlayer(var_0) && var_0 != var_1) {
    var_0 combatrecordarchetypekill(var_0.loadoutarchetype);

    if(isDefined(var_3)) {
      var_4 = scripts\mp\utility\weapon::getequipmenttype(var_3.basename);

      if(isDefined(var_4) && var_4 == "_encstr_B116071BCAD186858D") {
        var_5 = scripts\mp\equipment::getequipmentreffromweapon(var_3);

        if(var_5 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC" || var_5 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B" || var_5 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1")
          var_5 = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";

        var_0 combatrecordlethalkill(var_5);
      } else {
        var_6 = scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_3);

        if(isDefined(var_6)) {
          if(isenumvaluevalid("_encstr_8C07031599", "_encstr_9ABE1BAC7F5C689FF27787979B0ADED0F2D7B1C06AA4E8CD98F3F38BA7", var_6))
            var_0 combatrecordkillstreakstat(var_6);
        }

        if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
          if(istrue(var_0.personalradaractive))
            var_0 combatrecordtacticalstat("_encstr_8C6F10128867F3256E33BDB6334B4B69509B");

          if(istrue(var_0.adrenalinepoweractive))
            var_0 combatrecordtacticalstat("_encstr_B4D91112B8FF426AF628BBFB1088319ABB40DF");
        }
      }
    }
  }

  if(isDefined(var_1) && isPlayer(var_1))
    var_1 combatrecordarchetypedeath(var_1.loadoutarchetype);
}

combatrecordarchetypekill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_99070F287DEE70FD21EB13310FE8F6E373", var_0, "_encstr_8E8D0697EB01F243");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_99070F287DEE70FD21EB13310FE8F6E373", var_0, "_encstr_8E8D0697EB01F243", var_1 + 1);
}

combatrecordarchetypedeath(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_99070F287DEE70FD21EB13310FE8F6E373", var_0, "_encstr_8E0607055DBFB3919A");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_99070F287DEE70FD21EB13310FE8F6E373", var_0, "_encstr_8E0607055DBFB3919A", var_1 + 1);
}

hide_name_fx_from_players(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = scripts\mp\equipment::isequipmentlethal(var_0);

  if(var_0 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC" || var_0 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B" || var_0 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1")
    var_0 = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";

  if(var_1) {
    var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_A5F30CECDFFB02CFA8371B114D63", var_0, "_encstr_A5E405AB8F12FE");
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_A5F30CECDFFB02CFA8371B114D63", var_0, "_encstr_A5E405AB8F12FE", var_2 + 1);
  } else {
    var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AF3B0E1977C2CDB0635E807F03499086", var_0, "_encstr_A5E405AB8F12FE");
    self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AF3B0E1977C2CDB0635E807F03499086", var_0, "_encstr_A5E405AB8F12FE", var_2 + 1);
  }
}

combatrecordlethalkill(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_A5F30CECDFFB02CFA8371B114D63", var_0, "_encstr_8E8D0697EB01F243");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_A5F30CECDFFB02CFA8371B114D63", var_0, "_encstr_8E8D0697EB01F243", var_1 + 1);
}

combatrecordtacticalstat(var_0, var_1) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats() || !isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AF3B0E1977C2CDB0635E807F03499086", var_0, "_encstr_99D60BC5B8554096E7F459CC2F");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AF3B0E1977C2CDB0635E807F03499086", var_0, "_encstr_99D60BC5B8554096E7F459CC2F", var_2 + var_1);
}

combatrecordkillstreakstat(var_0) {
  if(!scripts\mp\utility\stats::canrecordcombatrecordstats()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::getstreakrecordtype(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_99D60BC5B8554096E7F459CC2F");
  self setplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", var_1, var_0, "_encstr_99D60BC5B8554096E7F459CC2F", var_2 + 1);
}

enqueuecorpsetablefunc(var_0, var_1) {
  if(!isDefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isDefined(self.corpsetablefuncs[var_0])) {
    self.corpsetablefuncs[var_0] = var_1;
    self.corpsetablefunccounts[var_0] = 0;
  }

  self.corpsetablefunccounts[var_0]++;
}

dequeuecorpsetablefunc(var_0) {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }
  if(!isDefined(self.corpsetablefuncs[var_0])) {
    return;
  }
  self.corpsetablefunccounts[var_0]--;

  if(self.corpsetablefunccounts[var_0] <= 0) {
    self.corpsetablefuncs[var_0] = undefined;
    self.corpsetablefunccounts[var_0] = undefined;
  }
}

callcorpsetablefuncs() {
  if(!isDefined(self.corpsetablefuncs)) {
    return;
  }
  var_0 = self.body;

  foreach(var_2 in self.corpsetablefuncs)
  self thread[[var_2]](var_0);

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("_encstr_B2BC16B06AF773FBB7AFFEF7AB77633B9ED2080113CDAF13");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

enqueueweapononkillcorpsetablefuncs(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\weapons::update_icon_for_bomb_case_detonator_holder(var_3))
    enqueuecorpsetablefunc("_encstr_BE340ACA83618B89AAAED5D3", scripts\mp\weapons::_id_11DF5);
  else if(scripts\mp\weapons::update_jugg_targets(var_3))
    enqueuecorpsetablefunc("_encstr_AF600B23C9DEDB3651B3E1FC41", scripts\mp\weapons::_id_11DF6);
}

startcopycatoption(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_ADA4159BE8B783F536EDE0BCD7B158D1D7BDE0E8A5DEE6");

  if(!isDefined(var_0) || !isPlayer(var_0) || isbot(self)) {
    return;
  }
  while(self playcinematicforplayerlooping())
    waitframe();

  while(!self playcinematicforplayerlooping())
    waitframe();

  scripts\mp\class::copyclassfornextlife(var_0);
}

stopcopycatoption() {
  self notify("_encstr_ADA4159BE8B783F536EDE0BCD7B158D1D7BDE0E8A5DEE6");
}

unset_force_aitype_sniper(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0.code_classname) && var_0.code_classname == "_encstr_96010BDCD8392D073A164C1B2B") {
    switch (var_0.classname) {
      case "_encstr_9274232308F554CB8B4F9A9C55361BDA0728BB7AF8ABCDD7C62D61867A5E2BA5BD78D1076A":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_1331E(var_0) {
  if(istrue(level.little_bird_mp_initmines))
    return 0;

  if(isDefined(level.little_bird_onenterheavydamagestate) && ![[level.little_bird_onenterheavydamagestate]](var_0))
    return 0;

  return 1;
}

_id_119C0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_3)) {
    return;
  }
  var_4 = var_2 >= var_0.health;
  var_1 scripts\common\utility::_id_13E0A(level._id_11B31, scripts\mp\utility\weapon::getweaponrootname(var_1.currentweapon), "_encstr_B8C8158BF5BB5A662070A8392990A29218611F3FBBD402", int(min(var_2, var_0.health)), -1, var_1.currentweapon);
  var_0 dlog_recordplayerevent("_encstr_A68C19C81BB7ECBEACECAC9BA37DCC39B456CD8C63CBF599B4C9CA", ["_encstr_AA7B09475984AF0F6F0F0B", var_1, "_encstr_B2BE0788BAF573592F", var_2, "_encstr_81951090629FF0778B57015F7BE2490B7F7F", var_4, "_encstr_A26E0E5F206981707FA65FDB54214A12", var_3]);
}

usecallback(var_0) {
  if(!isscriptedagent(var_0))
    return 0;

  return 1;
}

_id_12F86(var_0, var_1, var_2) {
  if(!isDefined(var_0.unittype) || var_2 == "_encstr_82CE0B99F4E747541744ADB520")
    return var_1;

  switch (var_0.unittype) {
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return int(var_1 * 0.3);
    case "_encstr_958C08CDDBD8325A959C":
      return int(var_1 * 0.4);
  }

  return var_1;
}

br_itemrarity(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_1)) {
    return;
  }
  var_14 = isDefined(var_5) && var_5.basename == "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1";

  if(!istrue(var_14) && !var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }
  if(!isDefined(var_1.branalytics_publiceventstarted))
    var_1.br_onvehicledeath = ["_encstr_BA68141398EDF997EBAD6A4F35B3577B13587AFA9B6F", 0, "_encstr_B1C40993ABDC7DF63B2B9C", 0, "_encstr_B634111F39C3E9E99768BF315BE8FF3CE84115", 0, "_encstr_999B050670F0FA", 0, "_encstr_82680E6210C589BD482933D7831B8FA4", 0, "_encstr_A97D0AE912CB201C6ACA635A", 0, "_encstr_8FF20ED23B87F029B1F50F53595A952A", 0, "_encstr_920D11620D19A29761B07F57A038614BCB90AD", 0, "_encstr_8261067B1D34AC27", 0];

  var_15 = [];
  var_16 = "_encstr_B40101";

  if(!isent(var_13) || !isPlayer(var_13)) {
    return;
  }
  if(var_1 == var_13)
    var_16 = "_encstr_920D11620D19A29761B07F57A038614BCB90AD";
  else if((var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3") {
    var_17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_1);

    if(!isDefined(var_17))
      var_16 = "_encstr_BA68141398EDF997EBAD6A4F35B3577B13587AFA9B6F";
    else
      var_16 = "_encstr_B1C40993ABDC7DF63B2B9C";
  } else if(istrue(var_14))
    var_16 = "_encstr_999B050670F0FA";
  else if(isDefined(var_5) && var_5.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
    var_16 = "_encstr_82680E6210C589BD482933D7831B8FA4";
  else if(isDefined(var_5) && var_5.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
    var_16 = "_encstr_8FF20ED23B87F029B1F50F53595A952A";
  else if(var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")
    var_16 = "_encstr_B634111F39C3E9E99768BF315BE8FF3CE84115";
  else
    var_16 = "_encstr_8261067B1D34AC27";

  switch (var_16) {
    case "_encstr_BA68141398EDF997EBAD6A4F35B3577B13587AFA9B6F":
      var_1.br_onvehicledeath[1] = var_1.br_onvehicledeath[1] + 1;
      break;
    case "_encstr_B1C40993ABDC7DF63B2B9C":
      var_1.br_onvehicledeath[3] = var_1.br_onvehicledeath[3] + 1;
      break;
    case "_encstr_B634111F39C3E9E99768BF315BE8FF3CE84115":
      var_1.br_onvehicledeath[5] = var_1.br_onvehicledeath[5] + 1;
      break;
    case "_encstr_999B050670F0FA":
      var_1.br_onvehicledeath[7] = var_1.br_onvehicledeath[7] + 1;
      break;
    case "_encstr_82680E6210C589BD482933D7831B8FA4":
      var_1.br_onvehicledeath[9] = var_1.br_onvehicledeath[9] + 1;
      break;
    case "_encstr_A97D0AE912CB201C6ACA635A":
      var_1.br_onvehicledeath[11] = var_1.br_onvehicledeath[11] + 1;
      break;
    case "_encstr_8FF20ED23B87F029B1F50F53595A952A":
      var_1.br_onvehicledeath[13] = var_1.br_onvehicledeath[13] + 1;
      break;
    case "_encstr_920D11620D19A29761B07F57A038614BCB90AD":
      var_1.br_onvehicledeath[15] = var_1.br_onvehicledeath[15] + 1;
      break;
    case "_encstr_8261067B1D34AC27":
      var_1.br_onvehicledeath[17] = var_1.br_onvehicledeath[17] + 1;
      break;
    default:
      break;
  }

  var_1.br_onvehicledeath[var_1.br_onvehicledeath.size] = "_encstr_B498148DC2378EBECE2D6C472D5BAFAC73A3AF37AED6";
  var_1.br_onvehicledeath[var_1.br_onvehicledeath.size] = var_13 getentitynumber();

  if(isPlayer(var_1))
    var_1 dlog_recordplayerevent("_encstr_916E1BEC51F057EF2553F24A3B100BCDE82D654FF7785DEBC00B0BB361", var_1.br_onvehicledeath);
  else if(isDefined(var_1.owner) && isPlayer(var_1.owner))
    var_1.owner dlog_recordplayerevent("_encstr_916E1BEC51F057EF2553F24A3B100BCDE82D654FF7785DEBC00B0BB361", var_1.br_onvehicledeath);
}