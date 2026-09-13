/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\dev.gsc
***********************************************/

init() {}

reflectionprobe_hide_hp() {}

reflectionprobe_hide_front() {}

gotonextspawn() {}

gotoprevspawn() {}

devaliengiveplayersmoney() {}

spam_points_popup() {
  _id_88B5EFD806F46560 = ["stat_FC56E889052D3823", "stat_F751297C1A2FA2A9", "stat_9501A62017D709D3", "stat_DAB63315ABCDB6B4", "stat_A0880A9CE131DEA8", "stat_F42B79A30529BA75", "stat_A3A0144007C5F9F2"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_88B5EFD806F46560.size; _id_AC0E594AC96AA3A8++) {
    thread scripts\mp\rank::scorepointspopup(100);
    thread scripts\mp\rank::scoreeventpopup(_id_88B5EFD806F46560[_id_AC0E594AC96AA3A8]);
    wait 2.0;
  }
}

devlistinventory() {
  _id_6686D1519FD59C8D = getDvar("scr_list_inventory", "");

  if(_id_6686D1519FD59C8D != "") {
    _id_9D709D44ADD4A33A = devfindhost();

    if(!isDefined(_id_9D709D44ADD4A33A)) {
      return;
    }
    list = undefined;
    msg = undefined;
    _id_E314B4412AFF817A = 0;

    if(_id_6686D1519FD59C8D == "all") {
      msg = "all weapons";
      list = _id_9D709D44ADD4A33A getweaponslistall();
    } else if(_id_6686D1519FD59C8D == "primaryCurrent") {
      msg = "current weapon";
      _id_E314B4412AFF817A = 1;
      list = [_id_9D709D44ADD4A33A getcurrentweapon()];
    } else {
      msg = _id_6686D1519FD59C8D + " inventory";
      list = _id_9D709D44ADD4A33A getweaponslist(_id_6686D1519FD59C8D);
    }

    _id_9D709D44ADD4A33A devprintweaponlist(list, msg, _id_E314B4412AFF817A);
  }
}

devprintweaponlist(list, msg, _id_9E0CCD1AD796B167) {
  if(isDefined(list) && list.size > 0) {
    foreach(weapon in list) {
      clipammo = self getweaponammoclip(weapon);
      stockammo = self getweaponammostock(weapon);
      _id_8DB846BFDBD95DFD = "" + getcompleteweaponname(weapon) + " " + clipammo + "/" + stockammo;

      if(_id_9E0CCD1AD796B167)
        iprintlnbold(_id_8DB846BFDBD95DFD);
    }
  } else {}
}

_id_4E64AE8B36808971() {
  for(;;) {
    _id_775635EB25C3C213 = getdvarint("dvar_4FA4D9014BDC9130", 0);

    if(_id_775635EB25C3C213) {
      setDvar("dvar_4FA4D9014BDC9130", 0);
      player = devfindhost();
      _id_9C08B7361B58E75F = player scripts\mp\utility\weapon::_launchgrenade("shock_stick_mp", player.origin, (0, 0, 0), undefined, 1);
      _id_9C08B7361B58E75F._id_8BF83D28BE4C2D4F = _id_7EF95BBA57DC4B82::getequipmenttableinfo("equip_shockstick");
      player scripts\mp\weapons::grenadeinitialize(_id_9C08B7361B58E75F, makeweapon("shock_stick_mp"), 0, player);
      _id_9C08B7361B58E75F setscriptablepartstate("electric", "active", 0);
      _id_9C08B7361B58E75F setscriptablepartstate("detonate", "detonate", 0);
      _id_9C08B7361B58E75F thread _id_0A35012B9B75A996::_id_F47AB824A48FE570();
    }

    wait 0.25;
  }
}

devgivesuperthink() {
  for(;;) {
    super = getDvar("scr_givesuper", "");

    if(super != "") {
      foreach(player in level.players)
      player scripts\mp\supers::givesuper(super, 0, 1);
    }

    if(getdvarint("scr_super_short_cooldown", 0) != 0) {
      foreach(player in level.players) {
        if(isbot(player)) {
          continue;
        }
        if(!isDefined(player scripts\mp\supers::getcurrentsuper())) {
          continue;
        }
        if(player scripts\mp\supers::issupercharging())
          player scripts\mp\supers::givesuperpoints(player scripts\mp\supers::getsuperpointsneeded() * 0.25);
      }
    }

    wait 0.25;
  }
}

_id_41316FCA284326CE() {
  _id_8D1C8465D1AC3312 = 0;
  state = 0;

  for(;;) {
    _id_9D709D44ADD4A33A = devfindhost();
    _id_CB1E30930C35F2E2 = getdvarint("dvar_E8F85992B38B6EA8", 0);

    if(_id_CB1E30930C35F2E2 != state) {
      if(_id_CB1E30930C35F2E2) {
        if(!_id_8D1C8465D1AC3312) {
          _id_B4AF32DC208A0BC9 = 1;
          _id_9D709D44ADD4A33A thread scripts\mp\equipment\nvg::runnvg();
        }

        _id_9D709D44ADD4A33A _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("devForceNVG");
      } else
        _id_9D709D44ADD4A33A _id_3B64EB40368C1450::set("devForceNVG", "nvg", 0);
    }

    wait 0.25;
  }
}

_id_48721E21935095F2() {
  for(;;) {
    _id_DB69E7387CD0E20B = getdvarint("dvar_DDCFD9CB21DD26DC", 0);

    if(_id_DB69E7387CD0E20B == 1) {
      _id_9D709D44ADD4A33A = devfindhost();

      if(isDefined(_id_9D709D44ADD4A33A) && scripts\mp\utility\player::isreallyalive(_id_9D709D44ADD4A33A)) {
        if(istrue(_id_9D709D44ADD4A33A.disguised))
          _id_9D709D44ADD4A33A thread _id_7C03AB87C5F9F420::_id_3EDE6B66136C0F93();
        else
          _id_9D709D44ADD4A33A thread _id_7C03AB87C5F9F420::_id_C2AFDDB38BD47F6F();
      }
    }

    wait 0.25;
  }
}

_id_1C94018FF6BA8037() {
  for(;;) {
    _id_EBEC497FF8B18A45 = getDvar("dvar_45AD785835521A20", "");

    if(_id_EBEC497FF8B18A45 != "") {
      switch (_id_EBEC497FF8B18A45) {
        case "super_tac_camera":
          devfindhost() _id_15CBA36F180AB171::_id_4F7FC48F506A21F3();
          break;
        default:
          break;
      }
    }

    wait 0.25;
  }
}

_id_8AB3C5933D589588() {
  for(;;) {
    equipmentref = getDvar("dvar_24FC46AAB8E515D3", "");

    if(equipmentref != "")
      devfindhost() _id_1FA444CDC9DBF364::_id_AC625F4C2BF0906B(equipmentref);

    wait 0.25;
  }
}

devgivefieldupgradethink() {
  for(;;) {
    super = getDvar("dvar_3617AC10E688070E", "");

    if(super != "") {
      foreach(player in level.players) {
        if(!isbot(player)) {
          if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
            player _id_7E52B56769FA7774::forcegivesuper(super, 1, 0, 0, 0);
            continue;
          }

          player scripts\mp\perks\perkpackage::perkpackage_givedebug(super);
        }
      }
    }

    wait 0.25;
  }
}

_id_05AB0CAE02A1A189() {
  for(;;) {
    super = getDvar("dvar_69B7311657D28A29", "");

    if(super != "") {
      _id_56BF136CD6AEC447 = level.superglobals.staticsuperdata[super].weapon;

      if(!isDefined(_id_56BF136CD6AEC447))
        _id_56BF136CD6AEC447 = "super_default_mp";

      _id_641083E829D5514C = makeweapon(_id_56BF136CD6AEC447);

      foreach(ent in level.characters) {
        if(!isbot(ent) || !isalive(ent) || ent.sessionstate != "playing") {
          continue;
        }
        ent scripts\mp\perks\perkpackage::perkpackage_givedebug(super);

        if(isDefined(ent.super)) {
          if(!isnullweapon(_id_641083E829D5514C) && _id_641083E829D5514C.basename != "super_default_mp")
            ent scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(_id_641083E829D5514C);

          ent thread scripts\mp\supers::trysuperusebegin(_id_641083E829D5514C);
        }
      }
    }

    wait 0.25;
  }
}

_id_9A2083C197D32F9E() {
  for(;;) {
    equipment = getDvar("dvar_C1FA6AB185F57DC3", "");

    if(equipment != "") {
      _id_536D1CDBD17666D4 = level.equipment.table[equipment].weaponname;

      if(isDefined(_id_536D1CDBD17666D4)) {
        _id_E5845FF9B61AC5D7 = makeweapon(_id_536D1CDBD17666D4);

        foreach(ent in level.characters) {
          if(!isbot(ent) || !isalive(ent) || ent.sessionstate != "playing") {
            continue;
          }
          ent scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(_id_E5845FF9B61AC5D7);
        }
      }
    }

    wait 0.25;
  }
}

_id_D5F799537D36BF4E() {
  for(;;) {
    perkname = getDvar("dvar_7395B2297287B659", "");

    if(perkname != "") {
      foreach(ent in level.characters) {
        if(!isbot(ent) || !isalive(ent) || ent.sessionstate != "playing") {
          continue;
        }
        ent scripts\mp\utility\perk::giveperk(perkname);
      }
    }

    wait 0.25;
  }
}

_id_25DF3BAE5EC9502C() {
  for(;;) {
    _id_A4E8372932B8612C = getDvar("dvar_20C7A16D77382D2B", "");

    if(_id_A4E8372932B8612C != "") {
      if(isDefined(_id_A4E8372932B8612C) && _id_A4E8372932B8612C != "") {
        foreach(ent in level.characters) {
          if(!isbot(ent) || !isalive(ent) || ent.sessionstate != "playing") {
            continue;
          }
          streakname = _id_A4E8372932B8612C;
          streaksetupinfo = scripts\mp\killstreaks\killstreaks::getkillstreaksetupinfo(streakname);

          if(isDefined(streaksetupinfo) && scripts\cp_mp\utility\killstreak_utility::getkillstreakindex(streakname) != -1) {
            ent scripts\mp\killstreaks\killstreaks::awardkillstreak(streakname, "other");
            ent scripts\mp\killstreaks\killstreaks::forceactivategimmekillstreak();
          }
        }
      }
    }

    wait 0.25;
  }
}

devfindhost() {
  _id_9D709D44ADD4A33A = undefined;

  foreach(player in level.players) {
    if(player ishost()) {
      _id_9D709D44ADD4A33A = player;
      break;
    }
  }

  return _id_9D709D44ADD4A33A;
}

watchlethaldelaycancel() {
  for(;;) {
    if(getdvarint("scr_lethaldelaycancel", 0)) {
      scripts\mp\equipment::cancellethaldelay();
      return;
    }

    wait 1.0;
  }
}

watchsuperdelaycancel() {
  for(;;) {
    if(getdvarint("scr_superdelaycancel", 0)) {
      scripts\mp\supers::cancelsuperdelay();
      return;
    }

    wait 1.0;
  }
}

watchslowmo() {
  for(;;) {
    if(getDvar("scr_slowmo") != "") {
      break;
    }

    wait 1;
  }

  time = getdvarfloat("scr_slowmo");
  setslowmotion(time, time, 0.0);
  thread watchslowmo();
}

rangefinder() {
  thread scripts\mp\rangefinder::runmprangefinder();
}