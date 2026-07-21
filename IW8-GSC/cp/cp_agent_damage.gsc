/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_agent_damage.gsc
***********************************************/

register_ai_damage_callbacks() {
  level.agent_funcs["_encstr_A7E80E1818902B623DBA872BD4C1184C"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_A7E80E1818902B623DBA872BD4C1184C"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_A7E80E1818902B623DBA872BD4C1184C"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_958C08CDDBD8325A959C"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_958C08CDDBD8325A959C"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_958C08CDDBD8325A959C"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_83E8094727E333E8F9CE50"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_83E8094727E333E8F9CE50"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_83E8094727E333E8F9CE50"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_9205118D8F2AEC481AF559D39BCF9014E27B39"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_9205118D8F2AEC481AF559D39BCF9014E27B39"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_9205118D8F2AEC481AF559D39BCF9014E27B39"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
  level.agent_funcs["_encstr_8EF60E63FBE3D70440A312175B98CF6B"]["_encstr_8BB20BDE37D723C2DA859DACC8"] = ::callbacksoldieragentdamaged;
  level.agent_funcs["_encstr_8EF60E63FBE3D70440A312175B98CF6B"]["_encstr_B42E1C57A6502599F90970DE4258B1659735102ADDA72339234B6AEB0167"] = ::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["_encstr_8EF60E63FBE3D70440A312175B98CF6B"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::callbacksoldieragentgametypekilled;
}

callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13.agent_type)) {
    return;
  }
  if(istrue(var_13.clear_keypad_currentdisplay_models))
    var_13.clear_keypad_currentdisplay_models = undefined;
  else {
    if(!isDefined(var_12))
      var_12 = var_5;

    if(var_4 != "_encstr_AB590C99ED78875F650F3951034D") {
      if(scripts\cp\utility::is_friendly_damage(var_13, var_0))
        return;
    }

    if(!isDefined(var_1))
      var_1 = var_13;

    var_14 = should_do_damage_checks(var_1, var_2, var_4, var_5, var_8, var_13);

    if(!var_14) {
      return;
    }
    var_3 = var_3 | 4;
    var_15 = var_2;
    var_16 = isDefined(var_13.agent_type);
    var_17 = var_12.basename;
    var_18 = var_12.classname;
    var_19 = triggered_module_spawn();
    var_20 = istrue(var_1.inlaststand);
    var_21 = var_4 == "_encstr_8DED0A21C79B660BC7588981";
    var_22 = var_13 scripts\cp\utility::agentisinstakillimmune();
    var_23 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_8 != "_encstr_8BBA05185F8B99";
    var_24 = isDefined(var_1) && isPlayer(var_1);
    var_25 = isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_26 = isDefined(var_1) && isDefined(var_1.agent_type) && var_1.agent_type == "_encstr_A7E80E1818902B623DBA872BD4C1184C";
    var_27 = isDefined(var_13.unittype) && var_13.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
    var_28 = var_23 && scripts\cp\utility::isheadshot(var_12, var_8, var_4, var_1);
    var_29 = var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && (isDefined(var_8) && var_8 == "_encstr_8BBA05185F8B99") || var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48";
    var_30 = var_4 == "_encstr_9B0D099AD3887D91252954";
    var_31 = 0;
    var_32 = var_24 && var_1 scripts\cp\utility::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
    var_33 = isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_34 = var_33 && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3";
    var_35 = isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && !isDefined(var_1.owner);
    var_36 = var_35 && var_4 == "_encstr_8D4E0A501FCB898912CB3FA3";

    if(isDefined(level._id_14000))
      level thread[[level._id_14000]](var_1, var_5, var_13, var_4, var_8, var_9);

    if((var_24 || var_25) && istrue(var_13.invulnerable) && var_4 != "_encstr_AB590C99ED78875F650F3951034D") {
      return;
    }
    if(var_27) {
      if(var_21) {
        var_37 = [];
        var_38 = spawnStruct();
        var_38.type = "_encstr_9A211D31C9B2165BEBB9D1AC1663A3A1BEBBA51D1AEB737BFAC8B0AD0BECB2";
        var_38.entity = var_1;
        var_37[0] = var_38;
        var_13 notify("_encstr_B4580A0740984DFBF2C57BEB", var_37);
        return;
      } else {
        if(var_17 == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1" || var_17 == "_encstr_AC5911C3C04BE2CF58550D3F6F03FFAC971B0B")
          var_2 = var_2 * 15;

        if(var_17 == "_encstr_8DCB0F47F22330CEE7996B13A2E390583A")
          var_2 = self.health + 1000;
      }

      if(var_34) {
        var_39 = ["_encstr_8C190467402B"];

        if(scripts\engine\utility::array_contains(var_39, var_1.vehiclename))
          var_1 dodamage(10000, var_1.origin, var_13);
        else {
          playsoundatpos(self.origin + (0, 0, 40), "_encstr_92B30D6F234A09E94D1C433D9841E8");
          var_2 = self.health + 1000;
        }
      }
    } else if(var_24) {
      if(var_17 == "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83")
        var_2 = self.health + 1000;

      if((var_17 == "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8" || var_17 == "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0") && var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
        var_2 = self.health + 1000;
    }

    if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
      if(setuphudelemninfilcover(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
        return;
      }
      if(var_8 == "_encstr_A32D07CFD14BAA94D0" && (var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") && var_2 > 175) {
        var_2 = var_2 * 0.05;
        var_8 = "_encstr_9B7A0CF35815C3971660B7CF306B";
      }
    }

    if(var_19) {
      if(var_17 == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18")
        var_2 = self.health + 1000;
    }

    if(var_34) {
      playsoundatpos(self.origin + (0, 0, 40), "_encstr_92B30D6F234A09E94D1C433D9841E8");

      if(!istrue(level.global_stealth_broken)) {}
    }

    if(var_36) {
      if(istrue(self.trial_target_think_func)) {
        var_2 = 0;
        var_13 notify("_encstr_AB5011CE5943D71BE4EA3786D79158DA2CCE95", var_1);
      }
    }

    if(var_24) {
      var_13.damaged_by_player = 1;

      if(var_28) {
        if(var_27) {
          if(scripts\cp\utility::tryingtoleave())
            var_2 = var_2 * 0.3;
          else
            var_2 = bink_save_hack(var_2, var_5, var_18, var_4, var_1);
        }
      }

      if(var_32)
        var_2 = var_2 * 2;

      if(var_29) {
        var_40 = var_2 * 2.5;

        if(isDefined(level.explosivedamagemod))
          var_40 = var_40 * level.explosivedamagemod;

        var_2 = var_2 + var_40;
      }

      if(var_30)
        var_2 = var_2 + var_2 * 3.5;

      if(var_21) {
        if(istrue(var_13.immune_to_melee_damage)) {
          var_2 = 0;
          var_13 notify("_encstr_8B721A986F54108DB1EB83B11F9A4079FDC7201197BFB8B1CAE795AB", var_1);
        } else {
          var_2 = 150;
          var_2 = var_2 * var_1 scripts\cp\perks\cp_perks::get_perk("_encstr_86FA0DB595C6592B7D9B1B853658E4");

          if(turn_off_have_target_hud(var_17))
            var_2 = 175;
          else {
            if(issubstr(var_17, "_encstr_BED80D7C9C59D95BF870DBDFA9F018"))
              var_2 = 350;

            if(issubstr(var_17, "_encstr_85E10896BB07EB6B59D7"))
              var_2 = 350;
            else if(isDefined(var_12.muzzle)) {
              if(issubstr(var_12.muzzle, "_encstr_AC0F0C470DEB32B82B377028583D"))
                var_2 = 350;

              if(issubstr(var_12.muzzle, "_encstr_B282081385F2F6B9B2D1"))
                var_2 = 350;
            }
          }
        }
      }

      if(var_23) {
        if(!var_28) {
          if(!isDefined(level.bullet_damage_scalar))
            level.bullet_damage_scalar = 1;

          var_2 = var_2 * level.bullet_damage_scalar;
        }

        var_2 = var_2 * var_1 scripts\cp\perks\cp_perks::get_perk("_encstr_866A1598EAD8C6598EF58C0BADB0EC95FACDD885B1B04E");
      }

      if(is_wearing_armor()) {
        if(var_27 || var_8 == "_encstr_952B0C65857BBFB80F9FC0B8A75A" || var_8 == "_encstr_9B7A0CF35815C3971660B7CF306B") {
          var_2 = scripts\cp\cp_damage::handleapdamage(var_12, var_4, var_2, var_1);
          var_2 = var_2 * 0.5;
        }
      }

      if(var_2 < var_13.health)
        var_1 scripts\cp\cp_persistence::give_player_currency(10, "_encstr_8DEC06B1E943615B", var_8);
      else if(var_24) {
        if(var_27)
          thread scripts\cp_mp\xmike109::getaverageangularvelocity();

        thread scripts\cp\cp_achievement::ascender_disableplayeruse(var_1, var_4, var_17);
      }

      var_41 = var_1 scripts\cp\perks\cp_perks::get_perk("_encstr_B8971AB943DE4EE8BE9CB073762BEB23B0B5C276B2F5B9D8C2C60B4E");

      if(var_41 > 1) {
        var_42 = distancesquared(var_1.origin, var_13.origin);

        if(var_42 < 40000)
          var_2 = var_2 * var_41;
      }

      if(istrue(var_1.is_available_for_hack)) {
        var_43 = var_1.origin[2];
        var_44 = var_13.origin[2];

        if(var_43 >= var_44) {
          var_45 = int(abs(var_43 - var_44));
          var_46 = int(var_45 / 64);

          if(var_46 > 0)
            var_2 = var_2 * (1 + 0.4 * var_46);
        }
      }
    }

    if(!var_27 && var_31)
      var_2 = self.health + 100;

    if(isDefined(var_17) && var_17 == "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8" && isDefined(var_4) && var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
      var_2 = var_2 * 2;

    if(isPlayer(var_1)) {
      scripts\cp\agents\gametype_cp_wave_sv::sethasdonecombat(var_1, 1);

      if(isDefined(var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
        var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]++;
      else
        var_1.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 1;

      if(isDefined(var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"]))
        var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"]++;
      else
        var_1.pers["_encstr_9BD41A08B3E8243FB5A0A269AA97C7DAD8058469D7682ACF65587A42"] = 1;
    }

    var_47 = isDefined(var_4) && var_4 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001";

    if(var_47)
      var_1 thread scripts\cp\cp_player_battlechatter::battle_tracks_monitorstandingonvehicles();

    var_2 = scripts\cp\cp_damage::modifydamagegeneral(var_0, var_1, var_13, var_2, var_3, var_4, var_12, var_6, var_7, var_8);

    if(var_24 || var_25 || var_34) {
      if(isDefined(var_12)) {
        if(var_25)
          var_1 = var_1.owner;

        addattacker(self, var_1, var_0, var_12, var_2, var_6, var_7, var_8, var_9, var_4);
      }

      if(var_2 >= var_13.health) {
        if(var_12.basename == "_encstr_8BBA05185F8B99") {
          if(isDefined(var_0) && isDefined(var_0.weapon_name))
            var_12 = getcompleteweaponname(var_0.weapon_name);
        }

        var_48 = spawnStruct();
        var_48.einflictor = var_0;
        var_48.eattacker = var_1;
        var_48.idamage = var_2;
        var_48.idflags = var_3;
        var_48.smeansofdeath = var_4;
        var_48.sweapon = var_5;
        var_48.vpoint = var_6;
        var_48.vdir = var_7;
        var_48.shitloc = var_8;
        var_48.timeoffset = var_9;
        var_48.modelindex = var_10;
        var_48.partname = var_11;
        var_48.objweapon = var_12;
        thread ai_drop_func(var_48);
      }
    }

    _id_1289F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_2 = int(min(var_2, var_13.maxhealth));

    if(isDefined(level.updateondamagerelicsfunc))
      level thread[[level.updateondamagerelicsfunc]](var_1, var_5, var_13, var_4, var_8, var_9);

    scripts\cp\cp_damagefeedback::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_7, var_7, var_8, var_9, self);

    if(is_flashbang(var_17, var_12, var_0) && var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
      var_13 notify("_encstr_ABE70A08F0C68B546D12A8E7", var_8, 1, undefined, var_1, "_encstr_9A8507BA4040188D08");

    if(is_gas(var_17) && var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
      var_13 notify("_encstr_ABE70A08F0C68B546D12A8E7", var_8, 1, undefined, var_1, "_encstr_9A8507BA4040188D08");

    if(isDefined(var_13.unittype) && isDefined(level.agent_funcs[var_13.unittype]) && isDefined(level.agent_funcs[var_13.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"])) {
      var_13[[level.agent_funcs[var_13.unittype]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
      return;
    }

    var_13[[level.agent_funcs[var_13.agent_type]["_encstr_A99F14ED73EB3285DAC2B3CA32D7334BE62DB934AC46"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
  }
}

turn_off_have_target_hud(var_0) {
  switch (var_0) {
    case "_encstr_9BE916CAE02981E7E1E821539B8893D5C590B332600FC54B":
    case "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1":
      return 1;
  }

  return 0;
}

_id_1289F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_13 endon("_encstr_AD75063D571AE108");

  if(!isPlayer(var_1)) {
    return;
  }
  if(var_2 >= var_13.health) {
    if(isDefined(var_1._id_119D4) && var_1._id_119D4.size > 0) {
      if(istrue(var_1._id_119D4[var_13 getentitynumber()]))
        return;
    }

    var_1 thread scripts\mp\mp_agent_damage::vip_playerdied(undefined, self, var_12, var_4, var_0, 0, var_8);
    thread scripts\mp\ammorestock::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_12, var_8, var_1.modifiers);
  }
}

setuphudelemninfilcover(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_12.basename;
  var_14 = 0;

  if(isDefined(var_0) && (issubstr(var_13, "_encstr_8D7609A4F337C2C9C2BDB7") || isDefined(var_12.magazine) && issubstr(var_12.magazine, "_encstr_B47E094630B8ACB27B2D57") || isDefined(var_0.weapon_name) && issubstr(var_0.weapon_name, "_encstr_AD360B5ACD7E474DF83389820B"))) {
    var_14 = 1;
    var_15 = var_8 == "_encstr_A32D07CFD14BAA94D0";

    if(var_15) {
      var_16 = scripts\engine\trace::create_character_contents();
      var_17 = vectorNormalize(var_7);
      var_18 = var_6 - var_17 * 12;
      var_19 = var_6 + var_17 * 12;
      var_20 = scripts\engine\trace::ray_trace_detail(var_18, var_19, undefined, var_16);

      if(var_20["_encstr_A53009A25003666B9818C6"] > 0 && var_20["_encstr_A53009A25003666B9818C6"] < 1) {
        var_21 = var_6 - self.origin;
        var_21 = (var_21[0], var_21[1], 0);

        if(vectordot(var_21, var_20["_encstr_820E07FAE8780B3A4C"]) < 0)
          var_15 = 0;
      } else
        var_15 = 0;
    }

    if(var_15) {
      var_22 = var_0 getlinkedparent();

      if(isDefined(var_22) && var_22 == self) {
        self.clearspaceforscriptableinstance = 1;
        self._id_13B2A = 0;
      }
    } else if(var_8 != "_encstr_8BBA05185F8B99") {
      self.clearspaceforscriptableinstance = undefined;
      self._id_13B2A = undefined;
    }
  }

  if(var_8 == "_encstr_A32D07CFD14BAA94D0") {
    if(var_14)
      return 1;
  } else if(var_8 == "_encstr_8BBA05185F8B99" && isDefined(var_0)) {
    var_23 = var_0 getlinkedparent();

    if(istrue(self.clearspaceforscriptableinstance) && var_14 && isDefined(var_23) && var_23 == self) {
      if(!isDefined(self._id_13B2C))
        self._id_13B2C = [var_0];
      else if(!scripts\engine\utility::array_contains(self._id_13B2C, var_0))
        self._id_13B2C[self._id_13B2C.size] = var_0;

      self._id_13B2A++;
      return 1;
    } else if(issubstr(var_13, "_encstr_8DCB085BEF657B4DCF0B")) {
      var_24 = var_0.origin - self.origin;
      var_25 = vectorNormalize((var_24[0], var_24[1], 0));
      var_24 = vectorNormalize(var_24);

      if(vectordot(anglesToForward(self.angles), var_25) > 0.5 && -0.98 < var_24[2] && var_24[2] < 0.98)
        return 1;
    }
  }

  if(var_4 == "_encstr_8DED0A21C79B660BC7588981") {
    if(isDefined(var_1))
      var_26 = vectorNormalize(var_1.origin - self.origin);
    else
      var_26 = vectorNormalize(var_6 - self.origin);

    var_27 = anglesToForward(self.angles);

    if(vectordot(var_27, var_26) > 0.5)
      return 1;
  }

  return 0;
}

bink_save_hack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  switch (var_2) {
    case "_encstr_965306392D3336B2":
      var_5 = min(var_0, 84);
      break;
    case "_encstr_BE1904DCDA9D":
      var_5 = min(var_0, 110);
      break;
    case "_encstr_BE0703A54C":
      var_5 = min(var_0, 105);
      break;
    case "_encstr_A1100738A33A638123":
      var_5 = min(var_0, 84);
      break;
    case "_encstr_8D940738966ED1DB8D":
      var_5 = min(var_0, 75);
      break;
    case "_encstr_850707F7E5833355B8":
      var_5 = min(var_0, 130);
      break;
    default:
      var_5 = var_0;
      break;
  }

  return var_0;
}

triggered_module_spawn() {
  return istrue(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B");
}

getcodecomputerdisplaycode() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.bullet_damage_scalar = 1;

  for(;;) {
    var_0 = getdvarfloat("_encstr_A99B19DE0BA386B52BBAE0A0D349619977B16C5D5FDF49FB5572E8", 1.0);

    if(level.bullet_damage_scalar != var_0)
      level.bullet_damage_scalar = var_0;

    wait 1;
  }
}

register_ai_drop_funcs() {
  register_drop_func("_encstr_AC20072B9FA9487832", ::drop_weapon_func, ::should_drop_weapon, 0);
}

register_drop_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.ai_drop_info))
    level.ai_drop_info = [];

  var_4 = spawnStruct();
  var_4.name = var_0;
  var_4.chance_func = var_2;
  var_4.func = var_1;
  var_4.score = 0;
  var_4.delay = var_3;
  var_4.next_chance = 0;
  level.ai_drop_info[level.ai_drop_info.size] = var_4;
}

ai_drop_func(var_0) {
  if(!isDefined(level.ai_drop_info)) {
    return;
  }
  if(isDefined(level._id_13FD4))
    [[level._id_13FD4]](self.origin, var_0);

  if(isDefined(self.force_drop)) {
    var_1 = get_func_by_name(self.force_drop);
    self thread[[var_1]](var_0);
  } else
    var_2 = check_for_drop(var_0);
}

get_func_by_name(var_0) {
  for(var_1 = 0; var_1 < level.ai_drop_info.size; var_1++) {
    if(level.ai_drop_info[var_1].name == var_0)
      return level.ai_drop_info[var_1].func;
  }
}

drop_ready_item(var_0, var_1) {
  var_2 = gettime();
  self thread[[var_0.func]](var_1);
  var_0.score = 0;
  var_0.next_chance = var_2 + var_0.delay * 1000;
}

check_for_drop(var_0) {
  var_1 = gettime();
  var_2 = 0;
  var_3 = scripts\engine\utility::array_randomize(level.ai_drop_info);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(!var_2) {
      if(var_1 > var_5.next_chance) {
        if(var_5.score > 99) {
          drop_ready_item(var_5, var_0);
          var_2 = 1;
          continue;
        }

        if([[var_5.chance_func]](var_0)) {
          drop_ready_item(var_5, var_0);
          var_2 = 1;
        }
      }
    }
  }

  return var_2;
}

drop_weapon_func(var_0) {
  if(!istrue(var_0.eattacker._id_11E8E))
    self.dropweapon = 1;

  if(!isPlayer(var_0.eattacker)) {
    return;
  }
  if(isDefined(var_0.eattacker.class) && var_0.eattacker.class == "_encstr_88CC09377EA33BA181ED2E" || isDefined(level.blueprintextract_trygetreward)) {
    if(_id_132C8(var_0.eattacker))
      drop_grenade(var_0);
  }

  if(var_0.eattacker scripts\cp\utility::_hasperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3")) {
    if(_id_132CB(var_0.eattacker)) {
      var_1 = self.origin - (10, 10, 0);
      minigun_origin_offset(var_0, var_1);
    }
  }
}

_id_132CB(var_0) {
  if(isDefined(self.chute))
    return 0;

  if(!self isonground())
    return 0;

  if(isDefined(self.ridingvehicle))
    return 0;

  if(!isDefined(var_0.waittill_any_return_no_endon_death_6)) {
    var_0.waittill_any_return_no_endon_death_6 = gettime();
    return 1;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0.waittill_any_return_no_endon_death_6;

  if(var_2 > var_1) {
    var_0.waittill_any_return_no_endon_death_6 = gettime();
    return 1;
  }

  return 0;
}

minigun_origin_offset(var_0, var_1) {
  var_2 = self.origin;

  if(isDefined(var_1))
    var_2 = var_1;

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 thread astar_node_radius_override(var_0.eattacker);
}

astar_node_radius_override(var_0) {
  self endon("_encstr_AD75063D571AE108");

  foreach(var_2 in level.players) {
    if(var_2 != var_0)
      self hidefromplayer(var_2);
  }

  self setModel("_encstr_91F0186DBFABA7E223D80AA321371E3F632DFEE7DD1337AEE330");
  self.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 30, 10);
  thread scripts\cp\utility::delayentdelete(20);
  self.trigger thread scripts\cp\utility::delayentdelete(20);

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(var_4 == var_0) {
      var_4 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
      var_4 score_spawner_relative_to_objective();
      var_4 thread scripts\cp\cp_damagefeedback::hudicontype("_encstr_AF460A7B2649F34FE367455D");
      self.trigger delete();
      self delete();
    }
  }
}

scorelimitreached() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(var_2) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }
    if(scripts\cp\cp_weapon::is_launcher(var_2)) {
      continue;
    }
    if(cangive_ammo()) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = self getweaponammostock(var_2);
      var_5 = weaponclipsize(var_2);
      var_6 = var_3 + var_4 + var_5;

      if(var_6 == var_5)
        self setweaponammoclip(var_2, var_6);
      else {
        self setweaponammoclip(var_2, var_5);
        var_7 = var_6 - var_5;
        self setweaponammostock(var_2, var_7);
      }
    }
  }
}

score_spawner_relative_to_objective() {
  var_0 = 30;
  var_1 = 0;
  var_2 = self getcurrentprimaryweapon();

  if(!scripts\cp\utility::is_valid_player())
    var_1 = 1;

  if(weapontype(var_2) == "_encstr_A5450BC280BF4B604068C33187")
    var_1 = 1;

  if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2))
    var_1 = 1;

  if(scripts\cp\cp_weapon::is_launcher(var_2))
    var_1 = 1;

  if(!var_1) {
    if(cangive_ammo()) {
      var_0 = getammooverride(var_2);
      var_3 = self getweaponammostock(var_2);
      var_4 = weaponmaxammo(var_2);
      var_5 = var_3 + var_0;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_2, var_6);
      return 1;
    }
  }

  var_7 = self getweaponslistprimaries();

  foreach(var_2 in var_7) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(var_2) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }
    if(scripts\cp\cp_weapon::is_launcher(var_2)) {
      continue;
    }
    if(cangive_ammo()) {
      var_0 = getammooverride(var_2);
      var_3 = self getweaponammostock(var_2);
      var_4 = weaponmaxammo(var_2);
      var_5 = var_3 + var_0;
      var_6 = int(min(var_4, var_5));
      self setweaponammostock(var_2, var_6);
      return 1;
    }
  }

  return 0;
}

getammooverride(var_0) {
  var_1 = var_0 getbaseweapon();
  var_2 = weaponclipsize(var_1);
  var_3 = scripts\cp\utility::getweaponrootname(var_0);
  var_4 = 30;
  var_5 = var_4;

  if(var_0.isalternate) {
    var_6 = scripts\cp\utility::attachmentmap_tobase(var_0.underbarrel);

    switch (var_6) {
      case "_encstr_A78B09ECB16E2B5B47590F":
      case "_encstr_97D506F770BFFFBB":
      case "_encstr_8A07035972":
      case "_encstr_8435070CAC0F080BD2":
      case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
      case "_encstr_873708FFA8104C0AAEC1":
      case "_encstr_ADBD0780C4884FEE86":
      case "_encstr_AA7608ECD89B6BDE5B59":
        var_5 = 1;
        break;
      case "_encstr_BE9708CBAB13138857AD":
        var_5 = 999;
        break;
      default:
        var_5 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "_encstr_A1100738A33A638123":
        switch (var_3) {
          case "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253":
            var_5 = 6;
            break;
          case "_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A":
            var_5 = 8;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      case "_encstr_850707F7E5833355B8":
        switch (var_3) {
          case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
            var_5 = 3;
            break;
          default:
            var_5 = int(min(var_2, var_4));
            break;
        }

        break;
      default:
        var_5 = int(min(var_2, var_4));
    }
  }

  return var_5;
}

cangive_ammo() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2)
    return 1;
  else
    return 0;
}

_id_132C8(var_0) {
  if(isDefined(self.chute))
    return 0;

  if(!self isonground())
    return 0;

  if(isDefined(self.ridingvehicle))
    return 0;

  if(!isDefined(var_0.waittill_any_timeout_no_endon_death_1)) {
    var_0.waittill_any_timeout_no_endon_death_1 = gettime();
    return 1;
  }

  var_1 = 10000;
  var_2 = gettime() - var_0.waittill_any_timeout_no_endon_death_1;

  if(var_2 > var_1) {
    var_0.waittill_any_timeout_no_endon_death_1 = gettime();
    return 1;
  }

  return 0;
}

drop_grenade(var_0) {
  var_1 = self.origin + (10, 10, 0);
  mine_destroyed_vfx(var_0, var_1);
}

mine_destroyed_vfx(var_0, var_1, var_2) {
  var_3 = self.origin;

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = scripts\cp\utility::createhintobject(var_3, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_AB5A1BA1CBB77650E6CC7B17C94EF0480FA2F9CBB2A73968BFB66B79E4", &"_encstr_95811C0D3D9E0ABE1DA09A8AF5A03182CAF24192862DEB3A4915C9058854", 5, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BD1805CB69C063", 200, undefined, 100, 360);
  var_4 setModel("_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23");
  var_4 thread activate_grenade_object();
  var_4 thread scripts\cp\utility::delayentdelete(30);

  if(isDefined(var_2)) {
    foreach(var_6 in level.players) {
      if(var_6 != var_2)
        var_4 hidefromplayer(var_6);
    }
  }
}

activate_grenade_object() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_0 forceplaygestureviewmodel("_encstr_837B0B872B78312B5B994A5303");
    var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");

    foreach(var_2 in var_0.powers) {
      if(var_2.slot == "_encstr_BA7F0830B3A7859B60B0") {
        var_0 notify("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", var_2.weaponuse);
        waitframe();
      }
    }

    self delete();
  }
}

is_wearing_armor() {
  if(self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    return 1;
  else if(scripts\cp\cp_modular_spawning::is_armored())
    return 1;
  else
    return 0;
}

should_do_damage_checks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    return 0;
  else if(var_0 != var_5 && isDefined(var_0.team) && var_0.team == var_5.team)
    return 0;
  else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](var_0, var_1, var_2, var_3, var_4, var_5))
    return 0;

  if(isDefined(level._id_132C6)) {
    if(isarray(level._id_132C6) && level._id_132C6.size > 0) {
      foreach(var_7 in level._id_132C6) {
        if(![[var_7]](var_0, var_1, var_2, var_3, var_4, var_5))
          return 0;
      }
    }
  }

  return 1;
}

ishighdamageweapon(var_0) {
  return var_0.classname == "_encstr_850707F7E5833355B8" || var_0.classname == "_encstr_A11804C86B39";
}

should_drop_weapon(var_0) {
  var_1 = getdvarint("_encstr_82C6165F57B679EEF833AE378EE035520FF7A37731DE22B0");

  if(var_1)
    return 1;

  if(!isDefined(level.weapon_drop_cooldown))
    return 0;

  if(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B")
    return 0;

  if(!isDefined(var_0.eattacker))
    return 0;

  var_2 = 5;
  var_3 = gettime();
  var_4 = var_0.eattacker getentitynumber();

  if(!isDefined(level.weapon_drop_cooldown[var_4])) {
    level.weapon_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  if(var_3 > level.weapon_drop_cooldown[var_4]) {
    level.weapon_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  return 0;
}

is_flashbang(var_0, var_1, var_2) {
  if(isDefined(var_1.underbarrel)) {
    var_3 = scripts\cp\utility::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "_encstr_873708FFA8104C0AAEC1" || var_3 == "_encstr_ADBD0780C4884FEE86")
      return 1;
  }

  return var_0 == "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683";
}

is_gas(var_0) {
  return var_0 == "_encstr_B8D30758E3EE7827BA";
}

callbacksoldieragentgametypedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(var_4 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  var_3 = 0;

  if(!isDefined(self.painsound)) {
    return;
  }
  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound))
      self playSound(self.painsound);

    self.next_dmg_sound = gettime() + 500;
  }
}

callbacksoldieragentgametypekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\cp\cp_agent_utils::deactivateagent();

  if(isDefined(level.spawnloopupdatefunc))
    [[level.spawnloopupdatefunc]](var_1, var_4);

  if(triggered_module_spawn()) {
    if(!istrue(self.died_poorly))
      level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self.origin, "_encstr_B6AA0DDCAEB4C64B46B27DD9599B1D", rear_spotlight(var_0, var_1, self.origin));
  }

  if(var_3 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  if(istrue(self.marked_for_death))
    self.marked_for_death = undefined;

  if(isDefined(self.isinlaststand)) {
    var_9 = spawnStruct();
    var_9.einflictor = var_0;
    var_9.eattacker = var_1;
    var_9.idamage = var_2;
    var_9.smeansofdeath = var_3;
    var_9.sweapon = var_4;
    var_9.vdir = var_5;
    var_9.shitloc = var_6;
    var_9.timeoffset = var_7;
    var_9.deathanimduration = var_8;
    thread[[self.isinlaststand]](var_9);
  }

  if(isPlayer(var_1)) {
    level notify("_encstr_A2C811D3DBDA4CD22B7DB65A36C62B32D78997", var_1);
    level thread handle_death_sounds(var_1, self, var_3);
    self.died_poorly = undefined;
    var_10 = scripts\cp\cp_endgame::get_current_zone(var_1);
    var_11 = 1;
    scripts\cp\cp_analytics::_id_119B5(var_1, self, var_4);

    if(isDefined(var_1.perk_data) && var_1 scripts\cp\utility::_hasperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC")) {
      var_12 = 10;
      var_13 = var_12 * var_1.perk_data["_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13"];
      var_1 scripts\cp\coop_super::increase_super_progress(var_13);
    }
  }

  if(scripts\cp\cp_relics::calldropbag()) {
    if(isPlayer(var_1) && isDefined(level.updateonkillrelicsfunc))
      level thread[[level.updateonkillrelicsfunc]](var_4, var_1, self, var_3, var_6);
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc))
    level thread[[level.removefromtargetmarkeronkillfunc]](self);

  if(isDefined(self.attackers)) {
    foreach(var_15 in self.attackers) {
      if(!isDefined(_validateattacker(var_15))) {
        continue;
      }
      if(var_15 == var_1) {
        continue;
      }
      if(self == var_15) {
        continue;
      }
      if(isDefined(level.assists_disabled)) {
        continue;
      }
      var_16 = undefined;

      if(isDefined(self.attackerdata)) {
        var_17 = self.attackerdata[var_15.guid];

        if(isDefined(var_17))
          var_16 = var_17.objweapon;
      }

      var_18 = 0;

      if(self.attackerdata[var_15.guid].damage >= 35)
        var_18 = 1;

      if(self.attackerdata[var_15.guid].damage >= 70)
        var_18 = 2;

      var_15 thread scripts\cp\cp_gamescore::processassist(self, var_16, var_18);
    }
  }

  give_attacker_kill_rewards(var_0, var_1, var_6, var_3, var_4);
  var_20 = 0;
  scripts\cp\cp_damagefeedback::process_damage_feedback(var_0, var_1, var_2, var_20, var_3, var_4, var_5, var_5, var_6, var_7, self);
  scripts\cp\cp_merits::process_agent_on_killed_merits(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level thread scripts\cp\utility::add_to_notify_queue("_encstr_A2300A73174102F0ACDD6159", self.origin, var_4, var_3, var_1, self, self.team);
}

_id_13C35() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_81571B92E40F2B67D31BAE2197F93799AE6660A8C6B5E33104CB3B75B8");
  self endon("_encstr_81571B92E40F2B67D31BAE2197F93799AE6660A8C6B5E33104CB3B75B8");

  for(;;) {
    level waittill("_encstr_A2300A73174102F0ACDD6159", var_0, var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(self.hostdamagefactormedium))
      self.hostdamagefactormedium = 1;
    else
      self.hostdamagefactormedium = self.hostdamagefactormedium + 1;

    thread _id_13B82();
  }
}

_id_13B82() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_87E41A37E87BC1D73AD2DACADE571DFA8DDE73CDCA8DAFDA2DD8B137");
  self endon("_encstr_87E41A37E87BC1D73AD2DACADE571DFA8DDE73CDCA8DAFDA2DD8B137");
  wait(propability());
  self.hostdamagefactormedium = undefined;
}

propability() {
  var_0 = 3;

  if(scripts\cp\utility::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"))
    var_0 = var_0 + 3;

  return var_0;
}

handle_death_sounds(var_0, var_1, var_2) {
  if(!scripts\engine\utility::isbulletdamage(var_2)) {
    return;
  }
  if(isDefined(var_1.deathsound) && soundexists(var_1.deathsound))
    playsoundatpos(var_1.origin, var_1.deathsound);

  var_3 = var_1;

  if(var_2 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
    var_3 playsoundtoplayer("_encstr_8C69178993738990ABEF7B7BE8D6984D17DAE1116AD73388C3", var_0);
    var_3 playsoundtoteam("_encstr_8DB01B26BAC68DACD1EB2DB683B0D81DEBD095858CDC43F63AD7CDE036", var_0.team, var_0);
  } else {
    var_3 playsoundtoplayer("_encstr_8C6C0E55704FEF130843A03F39E9234B", var_0);
    var_3 playsoundtoteam("_encstr_AA1917D607EB432DE8F5161B5993E8FACCB49BC263F5DCE0B1", var_0.team, var_0);
  }
}

give_attacker_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(self.team) && isDefined(var_1.team) && self.team == var_1.team) {
    return;
  }
  if(!isDefined(self.agent_type)) {
    return;
  }
  var_5 = scripts\mp\mp_agent::get_agent_type(self);
  var_6 = getdvarint("_encstr_81B31A0BC6CBF9362F28C804D933401BD5CB175F95A86B253D0BDD29", 0);

  if(var_6 != 0)
    var_7 = var_6;
  else
    var_7 = level.agent_definition[var_5]["_encstr_8F9F07D3D81FB62369"];

  var_8 = level.agent_definition[var_5]["_encstr_B607032B8B"];
  var_9 = 0;
  var_10 = triggered_module_spawn();
  var_11 = isDefined(var_4) && (var_4.basename == "_encstr_820C138A68F01BCA4484A8CA5AB9B1C23DE2B185B0" || var_4.basename == "_encstr_812F0FA3D5B11865FB9F2B2B4FF2A07058");

  if(isDefined(var_1.classname) && var_1.classname == "_encstr_956B0F193B6244C0659AE65B464C78857B") {
    if(isDefined(level.consumable_cash_scalar))
      var_12 = var_7 * (level.cash_scalar + level.consumable_cash_scalar);
    else
      var_12 = var_7 * level.cash_scalar;

    foreach(var_14 in level.players) {
      if(!var_14 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(isDefined(level.zombie_xp))
        var_14 scripts\cp\cp_persistence::give_player_xp(int(var_8));

      if(istrue(level.special_event)) {
        continue;
      }
      var_15 = "_encstr_8DEC06B1E943615B";
      var_2 = "_encstr_8BBA05185F8B99";
      var_14 scripts\cp\cp_persistence::give_player_currency(var_12, var_15, var_2, 1, "_encstr_B25C08A0DB7AF28BFB04");
    }

    return;
  }

  if(!isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
    return;
  }
  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
    var_9 = 1;
  }

  if(!var_11 && (var_5 == "_encstr_A26D0F9F2BE801D84F2197E54F2B9AC26A" || var_5 == "_encstr_AF150C1032FAC1C6DB57897639CF" || var_5 == "_encstr_BD290B12AAEF6618171787E740")) {
    if(scripts\cp\utility::isheadshot(var_4, var_2, var_3, var_1) && !var_9 && scripts\engine\utility::isbulletdamage(var_3) && !var_10) {
      var_7 = int(100);
      var_8 = int(75);
    }

    if(isDefined(var_3) && var_3 == "_encstr_8DED0A21C79B660BC7588981" && !issubstr(var_4.basename, "_encstr_961904BF105A")) {
      var_7 = int(130);
      var_8 = int(100);
    }
  }

  if(isPlayer(var_1)) {
    if(!istrue(var_1.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"]) && (scripts\cp\cp_weapon::iscacprimaryweapon(var_4) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_4))) {
      if(!isDefined(var_1.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"]))
        var_1.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] = 1;
      else
        var_1.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"]++;

      if(var_1.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] > scripts\cp\cp_weaponrank::reload_use_think()) {
        var_1.pers["_encstr_AF8417A8EFCBC71DDB0F0F46D8B5D8EBF82B0E301607D5533E"] = 1;
        var_1.pers["_encstr_A743160C1A128338F593613C3B48D9A7E5DD92AFEB79E17E"] = undefined;
        var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"] = undefined;
      } else {
        if(!isDefined(var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]))
          var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"] = [];

        var_17 = scripts\cp\utility::getweaponrootname(var_4);
        var_18 = 0;

        foreach(var_21, var_20 in var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"]) {
          if(var_21 == var_17) {
            var_20.killcount++;
            var_18 = 1;
            break;
          }
        }

        if(!var_18) {
          var_20 = spawnStruct();
          var_20.killcount = 1;
          var_20.basename = var_4.basename;
          var_20._id_1213C = var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"].size;
          var_1.pers["_encstr_86BE0FC00A8579CBEBD58E14AD57D3376D"][var_17] = var_20;
        }
      }
    }
  }

  if(isDefined(level.kill_reward_func))
    var_7 = [[level.kill_reward_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_7);

  if(isDefined(var_7))
    givekillreward(var_0, var_1, var_7, var_8, "_encstr_8DEC06B1E943615B", var_2, var_4, var_3);
}

givekillreward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level.consumable_cash_scalar))
    var_2 = var_2 * (level.cash_scalar + level.consumable_cash_scalar);
  else
    var_2 = var_2 * level.cash_scalar;

  var_1 thread giveplayerbonuscash(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 scripts\cp\cp_persistence::record_player_kills(var_6, var_5, var_7, var_1);

  if(isDefined(self.shared_damage_points)) {
    foreach(var_9 in level.players) {
      if(!var_9 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(level.special_event)) {
        continue;
      }
      var_9 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1, "_encstr_B25C08A0DB7AF28BFB04");
    }
  } else if(should_get_currency_from_kill(var_0, var_1, var_6))
    var_1 scripts\cp\cp_persistence::give_player_currency(var_2, var_4, var_5, 1);

  if(!scripts\cp\utility::tryingtoleave())
    var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_ABD70578F3D02C", var_6, undefined, undefined, self);
}

giveplayerbonuscash(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(should_get_currency_from_kill(var_0, var_1, var_6)) {
    if(var_1 scripts\cp\utility::is_consumable_active("_encstr_B4E615F1A3E3DA0E5E9B0D2B4280A537111B981A70E99F") && scripts\engine\utility::isbulletdamage(var_7) && var_6.classname == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" && checkaltmodestatus(var_6)) {
      var_8 = 300;

      if(var_6 == "_encstr_91A61703A703317E63AAFB01E2E7BC886B0DE7A75D7E904853")
        var_1 scripts\cp\utility::notify_used_consumable("_encstr_B4E615F1A3E3DA0E5E9B0D2B4280A537111B981A70E99F");
      else {
        var_1 scripts\cp\utility::notify_used_consumable("_encstr_B4E615F1A3E3DA0E5E9B0D2B4280A537111B981A70E99F");
        var_1 thread delaygivecurrency(var_8, var_4, var_5, "_encstr_B2B20686D0C0C3EB", 0.15);
      }
    }

    if(isPlayer(var_1) && isDefined(var_1.cash_scalar)) {
      if(isDefined(var_1.cash_scalar_weapon) && var_1.cash_scalar_weapon == scripts\cp\utility::getrawbaseweaponname(var_6)) {
        var_9 = int(var_2 * var_1.cash_scalar - var_2);
        var_1 thread delaygivecurrency(var_9, var_4, var_5, "_encstr_B2B20686D0C0C3EB", 0.25);
      }

      if(isDefined(var_1.cash_scalar_alt_weapon) && var_1.cash_scalar_alt_weapon == scripts\cp\utility::getrawbaseweaponname(var_6) && istrue(var_6.isalternate) && istrue(var_1.alt_mode_passive)) {
        var_9 = int(var_2 * var_1.cash_scalar - var_2);
        var_1 thread delaygivecurrency(var_9, var_4, var_5, "_encstr_B2B20686D0C0C3EB", 0.25);
      }
    }
  }
}

delaygivecurrency(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_4);
  scripts\cp\cp_persistence::give_player_currency(var_0, var_1, var_2, 1, var_3);
}

should_get_currency_from_kill(var_0, var_1, var_2) {
  if(isPlayer(var_1) && scripts\cp\cp_laststand::player_in_laststand(var_1))
    return 0;

  if(scripts\cp\utility::is_trap(var_0, var_2))
    return 0;

  if(istrue(level.special_event))
    return 0;

  return 1;
}

checkaltmodestatus(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  var_1 = scripts\cp\utility::getbaseweaponname(var_0);

  switch (var_1) {
    case "_encstr_AA41072DEEDCEBAD1C":
      if(scripts\cp\utility::isaltmodeweapon(var_0))
        return 0;
      else
        return 1;
    default:
      return 1;
  }
}

addattacker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isDefined(var_1.guid) && (isagent(var_1) || isPlayer(var_1)))
    var_1.guid = var_1 scripts\cp\utility\player::getuniqueid();

  if(!isDefined(var_1.guid)) {
    return;
  }
  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hitcount = 1;
  } else
    var_0.attackerdata[var_1.guid].hitcount++;

  if(scripts\cp\cp_weapon::iscacprimaryweapon(var_3) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var_3))
    var_0.attackerdata[var_1.guid].diddamagewithprimary = 1;

  if(isDefined(var_9) && var_9 != "_encstr_8DED0A21C79B660BC7588981")
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;

  var_10 = scripts\cp\utility::getequipmenttype(var_3.basename);

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

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon))
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon()))
    var_0.attackerdata[var_1.guid].sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
  else
    var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

rear_spotlight(var_0, var_1, var_2) {
  if(isPlayer(var_1))
    return var_1.name;

  if(isPlayer(var_0))
    return var_0.name;

  if(isDefined(var_0.owner) && isPlayer(var_0.owner))
    return var_0.owner.name;

  var_3 = scripts\engine\utility::getclosest(var_2, level.players);
  return var_3.name;
}

_validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_0) && !isDefined(var_0.classname))
    return undefined;

  return var_0;
}