/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2473.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "init")]]();
  }

  level._effect["airdrop_crate_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["airdrop_crate_capture"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepackage_base_fx_fade.vfx");
  level._effect["airdrop_crate_capture_valentines"] = loadfx("vfx/s4/killstreaks/vfx_valentines_carepackage_base_fx_fade.vfx");
  level._effect["airdrop_death"] = loadfx("vfx/s4/explosion/vfx_airdrop_explosion.vfx");
  level._id_326D = getEntArray("carepackage_drop_area", "targetname");
  _id_8202();
  _id_81A9();
  _id_8173();

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    level._effect["jeep_sparkle_trail"] = loadfx("vfx/s4/vehicle/s1_veh_xmas_santas_jeep_trail.vfx");
    level._effect["jeep_reindeer_dogs"] = loadfx("vfx/s4/vehicle/s1_veh_xmas_santas_jeep_dogs.vfx");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleInit")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleInit")]]();
  }
}

_id_8202() {}

_id_81A9() {
  level._id_9593 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerScoreInfo")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerScoreInfo")]]();
  }
}

_id_8173() {
  var_0 = spawnStruct();
  var_0._id_3B74 = [];
  var_0._id_3E9B = [];
  var_0._id_FDB3 = [];
  level._id_3E85 = var_0;
  level._id_A2B5 = scripts\common\utility::_id_152F;
  level._id_3E85._id_A1C0 = getent("care_package_col", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerActionSet")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerActionSet")]]();
  }

  var_2 = "mp";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  switch (var_2) {
    case "cp_wave_sv":
    case "cp_survival":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getGameModeSpecificCrateData")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getGameModeSpecificCrateData")]]();
      }
    case "br":
      _id_814B();
      _id_814C();
      _id_814A();
      _id_814D();
    case "arm":
      _id_8139();
      _id_8203();
      _id_814B();
    case "base":
      _id_8147();
      _id_8203();
    case "grnd":
      _id_8188();
    default:
      _id_8203();
  }

  _id_8174();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerPlayerFrameUpdateCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerPlayerFrameUpdateCallback")]](::_id_F3F9);
  }

  thread _id_10A8A();
}

_id_6B00(var_0) {
  var_1 = level._id_3E85._id_3B74[var_0];

  if(!isDefined(var_1)) {
    var_1 = _id_69FA();
    level._id_3E85._id_3B74[var_0] = var_1;
  }

  return var_1;
}

_id_69FA() {
  var_0 = spawnStruct();
  var_0._id_5FB8 = "vm_equip_gen_care_package_00";
  var_0._id_5420 = "vm_equip_gen_care_package_00";
  var_0._id_508A = "vm_equip_gen_care_package_00";

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_0._id_508A = "vm_equip_gen_care_package_01";
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_0._id_508A = "vm_equip_gen_care_package_02";
  }

  var_0._id_73B9 = 27.5;
  var_0._id_A1C0 = _id_69D5();
  var_0.objweapon = _func_0375();
  var_0._id_F224 = 90;
  var_0._id_75F5 = 20;
  var_0._id_75EE = 10000;
  var_0._id_75F4 = 400;
  var_0._id_9F23 = "icon_minimap_carepackage";
  var_0._id_FEDB = "tag_use";
  var_0._id_FEB0 = 128;
  var_0._id_2B9C = 30625;
  var_0._id_FE72 = 360;
  var_0._id_04C7 = 0;
  var_0._id_ADB3 = 0.5;
  var_0._id_AC9F = 3;
  var_0._id_5FBF = 0;
  var_0._id_A3E6 = (30, 10, 64);
  var_0._id_A3E8 = 64;
  var_0._id_4348 = 1000;
  var_0._id_434B = 128;
  var_0._id_0EE7 = undefined;
  var_0._id_438A = undefined;
  var_0._id_3227 = undefined;
  var_0._id_C58C = undefined;
  var_0._id_4841 = undefined;
  var_0._id_485D = 1;
  var_0._id_AABE = 0;
  var_0._id_4866 = _id_69D0();
  var_0._id_4867 = _id_69D1();
  var_0._id_3237 = _id_69CE();
  var_0._id_3238 = _id_69CF();
  var_0._id_3234 = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var_0._id_C58F = &"KILLSTREAKS_HINTS/UAV_REROLL";
  var_0._id_75E9 = "hud_icon_head_killstreak_carepackage";
  var_0._id_EB9F = 0;
  var_0._id_EB9E = 1;
  var_0._id_EB9D = 1;
  return var_0;
}

_id_757E(var_0) {
  return isDefined(level._id_3E85._id_3B74[var_0]);
}

createcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_6B00(var_2);

  if(var_9._id_EB9E) {}

  if(var_9._id_EB9F) {}

  var_10 = spawn("script_model", var_3);
  var_10.angles = var_4;

  if(!istrue(var_7) && var_2 != "battle_royale_c130_loot" || var_2 != "battle_royale_loadout") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
      if(var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
        var_10 delete();
        return undefined;
      }
    }
  }

  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.objweapon = var_9.objweapon;
  var_10.cratetype = var_2;
  var_10._id_FE92 = undefined;
  var_10._id_A3E5 = undefined;
  var_10._id_75F3 = undefined;
  var_10._id_9F26 = undefined;
  var_10._id_4349 = undefined;
  var_10._id_A3E7 = undefined;
  var_10._id_4823 = var_5;
  var_10._id_75EB = 0;
  var_10._id_9F25 = 0;
  var_10._id_758C = istrue(var_6);
  var_10._id_B04F = 0;
  var_10._id_87FB = 0;
  var_10._id_4350 = var_8;
  var_10._id_75E9 = var_9._id_75E9;
  var_10._id_9F23 = var_9._id_9F23;
  var_10._id_3234 = var_9._id_3234;
  var_10._id_C58F = var_9._id_C58F;
  var_10._id_EB9F = var_9._id_EB9F;
  var_10 setModel(var_9._id_508A);
  var_10 hide();
  var_10 setnodeploy(1);
  var_10 setCanDamage(0);
  var_10 makeunusable();
  var_10 _meth_86FE("killstreak");
  var_10 _meth_8851(3, var_1);

  if(level.teambased) {
    var_10 _meth_8706(var_10.team);
  } else {
    var_10 _meth_8706(var_10.owner);
  }

  var_11 = undefined;

  if(isDefined(var_9._id_5FB8)) {
    var_11 = spawn("script_model", var_3);
    var_11.angles = var_4;
    var_11._id_3E6D = var_10;
    var_11 setModel(var_9._id_5FB8);

    if(scripts\mp\utility\game::isholidayenabled(2) || scripts\mp\utility\game::isholidayenabled(3)) {
      var_11 setModel(var_9._id_508A);
    }

    var_11 linkto(var_10);
    var_10._id_357A = [var_11];
  } else
    var_11 = var_10;

  var_10._id_5FB8 = var_11;
  var_12 = undefined;

  if(isDefined(var_9._id_5420)) {
    if(level.teambased) {} else {}

    var_12 = spawn("script_model", var_3);
    var_12.angles = var_4;
    var_12._id_3E85 = var_10;
    var_12 setModel(var_9._id_5420);

    if(scripts\mp\utility\game::isholidayenabled(2) || scripts\mp\utility\game::isholidayenabled(3)) {
      var_12 setModel(var_9._id_508A);
    }

    var_12 linkto(var_10);
  }

  var_10._id_5420 = var_12;

  if(isDefined(var_10._id_5420)) {
    var_10 thread _id_10C28();
  }

  var_13 = undefined;

  if(!var_10._id_758C) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "br") {
        var_13 = spawn("script_model", var_3 + (0, 0, 300));
        var_13 _meth_8375("explosive");

        if(isDefined(self._id_CBD0)) {
          if(var_7) {
            var_13 thread _id_984C(var_10, (0, 0, 0));
          } else {
            var_13 linkto(var_10);
          }
        }
      }
    }
  }

  if(isDefined(var_10.owner)) {
    var_10.owner._id_8857 = 1;
  }

  var_10.killcament = var_13;
  var_10 _id_4019();
  var_10 _id_1161();

  if(!scripts\engine\utility::is_equal(level.script, "mp_bm_tut")) {
    var_10 thread _id_10AB8();
  }

  if(var_10._id_758C) {
    var_10 _id_0EE9();
  } else if(var_7) {
    var_10 _id_3E99();
  }

  return var_10;
}

_id_0EE9() {
  _id_0EE8(1);
}

_id_0EE8(var_0) {
  self notify("activateCrate");

  if(istrue(self._id_485C)) {
    thread _id_4843();
    return;
  }

  _id_0BA9();
  self notify("crate_dropped");

  if(istrue(self._id_10813)) {
    self waittill("objective_activate");
  }

  if(istrue(var_0) && self.cratetype != "battle_royale_loadout" && !istrue(self._id_DDB4)) {
    _id_4012();
  }

  var_1 = spawn("script_model", self gettagorigin("tag_use"));
  var_1 setModel("tag_origin");
  var_1.team = self.team;
  var_1._id_75E9 = self._id_75E9;
  var_1._id_4B06 = self._id_4B06;
  var_1._id_75F3 = self._id_75F3;
  var_1.cratetype = self.cratetype;
  var_1.owner = self.owner;
  var_1 _id_0BA8();
  self._id_ED6B = var_1;
  _id_99E4();
  var_2 = _id_6B00(self.cratetype);

  if(isDefined(var_2._id_0EE7)) {
    self thread[[var_2._id_0EE7]](var_0);
  }
}

_id_438B(var_0) {
  if(istrue(var_0)) {
    _id_4859();
  }

  if(isDefined(self._id_ED6B)) {
    self._id_ED6B _id_0BBA();
  }

  _id_99E3();
  var_1 = _id_6B00(self.cratetype);

  if(isDefined(var_1._id_438A)) {
    self thread[[var_1._id_438A]](var_0);
  }
}

_id_322A(var_0) {
  var_1 = _id_6B00(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner._id_8857)) {
    self.owner._id_8857 = 0;
  }

  if(isDefined(var_1._id_3227)) {
    self thread[[var_1._id_3227]](var_0);
  }

  if(level.gametype == "base") {
    var_0 thread scripts\mp\hud_message::showsplash("nuke_crate_pickedup", 1);
  }

  if(var_1._id_485D) {
    var_2 = 0;
    thread _id_084C::carepackage_open(var_0, self.owner);

    if(isDefined(var_1._id_3237)) {
      self thread[[var_1._id_3237]](self._id_5FB8);

      if(isDefined(self._id_5420)) {
        self thread[[var_1._id_3237]](self._id_5420);
      }

      var_2 = var_1._id_3238;
    }

    thread _id_4760(var_2);
  }
}

_id_4843(var_0) {
  if(istrue(self._id_87FB)) {
    return;
  }
  if(!isDefined(var_0)) {
    if(isDefined(self._id_CBD0)) {
      if(isDefined(self._id_18A1)) {
        if(gettime() >= self._id_18A1) {
          self._id_485C = 1;
          return;
        } else
          var_0 = 1;
      }
    } else if(istrue(self._id_B04F)) {
      if(!istrue(self._id_B052)) {
        self._id_485C = 1;
        return;
      }
    }
  }

  self._id_485C = undefined;
  var_1 = _id_6B00(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner._id_8857)) {
    self.owner._id_8857 = 0;
  }

  if(isDefined(var_1._id_4841)) {
    self thread[[var_1._id_4841]](var_0);
  }

  if(!istrue(var_0)) {
    var_2 = undefined;

    if(!istrue(self._id_B04F) || !istrue(self._id_B052)) {
      if(isDefined(var_1._id_4866)) {
        self thread[[var_1._id_4866]](self._id_5FB8);

        if(isDefined(self._id_5420)) {
          self thread[[var_1._id_4866]](self._id_5420);
        }

        var_2 = var_1._id_4867;
      }
    } else if(isDefined(var_1._id_3237)) {
      self thread[[var_1._id_3237]](self._id_5FB8);

      if(isDefined(self._id_5420)) {
        self thread[[var_1._id_3237]](self._id_5420);
      }

      var_2 = var_1._id_3238;
    }

    thread _id_4760(var_2);
  } else
    thread _id_4761();
}

_id_4760(var_0) {
  if(istrue(self._id_87FB)) {
    return;
  }
  self notify("death");
  self._id_87FB = 1;
  var_1 = isDefined(self._id_5FB8) && self._id_5FB8 != self;

  if(isDefined(self._id_CBD0)) {
    if(isDefined(self._id_CBD0._id_3E9B)) {
      self._id_CBD0._id_3E9B[self getentitynumber()] = undefined;
    }

    if(isDefined(self._id_CBD0._id_3E6D)) {
      self._id_CBD0._id_3E6D = undefined;
    }

    self._id_CBD0 = undefined;
  }

  _id_C4AD(self getentitynumber());
  self _meth_86FF("killstreak");
  self setCanDamage(0);
  self _meth_8359(1);

  if(var_1) {
    self hide();
  }

  _id_99E3();

  if(isDefined(self._id_FE92)) {
    self._id_FE92 delete();
  }

  _id_4845();
  _id_0BBB();
  _id_485B();
  _id_3E98();
  _id_4859();

  if(isDefined(self._id_ED6B)) {
    self._id_ED6B _id_0BBA();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  wait(var_0);

  if(var_1) {
    self._id_5FB8 delete();
  }

  if(isDefined(self._id_5420)) {
    self._id_5420 delete();
  }

  self delete();
}

_id_4761() {
  var_0 = level._id_5F3A;

  if(isDefined(self _meth_86EB()) && self _meth_8679("visibility")) {
    self setscriptablepartstate("visibility", "hide", 1);
  }

  _id_4760(var_0);
}

_id_10AB8() {
  self endon("death");
  var_0 = _id_6B00(self.cratetype);

  if(istrue(self._id_A443) || istrue(var_0._id_A443)) {
    return;
  }
  if(isDefined(var_0._id_F224)) {}

  _id_10AB9(var_0._id_F224);
  thread _id_4843();
}

_id_10AB9(var_0) {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(var_0)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  } else {
    level waittill("forever");
  }
}

_id_4844() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread _id_4843();
    }
  }
}

_id_8174() {
  var_0 = spawnStruct();
  var_0._id_77D9 = [];
  var_0._id_77BC = 4000;

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_0._id_77BC = 1500;
  }

  var_0._id_77BD = 128;
  level._id_3E86 = var_0;
  _id_8287();
}

_id_8287() {
  _id_8286();
}

#using_animtree("script_model");

_id_8286() {
  level._id_CC34["care_package"] = #animtree;
  level._id_CC31["care_package"]["care_package_drop"] = % mp_carepackage_ckpg_flyin;
  level._id_CC32["care_package"]["care_package_drop"] = "mp_carepackage_ckpg_flyin";
  level._id_CC34["care_package_chute"] = #animtree;
  level._id_CC31["care_package_chute"]["care_package_drop"] = % mp_carepackage_parachute_flyin;
  level._id_CC32["care_package_chute"]["care_package_drop"] = "mp_carepackage_parachute_flyin";
  level._id_CC34["care_package"] = #animtree;
  level._id_CC31["care_package"]["care_package_freefall"] = % s4_mp_nuke_crate_drop;
  level._id_CC32["care_package"]["care_package_freefall"] = "s4_mp_nuke_crate_drop";
  level._id_CC3E["care_package"]["care_package_freefall"] = 0;
}

_id_8288() {}

_id_8154() {}

_id_B159(var_0, var_1, var_2, var_3, var_4, var_5) {
  return createcrate(var_0, var_1, var_2, var_3, var_4, undefined, 1, 0, var_5);
}

_id_5028(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_5)) {
    var_7 = _id_6995(var_3, 0);
    var_5 = _id_6996(var_7, _id_6994(var_7, 0));
  }

  return createcrate(var_0, var_1, var_2, var_3, var_4, var_5, undefined, 1, var_6);
}

_id_5029(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_3 = _id_6995(var_3, 1);
  var_9 = var_3[2];

  if(!isDefined(var_7)) {
    var_7 = _id_6996(var_3, _id_6994(var_3, 1));

    if(!isDefined(var_7)) {
      return undefined;
    }
  }

  var_10 = spawnStruct();
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10._id_7590 = isDefined(var_0);
  var_4 = var_4 * (0, 1, 0);
  var_11 = var_3 + -1 * anglesToForward(var_4) * var_5;
  var_10._id_5055 = var_3;
  var_10._id_578A = var_3 + anglesToForward(var_4) * var_6;
  var_12 = undefined;

  if(isDefined(var_8)) {
    var_12 = var_8._id_10315;
  }

  var_13 = _id_3FEB(var_0, var_1, var_11, var_4, var_12);
  var_13._id_5066 = var_10;
  var_10._id_766D = var_13;
  var_14 = createcrate(var_0, var_1, var_2, var_11, var_13.angles, var_7, undefined, 0, var_8);
  var_14._id_5066 = var_10;
  var_14 linkto(var_13, "tag_origin", (16, 0, -156), (0, 0, 0));
  var_10._id_3E6D = var_14;
  var_10 thread _id_10ACE();
  return var_10;
}

_id_10ACE() {
  self endon("death");
  _id_10ACF();

  if(isDefined(self._id_3E6D)) {
    self._id_3E6D thread _id_4843();
  }

  if(isDefined(self._id_766D)) {
    self._id_766D thread _id_4852();
  }
}

_id_10ACF() {
  if(self._id_7590) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  self._id_766D setvehgoalpos(self._id_5055, 1);
  self._id_766D scripts\engine\utility::_id_108F5("death", 2);

  if(!isDefined(self._id_766D) || istrue(self._id_766D._id_87FB)) {
    thread _id_4C50();
    return;
  }

  self._id_766D setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self._id_766D.origin, self._id_5055) > 5184) {
    self._id_766D scripts\engine\utility::waittill_any_2("death", "goal");

    if(!isDefined(self._id_766D) || istrue(self._id_766D._id_87FB)) {
      thread _id_4C50();
      return;
    }

    self._id_766D scripts\engine\utility::_id_108F5("death", 0.25);

    if(isDefined(self._id_3E6D) && !istrue(self._id_3E6D._id_87FB)) {
      thread _id_4C50();
    }

    if(!isDefined(self._id_766D) || istrue(self._id_766D._id_87FB)) {
      return;
    }
    self._id_766D scripts\engine\utility::_id_108F5("death", 0.5);

    if(!isDefined(self._id_766D) || istrue(self._id_766D._id_87FB)) {
      return;
    }
    if(distancesquared(self._id_766D.origin, self._id_578A) > 5184) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          self._id_766D vehicle_setspeed(100, 60);
        } else {
          self._id_766D vehicle_setspeed(150, 50);
        }
      }

      self._id_766D setvehgoalpos(self._id_578A, 1);
      self._id_766D scripts\engine\utility::waittill_any_2("death", "goal");
    }
  }
}

_id_4C50() {
  var_0 = self._id_3E6D;
  self._id_3E6D._id_5066 = undefined;
  self._id_3E6D = undefined;
  var_0 _id_3E99();
}

_id_3FB8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = createcrate(var_0, var_1, var_2, var_8.origin, var_8.angles, var_3, var_4, var_5, var_6);

  if(!isDefined(var_12)) {
    return undefined;
  }

  var_12.streakinfo = var_7;

  if(!isDefined(var_8._id_3E9B)) {
    var_8._id_3E9B = [];
  }

  var_8._id_3E9B[var_12 getentitynumber()] = var_12;
  var_12._id_5FB8 hide();

  if(isDefined(var_12._id_5420)) {
    var_12._id_5420 hide();
  }

  if(var_2 == "base_nuke") {
    var_12._id_9F23 = level.leveldata._id_9F23;
  }

  if(ischutecratetype(var_2) || isanimatedfreefallcratetype(var_2)) {
    var_12._id_CBD0 = var_11;
    var_12._id_5FB8 setscriptablepartstate("visibility", "hide", 0);

    if(isDefined(var_12._id_5420)) {
      var_12._id_5420 setscriptablepartstate("visibility", "hide", 0);
    }

    var_12._id_18AF = var_9;
    var_12 _id_06C6::_id_D47B();
    var_13 = level._id_CC31[var_9][var_10];
    var_14 = _func_0079(var_13) * 1000;
    var_12._id_18A1 = gettime() + 10000;
    var_12._id_18E6 = gettime() + _func_00BB(var_13, "carepackage_trail_end")[0] * var_14;
    var_12._id_18A4 = gettime() + var_14;

    if(isDefined(var_11._id_90D5)) {
      var_11._id_90D5 = scripts\engine\utility::ter_op(var_12._id_18A4 > var_11._id_90D5, var_12._id_18A4, var_11._id_90D5);
    } else {
      var_11._id_90D5 = var_12._id_18A4;
    }
  }

  return var_12;
}

_id_3FAD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0._id_3702)) {
    var_0._id_3702 = [];
  }

  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.origin;
  var_4._id_CBD0 = var_0;
  var_4._id_3E6D = var_1;
  var_4._id_3E81 = var_1._id_18A1;
  var_0._id_3702[var_4 getentitynumber()] = var_4;
  var_4 setModel("veh8_mil_lnd_carepackage_parachute");
  var_4 setscriptablepartstate("visibility", "hide", 0);
  var_4._id_18AF = var_2;
  var_4 _id_06C6::_id_D47B();
  var_5 = level._id_CC31[var_2][var_3];
  var_6 = _func_0079(var_5) * 1000;
  var_4._id_18A4 = gettime() + _func_0079(level._id_CC31[var_2][var_3]) * 1000;
  var_4._id_18F4 = gettime() + _func_00BB(var_5, "chute_unhide")[0] * var_6;
  var_4._id_18A4 = gettime() + var_6;

  if(isDefined(var_0._id_90D5)) {
    var_0._id_90D5 = scripts\engine\utility::ter_op(var_4._id_18A4 > var_0._id_90D5, var_4._id_18A4, var_0._id_90D5);
  } else {
    var_0._id_90D5 = var_4._id_18A4;
  }

  var_4 setscriptablepartstate("visibility", "hide", 0);
  return var_4;
}

_id_4842() {
  if(isDefined(self._id_CBD0)) {
    self._id_CBD0._id_3702[self getentitynumber()] = undefined;
  }

  self delete();
}

_id_502A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var_8 = _id_6995(var_3, 1);
  var_9 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = _id_6996(var_8, _id_6994(var_8, 1));

    if(!isDefined(var_5)) {
      return undefined;
    }
  }

  if(ischutecratetype(var_2) || isanimatedfreefallcratetype(var_2)) {
    var_10 = spawn("script_model", var_5 + (0, 0, 1300));
    var_10.angles = var_9;
    var_10 setModel("tag_origin");
    var_10.owner = var_0;
    var_10.team = var_1;
    var_10._id_7590 = isDefined(var_0);
  } else
    var_10 = undefined;

  var_11 = undefined;

  if(isDefined(var_6)) {
    var_11 = var_6._id_10315;
  }

  var_12 = _id_3FEB(var_0, var_1, var_8, var_9, var_11, var_7);

  if(!isDefined(var_12)) {
    return undefined;
  }

  var_13 = _id_3FB8(var_0, var_1, var_2, var_5, undefined, 0, var_6, var_7, var_12, "care_package", "care_package_drop", var_10);

  if(!isDefined(var_13)) {
    return undefined;
  }

  if(ischutecratetype(var_2)) {
    var_14 = _id_3FAD(var_10, var_13, "care_package_chute", "care_package_drop");

    if(!isDefined(var_14)) {
      scripts\engine\utility::_id_5598("No chute created for " + var_2);
      return undefined;
    }
  }

  var_12 thread _id_10AD0(var_8, var_3);
  return var_12;
}

_id_10AD0(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  _id_10AD1(var_0, var_1);
  self delete();
}

_id_10AD1(var_0, var_1) {
  level endon("game_ended");
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = 70000;
  var_4 = 19.5;
  var_5 = 1300;
  var_6 = 700;

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_3 = 32000;
    var_4 = 35;
    var_5 = 850;
    var_6 = 400;
  }

  var_7 = var_0 - var_2 * var_3 / 2.0;
  var_8 = var_0 + var_2 * var_3 / 2.0;
  self.origin = var_7;
  self moveto(var_8, var_4);
  var_9 = var_3 / var_4;
  var_10 = getdvarfloat("#x33c01342f08fa6256");
  var_11 = 150;
  var_12 = 4000 - var_11;
  var_13 = _func_0218(var_12 / (var_10 * 0.5));
  var_14 = var_9 * var_13;
  var_14 = var_14 - var_5;
  var_15 = var_0 - var_2 * var_14;
  var_16 = length(var_15 - var_7) / var_9;

  if(self._id_3E9B.size == 3) {
    var_15 = var_15 - var_2 * var_6;
  }

  var_17 = 0;

  foreach(var_19 in self._id_3E9B) {
    if(isDefined(var_19)) {
      if(ischutecratetype(var_19.cratetype)) {
        var_19._id_CBD0 _id_06C6::_id_17C2(var_19, "care_package_drop");

        foreach(var_21 in var_19._id_CBD0._id_3702) {
          var_19._id_CBD0 _id_06C6::_id_17C2(var_21, "care_package_drop");
        }

        continue;
      }

      if(isanimatedfreefallcratetype(var_19.cratetype)) {
        var_23 = 1;
        continue;
      }

      var_19.origin = var_15 + var_2 * var_17 * var_6 + (0, 0, -1) * var_11;
      var_19.linearvelocity = var_2 * var_9;
      var_19.angularvelocity = rotatevector((cos(var_17 * 90) * 1.5, 40, 0), self.angles);
      var_17++;
    }
  }

  wait(var_16);

  foreach(var_19 in self._id_3E9B) {
    if(isDefined(var_19)) {
      if(ischutecratetype(var_19.cratetype)) {
        var_19 thread docratechuteanimation();
        continue;
      }

      if(isanimatedfreefallcratetype(var_19.cratetype)) {
        wait 3;
        var_19 thread dofreefallanimation();
        continue;
      }

      var_19 show();
      var_19 physicslaunchserver();
      var_26 = var_19 _meth_846E(0);
      _func_034A(var_26, var_19.linearvelocity[0], var_19.linearvelocity[1], var_19.linearvelocity[2], var_19.angularvelocity[0], var_19.angularvelocity[1], var_19.angularvelocity[2]);
      wait(var_6 / var_9);
      var_19._id_B04F = 1;
      var_19 _id_3FBA();
      var_19 _id_3953();
      var_19 thread _id_A0F6();
      var_19 thread _id_A118();
      var_19 thread _id_A132();
    }
  }

  wait(var_4 - var_16);
}

docratechuteanimation(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 show();
  var_1 = [var_0];

  foreach(var_3 in var_0._id_CBD0._id_3702) {
    var_3 setscriptablepartstate("visibility", "show", 0);
    var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  var_0._id_CBD0 _id_06C6::_id_183B(var_1, "care_package_drop");

  foreach(var_3 in var_0._id_CBD0._id_3702) {
    var_3 delete();
  }

  var_0._id_CBD0._id_3702 = undefined;
  var_0._id_CBD0 thread docratechutedropfromscripted(var_0);
}

dofreefallanimation(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 show();
  var_1 = [var_0];
  var_0._id_CBD0 _id_06C6::_id_183B(var_1, "care_package_freefall");
  var_0._id_CBD0 thread docratechutedropfromscripted(var_0, (0, 0, -1900));
}

docratechutedropfromscripted(var_0, var_1) {
  var_0._id_18AF = undefined;
  var_0 _meth_83EC();
  _id_4C51(var_0, var_1);
}

_id_4C51(var_0, var_1) {
  var_0._id_CBD0 = undefined;

  if(isDefined(self._id_3E9B)) {
    self._id_3E9B[var_0 getentitynumber()] = undefined;
  }

  var_0._id_18A4 = undefined;
  var_0._id_18A1 = undefined;
  var_0._id_18E6 = undefined;
  var_0 notify("anim_finished");
  var_2 = var_0 gettagorigin("tag_use") - var_0.origin;
  var_0 _id_3E99(var_2, var_1);
}

_id_6995(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1)) {
    var_2 = var_0 * (1, 1, 1) + (0, 0, _id_6D15());
  } else {
    var_2 = var_0 + (0, 0, 25);
  }

  return var_2;
}

_id_6994(var_0, var_1) {
  return var_0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var_1), 8000, 8000));
}

_id_6996(var_0, var_1) {
  var_2 = undefined;
  var_3 = physics_createcontents(["physicscontents_itemclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
  var_4 = _id_6997();
  var_5 = _func_02C1(var_0, var_1, var_3, var_4, 0, "physicsquery_closest", 1);

  if(isDefined(var_5) && var_5.size > 0) {
    var_2 = var_5[0]["position"];
  }

  return var_2;
}

_id_6997() {
  if(isDefined(level._id_3E85._id_77D9) && isDefined(level._id_3E85._id_0E45)) {
    return scripts\engine\utility::_id_1B9B([level._id_3E86._id_77D9, level._id_3E86._id_0E45, level._id_3E85._id_3E9B]);
  } else {
    return scripts\engine\utility::_id_1B9B([level._id_3E86._id_77D9, level._id_3E85._id_3E9B]);
  }
}

_id_3FEB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = "plane_juniform52_00";

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_7 = "plane_juniform52_00";
  }

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_7 = "suv_gamma503_xmas_00";
  }

  var_6 = spawn("script_model", var_2);
  var_6.angles = var_3;
  var_6 setModel(var_7);
  var_6.owner = var_0;
  var_6.team = var_1;

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    playFXOnTag(level._effect["jeep_sparkle_trail"], var_6, "tag_fx");
    playFXOnTag(level._effect["jeep_reindeer_dogs"], var_6, "tag_dog_00");
    thread _id_084C::_id_3262(var_6);
  } else
    thread _id_084C::_id_3262(var_6);

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop", "Killstreak_Air", var_0, 0, 0);
    }

    if(var_1 != "neutral" && scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentient", "registerSentient")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentient", "registerSentient")]]("Killstreak_Air", var_0);
    }
  }

  var_6 setCanDamage(1);
  var_6._id_873F = 1;
  var_6 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "monitorDamage")]](1000, "hitequip", ::_id_7434, undefined, 1);

  if(scripts\mp\utility\game::isbasegametype()) {
    var_6 setCanDamage(0);
  }

  return var_6;
}

_id_10B7C() {
  self endon("death");
  _id_10B7D();
  thread _id_4852();
}

_id_10B7D() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  level waittill("forever");
}

_id_7434(var_0) {
  var_1 = var_0.attacker;
  _id_4852();
}

_id_4852() {
  var_0 = anglesToForward(self.angles);
  playFX(level._effect["airdrop_death"], self.origin, var_0);
  thread _id_084C::plane_explode(self.origin);
  thread _id_4770(0);
}

_id_4770(var_0) {
  self notify("death");
  self._id_87FB = 1;

  if(isDefined(self._id_CBD0)) {
    self._id_CBD0._id_766D = undefined;
    self._id_CBD0 = undefined;
  }

  _id_C4CF(self getentitynumber());
  wait(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_4853(var_0) {
  _id_4852();
}

_id_6D16() {
  return level._id_3E86._id_77BC;
}

_id_6D15() {
  return _id_6D16() + level._id_3E86._id_77D9.size * level._id_3E86._id_77BD;
}

_id_10BA(var_0) {
  var_1 = var_0 getentitynumber();
  level._id_3E86._id_77D9[var_1] = var_0;
}

_id_C4CF(var_0) {
  level._id_3E86._id_77D9[var_0] = undefined;
}

_id_99E4() {
  var_0 = _id_6B00(self.cratetype);

  if(istrue(var_0._id_758A)) {
    return;
  }
  level._id_3E85._id_FDB3[self getentitynumber()] = self;
  self._id_8AC3 = 1;

  if(var_0._id_EB9E && var_0._id_EB9D) {
    thread _id_10ABE(1);
    var_1 = self._id_FE92;

    if(!isDefined(var_1)) {
      var_1 = spawn("script_model", self gettagorigin(var_0._id_FEDB));
      var_1 setModel("tag_origin");
      var_1 linkto(self);
      var_1 makeunusable();
      self._id_FE92 = var_1;
    }

    thread _id_10ABE(2, var_1);
  } else if(var_0._id_EB9E)
    thread _id_10ABE(1);
  else {
    thread _id_10ABE(2);
  }
}

_id_10ABE(var_0, var_1) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  if(var_0 == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
    self.owner._id_8857 = 1;
  }

  var_2 = _id_6B00(self.cratetype);
  var_3 = _id_6E00(var_1);
  var_3._id_FEED = var_0;
  var_3 setcursorhint("HINT_NOICON");
  var_3 _meth_84D9("show");
  var_3 _meth_84D7(var_2._id_FEDB);
  var_3 _meth_84D4(var_2._id_FEB0);
  var_3 sethintdisplayfov(var_2._id_FE72);
  var_3 setuserange(var_2._id_FEB0);
  var_3 setusefov(var_2._id_FE72);
  var_3 _meth_83A1(var_2._id_04C7);
  var_3 setuseholdduration("duration_none");

  if(var_3._id_FEED == 1 && self._id_EB9F) {
    var_3 sethintstring(self._id_C58F);
  } else {
    var_3 sethintstring(self._id_3234);
  }

  var_3._id_FEB1 = 1;
  var_3._id_4143 = 0;

  if(isDefined(var_3._id_FEE9)) {
    var_3._id_FEE7 = var_3._id_FEE9;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_3._id_FEE7 = scripts\engine\utility::ter_op(var_0 == 1, var_2._id_ADB3, var_2._id_AC9F);
  }

  var_3._id_84EF = 0;
  var_3._id_B80E = undefined;

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(_id_31E3(var_4, var_1)) {
      _id_E738(var_4, var_1);
      var_4._id_8857 = 1;
      var_3._id_B80E = var_4;
      var_5 = _id_10ABF(var_4, var_1);

      if(isDefined(var_4)) {
        _id_E949(var_4, var_1);
      }

      var_4._id_8857 = 0;
      var_3._id_B80E = undefined;

      if(istrue(var_5)) {
        if(var_2._id_AABE && self.cratetype != "battle_royale_loadout") {
          if(!isDefined(self._id_B790)) {
            self._id_B790 = [];
          }

          self._id_B790[var_4 getentitynumber()] = var_4;
        }

        if(!isDefined(self._id_0481) || self._id_0481 != "btm_flag_primary_inside") {
          thread _id_322A(var_4);
        }
      }
    }
  }
}

_id_10ABF(var_0, var_1) {
  var_2 = _id_6E00(var_1);

  if(var_2._id_FEED != 1) {
    var_0 endon("disconnect");
    var_0 endon("joined_team");
    var_0 endon("joined_spectators");
  }

  var_2._id_7C8C = "care_package";
  var_2._id_FEB1 = scripts\engine\utility::ter_op(isDefined(var_0._id_A8EC), var_0._id_A8EC, 1);
  _id_B916(var_0, var_1);

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && _id_3190(var_0, var_1) && var_0 usebuttonpressed()) {
    var_2._id_4143 = var_2._id_4143 + level._id_5F3A * var_2._id_FEB1;

    if(var_2._id_4143 >= var_2._id_FEE7) {
      var_2._id_4143 = 0.0;
      return 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 1);
    }

    waitframe();
  }

  var_2._id_4143 = 0.0;
  return 0;
}

_id_99E3() {
  self notify("makeCrateUnusable");
  level._id_3E85._id_FDB3[self getentitynumber()] = undefined;
  self._id_8AC3 = 0;

  if(isDefined(self._id_B80E)) {
    _id_E949(self._id_B80E);
  }

  self._id_B80E = undefined;
  self makeunusable();

  if(isDefined(self._id_FE92)) {
    if(isDefined(self._id_FE92._id_B80E)) {
      _id_E949(self._id_FE92._id_B80E, self._id_FE92);
    }

    self._id_FE92 makeunusable();
  }
}

_id_E738(var_0, var_1) {
  var_2 = _id_6E00(var_1);
  var_3 = _id_6B00(self.cratetype);
  var_4 = getdvarint("#x382fa2a2b8a12fe7f", 1);

  if(var_4) {
    var_0 thread _id_137D();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 0);
  }
}

_id_137D() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = makeweapon("s4_ks_care_package_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  thread _id_13A2(var_0);
  self switchtoweapon(var_0);
}

_id_13A2(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("crate_use_end");

  if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    self switchtoweapon(self._id_8FC2);
  }
}

_id_E949(var_0, var_1) {
  var_2 = _id_6E00(var_1);
  var_3 = _id_6B00(self.cratetype);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 0);
  }

  _id_E948(var_0, var_1);
  var_0 notify("crate_use_end");
}

_id_31E3(var_0, var_1, var_2) {
  if(!var_0 scripts\common\utility::_id_858A()) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0 isonladder()) {
    return 0;
  }

  if(!var_0 isonground()) {
    return 0;
  }

  if(isDefined(self._id_B790) && isDefined(self._id_B790[var_0 getentitynumber()])) {
    return 0;
  }

  if(istrue(self._id_8A60)) {
    if(isDefined(self._id_B7E9) && scripts\engine\utility::array_contains(self._id_B7E9, var_0)) {
      return 0;
    }

    if(var_0._id_E496 != self._id_E496 || var_0.team != self.team) {
      return 0;
    }
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "botIsKillstreakSupported")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "grnd" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "botIsKillstreakSupported")]](self.cratetype)) {
          return 0;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "isKillstreakBlockedForBots")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "isKillstreakBlockedForBots")]](self.cratetype)) {
        return 0;
      }
    }
  }

  if(!self._id_8AC3) {
    return 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    return _id_31E4(var_0, var_1);
  }

  if(level.gametype == "br" && var_0 isskydiving()) {
    return 0;
  }

  if(self.cratetype == "base_nuke" && level.gametype == "base" && scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, var_0)) {
    return 0;
  }

  if(istrue(var_0.inlaststand)) {
    return 0;
  }

  return 1;
}

_id_31E4(var_0, var_1) {
  var_2 = _id_6E00(var_1);

  if(isDefined(var_2._id_B80E) && var_2._id_B80E != var_0) {
    return 0;
  }

  if(var_2._id_FEED == 1 && (!isDefined(self.owner) || var_0 != self.owner)) {
    return 0;
  }

  if(var_2._id_FEED == 2 && (isDefined(self.owner) && var_0 == self.owner)) {
    return 0;
  }

  if(level.teambased && isDefined(self.team) && self.team != "neutral") {
    var_3 = _id_6B00(self.cratetype);

    if(var_3._id_5FBF && var_0.team != self.team) {
      return 0;
    }
  }

  return 1;
}

_id_3190(var_0, var_1) {
  if(!scripts\common\utility::_id_858A()) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0 meleebuttonpressed()) {
    return 0;
  }

  if(var_0 _meth_86C9()) {
    return 0;
  }

  if(istrue(var_0.inlaststand)) {
    return 0;
  }

  var_2 = _id_6B00(self.cratetype);

  if(isDefined(var_2._id_2B9C) && distancesquared(var_0.origin, _id_6E00(var_1).origin) >= var_2._id_2B9C) {
    return 0;
  }

  if(!self._id_8AC3) {
    return 0;
  }

  return 1;
}

_id_99E5(var_0, var_1) {
  var_0 _meth_80E0(var_1);

  if(isDefined(var_0._id_FE92)) {
    var_0._id_FE92 _meth_80E0(var_1);
  }

  if(!var_0 _id_31E3(var_1, var_0._id_FE92, 0)) {
    var_0 disableplayeruse(var_1);

    if(isDefined(var_0._id_FE92)) {
      var_0._id_FE92 disableplayeruse(var_1);
    }
  } else {
    if(!var_0 _id_31E4(var_1, undefined)) {
      var_0 disableplayeruse(var_1);
    }

    if(isDefined(var_0._id_FE92)) {
      if(!var_0 _id_31E4(var_1, var_0._id_FE92)) {
        var_0._id_FE92 disableplayeruse(var_1);
      }
    }
  }
}

_id_10A8B() {
  for(;;) {
    foreach(var_1 in level._id_3E85._id_FDB3) {
      if(!isDefined(var_1)) {
        thread scripts\engine\utility::_id_5598("airdrop crate was deleted incorrectly.");
        continue;
      }

      var_1 makeuseable();
      var_1 _meth_879B();

      if(isDefined(var_1._id_FE92)) {
        var_1._id_FE92 makeuseable();
        var_1._id_FE92 _meth_879B();
      }

      var_2 = level.players;

      if(level.teambased && isDefined(var_1.team) && var_1.team != "neutral") {
        var_3 = _id_6B00(var_1.cratetype);

        if(var_3._id_5FBF) {
          var_2 = level._id_EF6A[var_1.team]["alivePlayers"];
        }
      }

      foreach(var_5 in var_2) {
        var_6 = distancesquared(var_1.origin, var_5.origin) < 57600.0;

        if(var_6) {
          _id_99E5(var_1, var_5);
        }
      }
    }

    wait 0.1;
  }
}

_id_10A8A() {
  if(getdvarint("#x3fbbe89bf412bff2f", 0)) {
    thread _id_10A8B();
    return;
  }

  for(;;) {
    foreach(var_1 in level._id_3E85._id_FDB3) {
      if(!isDefined(var_1)) {
        thread scripts\engine\utility::_id_5598("airdrop crate was deleted incorrectly.");
        continue;
      }

      var_1 makeuseable();

      if(isDefined(var_1._id_FE92)) {
        var_1._id_FE92 makeuseable();
      }

      foreach(var_3 in level.players) {
        _id_99E5(var_1, var_3);
      }
    }

    wait 0.1;
  }
}

_id_B916(var_0, var_1) {
  var_2 = _id_6E00(var_1);
}

_id_E948(var_0, var_1) {
  var_2 = _id_6E00(var_1);
}

_id_6E00(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, self);
}

_id_3E99(var_0, var_1) {
  var_2 = _id_6B00(self.cratetype);

  if(isDefined(var_2._id_3E9A)) {
    self thread[[var_2._id_3E9A]]();
  }

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  self unlink();
  self physicslaunchserver();
  var_3 = self _meth_846E(0);
  _func_034A(var_3, var_1[0], var_1[1], var_1[2], 0, 0, 0);
  self._id_B04F = 1;
  _id_3FBA();
  _id_3953();
  thread _id_A0F6();
  thread _id_A118();
  thread _id_A132();
}

_id_3E98() {
  if(!istrue(self._id_B04F)) {
    return;
  }
  self._id_B04F = undefined;
  self._id_B052 = undefined;
  self _meth_8545();
  _id_3953();
  _id_3925();
  _id_A119();
  _id_A133();
}

_id_D5DA() {
  self._id_A257 = undefined;
  self._id_F9A7 = ::_id_3EA1;
}

_id_3953() {
  self._id_A257 = 1;
  self._id_F9A7 = undefined;
}

_id_A0F6() {
  self endon("death");
  var_0 = 0.1;
  thread _id_A0F5(var_0, 8);
  var_1 = 0;
  var_2 = 0;
  var_3 = 1;
  var_4 = undefined;
  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) {
    var_5 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated");
  }

  for(;;) {
    var_6 = _id_68EF();
    var_7 = _id_68ED();

    if(isDefined(var_6) && isDefined(var_7)) {
      if(var_6 <= 5.0 && var_7 <= 1.0) {
        var_1++;
        var_2 = 0;

        if(var_1 == 6) {
          self._id_B052 = 1;
          var_4 = self.origin;
          thread _id_0EE8(var_3);

          if(isDefined(var_5) && [[var_5]]()) {
            _id_A119();

            if(isDefined(self.killcament)) {
              self.killcament delete();
            }
          }

          var_0 = 0.1;
          thread _id_A0F5(var_0, 3, 3);
          var_3 = undefined;
          _id_4844();
        }
      } else {
        if(isDefined(var_4)) {
          if(distancesquared(self.origin, var_4) <= 2500) {
            wait(var_0);
            continue;
          }
        }

        var_2++;
        var_1 = 0;

        if(var_2 == 1) {
          self._id_B052 = undefined;
          thread _id_438B();
          var_0 = 0.1;
          thread _id_A0F5(var_0, 8);
        }
      }

      wait(var_0);
      continue;
    }

    waitframe();
  }
}

_id_A0F5(var_0, var_1, var_2) {
  _id_3925();
  self endon("death");
  self endon("clear_average_velocities");
  self._id_951B = [];
  self._id_1799 = [];
  self._id_103A2 = 0;
  self._id_1039A = 0;
  self._id_1039B = var_1;

  if(isDefined(var_2)) {
    var_2 = int(clamp(var_2, 0, var_1));

    if(var_2 > 0) {
      for(var_3 = 0; var_3 < var_2; var_3++) {
        self._id_951B[self._id_103A2 + var_3] = 0;
        self._id_1799[self._id_103A2 + var_3] = 0;
      }
    }
  }

  for(;;) {
    var_4 = self _meth_846E(0);
    var_5 = _func_02A1(var_4);
    var_6 = _func_02A2(var_4);
    self._id_951B[self._id_1039A] = length(var_5);
    self._id_1799[self._id_1039A] = length(var_6);
    self._id_1039A++;
    var_7 = self._id_1039A - self._id_103A2;

    if(var_7 > var_1) {
      var_8 = scripts\engine\utility::_id_9FC4(var_7, var_1);

      for(var_3 = 0; var_3 < var_8; var_3++) {
        self._id_951B[self._id_103A2 + var_3] = undefined;
        self._id_1799[self._id_103A2 + var_3] = undefined;
      }

      self._id_103A2 = self._id_103A2 + var_8;
    }

    self._id_1F9D = undefined;
    self._id_1F97 = undefined;
    wait(var_0);
  }
}

_id_68EF() {
  if(isDefined(self._id_1F9D)) {
    return self._id_1F9D;
  }

  if(!isDefined(self._id_951B)) {
    return undefined;
  }

  if(self._id_1039A - self._id_103A2 < self._id_1039B) {
    return undefined;
  }

  _id_2EDE();
  return self._id_1F9D;
}

_id_68ED() {
  if(isDefined(self._id_1F97)) {
    return self._id_1F97;
  }

  if(!isDefined(self._id_1799)) {
    return undefined;
  }

  if(self._id_1039A - self._id_103A2 < self._id_1039B) {
    return undefined;
  }

  _id_2EDE();
  return self._id_1F97;
}

_id_2EDE() {
  var_0 = 0;
  var_1 = 0;

  for(var_2 = self._id_103A2; var_2 < self._id_1039A; var_2++) {
    var_0 = var_0 + self._id_951B[var_2];
    var_1 = var_1 + self._id_1799[var_2];
  }

  self._id_1F9D = var_0 / self._id_1039B;
  self._id_1F97 = var_1 / self._id_1039B;
}

_id_3925() {
  self notify("clear_average_velocities");
  self._id_951B = undefined;
  self._id_1799 = undefined;
  self._id_1039B = undefined;
  self._id_103A2 = undefined;
  self._id_1039A = undefined;
  self._id_1F9D = undefined;
  self._id_1F97 = undefined;
}

_id_A118(var_0) {
  _id_A119();
  self endon("monitorImpactEnd");
  self._id_A11B = 1;
  self physics_registerforcollisioncallback();
  _id_A11A(var_0);

  if(isDefined(self)) {
    thread _id_A119();
  }
}

_id_A11A(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  var_1 = 0;

  for(;;) {
    self waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_10 = 0.5;
    var_11 = self _meth_846E(0);
    var_12 = _func_02A1(var_11);
    _func_0348(var_11, var_12[0] * var_10, var_12[1] * var_10, var_12[2] * var_10);

    if(isDefined(var_9) && isDefined(var_9.classname) && var_9.classname == "scriptable_iw8_chicken_01") {
      thread _id_137A(var_9);
    }

    if(isDefined(var_9) && _id_7D56(var_9)) {
      if(var_9 _id_09B5::_id_889D()) {
        var_9 thread _id_09B5::_id_786B();
      }
    }

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_13 = _func_02CA(var_5);
      var_14 = _func_00D6(var_13["name"], 9);

      if(var_14 == "user_terrain1") {
        var_14 = "user_terrain_1";
      }

      _id_B853(var_6, var_7, var_8, var_14);
    }

    if(istrue(self.breakglassonimpact)) {
      _func_00FB(self.origin, 120, 50, 45);
    }
  }
}

_id_137A(var_0) {
  self endon("death");
  var_1 = gettime();

  while(gettime() - var_1 < 3000) {
    var_0 dodamage(100, var_0.origin, self, self, "MOD_CRUSH");
    wait 0.5;
  }
}

_id_A119() {
  if(!istrue(self._id_A11B)) {
    return;
  }
  self notify("monitorImpactEnd");
  self._id_A11B = undefined;
  self _meth_84FD();
}

_id_7D56(var_0) {
  if(!istrue(self._id_B052)) {
    if(isDefined(var_0.classname)) {
      if(var_0.classname == "worldSpawn") {
        return 0;
      } else if(var_0.classname == "script_vehicle") {
        if(var_0 _id_09B5::_id_889D()) {
          var_1 = _id_6B00(self.cratetype);
          var_2 = self.origin + anglestoup(self.angles) * var_1._id_73B9;
          return var_0.origin[2] <= var_2[2];
        }
      }
    }
  }

  return 0;
}

_id_A132() {
  _id_A133();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  var_0 = self;

  if(isDefined(self._id_A1C0)) {
    var_0 = self._id_A1C0;
  }

  var_1 = undefined;

  if(isDefined(self.owner)) {
    var_1 = self.owner;
  }

  while(isDefined(var_0)) {
    var_0 waittill("player_pushed", var_2, var_3);

    if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2)) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = var_3[2] <= -8;
      var_5 = 0;
      var_6 = undefined;

      if(var_2 tagexists("j_mainroot")) {
        var_6 = var_2 gettagorigin("j_mainroot");
        var_7 = _id_6B00(self.cratetype);
        var_8 = self.origin + anglestoup(self.angles) * var_7._id_73B9;
        var_5 = var_6[2] <= var_8[2];
      }

      if(var_4 && var_5) {
        var_9 = var_1;

        if(!isDefined(var_9)) {
          var_9 = var_2;
        }

        var_2 dodamage(var_2.maxhealth * 2, var_6, var_9, self, "MOD_CRUSH", self.objweapon);
      }
    }
  }
}

_id_A133() {
  self notify("monitorPlayerImpactEnd");
}

_id_B853(var_0, var_1, var_2, var_3) {
  if(var_2 < 50) {
    return;
  }
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_0, var_1);

  if(var_2 < 150) {
    thread _id_084C::carepackage_impact_small(var_0);
  } else if(var_2 < 300) {
    thread _id_084C::carepackage_impact_med(var_0);
  } else {
    thread _id_084C::carepackage_impact_large(var_0);
  }
}

_id_3FBA() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }
  _id_4845();
  var_0 = _id_6B00(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.owner) && isDefined(self.team)) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self._id_4823, var_0._id_434B, var_0._id_4348, self.team, 30.0, self.owner, 1);
  } else if(isDefined(self.team)) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self._id_4823, var_0._id_434B, var_0._id_4348, self.team, 30.0);
  } else {
    var_1 = _id_E39E(self._id_4823, var_0._id_434B, var_0._id_4348, 30.0);
  }

  self._id_4349 = var_1;
  return var_1;
}

_id_E39E(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
    self._id_4349 = var_4;
    return var_4;
  }
}

_id_4845() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    var_0 = self._id_4349;

    if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var_0)) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var_0);
    }

    self._id_4349 = undefined;
  }
}

_id_0BA9() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
  }

  var_0 = _id_6B00(self.cratetype);
  var_1 = _func_02AF(self.origin, var_0._id_A3E6, self.angles);
  self._id_A3E7 = var_1;
  childthread _id_0DD2(var_1, self.origin, var_0._id_A3E8);
  return var_1;
}

_id_0DD2(var_0, var_1, var_2) {
  self endon("death");

  while(distancesquared(var_1, self.origin) < var_2) {
    wait 0.5;
  }

  thread _id_0BA9();
}

_id_0BBB() {
  self notify("createNavObstacle");

  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
  }

  self._id_A3E7 = undefined;
}

_id_4019() {
  var_0 = _id_6B00(self.cratetype);

  if(isDefined(var_0._id_A1C0)) {
    if(isDefined(self._id_A1C0)) {
      self._id_A1C0 delete();
    }

    if(isDefined(var_0.mountmantlemodeloffset)) {
      var_1 = var_0.mountmantlemodeloffset;
    } else {
      var_1 = (0, 0, 0);
    }

    var_2 = spawn("script_model", self.origin + var_1);
    var_2 dontinterpolate();
    var_2.angles = self.angles;
    var_2.owner = self.owner;
    var_2._id_F9A8 = 1;
    var_2.killcament = self.killcament;
    var_2._id_A1C0 = 1;
    var_2 clonebrushmodeltoscriptmodel(var_0._id_A1C0);
    var_2 linkto(self);
    self._id_A1C0 = var_2;
    var_2._id_3E6D = self;
  }
}

_id_485B() {
  if(isDefined(self._id_A1C0)) {
    self._id_A1C0 delete();
  }

  self._id_A1C0 = undefined;
}

_id_3EA1(var_0) {
  var_0 dodamage(1000, var_0.origin, self.owner, self, "MOD_CRUSH", self.objweapon);
  self endon("death");
  var_0 endon("death_or_disconnect");

  if(isPlayer(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "unresolvedCollisionNearestNode")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "unresolvedCollisionNearestNode")]](var_0, undefined, self);
    }
  }
}

_id_0BA8() {
  if(istrue(self._id_4B06)) {
    return;
  }
  _id_078F::_id_D593(self._id_75F3);
  var_0 = _id_6B00(self.cratetype);
  var_1 = undefined;

  if(isDefined(self._id_75E9)) {
    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
        var_1 = _id_078F::_id_D59B(self.team, self._id_75E9, var_0._id_75F5, 1, var_0._id_75EE, var_0._id_75F4, undefined, 1);
      }

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            _func_035F(var_1, "spectator");
          }
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
        var_1 = _id_078F::_id_D59B(self.owner, self._id_75E9, var_0._id_75F5, 1, var_0._id_75EE, var_0._id_75F4, undefined, 1);
      }

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            _func_035F(var_1, "spectator");
          }
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::_id_89EC())
      var_1 = _id_078F::_id_D59B(level._id_EF89, self._id_75E9, var_0._id_75F5, 1, var_0._id_75EE, var_0._id_75F4);
  }

  self._id_75F3 = var_1;
  self._id_75EB = 1;
  return var_1;
}

_id_0BBA() {
  _id_078F::_id_D593(self._id_75F3);
  self._id_75F3 = undefined;
  self._id_75EB = 0;
}

_id_4012() {
  _id_4859();
  var_0 = undefined;

  if(isDefined(self._id_9F23) && !istrue(self._id_10416)) {
    var_1 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
      var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
    }

    if(isDefined(var_1)) {
      if(level.teambased && isDefined(self.team)) {
        var_0 = self[[var_1]](self._id_9F23, self.team, 1, 1, 0);
      } else if(isDefined(self.owner)) {
        var_0 = self[[var_1]](self._id_9F23, undefined, 1, 1, 0);
      } else {
        var_0 = self[[var_1]](self._id_9F23, undefined, 0, 1, 0);
      }
    }
  }

  self._id_9F26 = var_0;
  self._id_9F25 = 1;
  return var_0;
}

_id_4859() {
  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }
  }

  self._id_9F26 = undefined;
  self._id_9F25 = 0;
}

_id_10C28() {
  self endon("death");

  foreach(var_1 in level.players) {
    _id_FD80(var_1);
  }

  waitframe();
  childthread _id_10C29();
}

_id_10C29() {
  for(;;) {
    level waittill("joined_team", var_0);
    _id_FD80(var_0);
  }
}

_id_FD80(var_0) {
  self._id_5FB8 hidefromplayer(var_0);
  self._id_5420 hidefromplayer(var_0);

  if(var_0.team == "spectator") {
    self._id_5FB8 showtoplayer(var_0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var_0.team == self.team) {
      self._id_5FB8 showtoplayer(var_0);
    } else {
      self._id_5420 showtoplayer(var_0);
    }

    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var_0 == self.owner) {
      self._id_5FB8 showtoplayer(var_0);
    } else {
      self._id_5420 showtoplayer(var_0);
    }

    return;
  }
}

_id_984C(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self._id_B04F)) {
    self.origin = var_0.origin + var_1;
    waitframe();
  }

  self linkto(var_0);
}

_id_1161() {
  level._id_3E85._id_3E9B[self getentitynumber()] = self;
}

_id_C4AD(var_0) {
  if(!isDefined(level._id_3E85)) {
    return;
  }
  level._id_3E85._id_3E9B[var_0] = undefined;
}

_id_6CC2(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!_func_0107(var_1)) {
      var_1 = [var_1];
    }
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;

  foreach(var_11, var_6 in var_0) {
    if(var_6 > 0) {
      var_7 = 0;

      if(isDefined(var_1)) {
        if(var_1.size > 0) {
          foreach(var_10, var_9 in var_1) {
            if(var_9 == var_11) {
              var_1[var_10] = undefined;
              var_7 = 1;
              break;
            }
          }
        } else
          var_1 = undefined;
      }

      if(!var_7) {
        var_4 = var_4 + var_6;
        var_2[var_2.size] = var_11;
        var_3[var_3.size] = var_4;
      }
    }
  }

  var_12 = randomint(var_4);
  var_11 = undefined;

  for(var_13 = 0; var_13 < var_2.size; var_13++) {
    var_4 = var_3[var_13];

    if(var_12 < var_4) {
      var_11 = var_2[var_13];
      break;
    }
  }

  return var_11;
}

_id_69CE() {
  return::_id_45A7;
}

_id_69CF() {
  return 0.7;
}

#using_animtree("scriptables");

_id_45A7(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self._id_8815)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _func_0079(%mp_military_carepackage_straps_falling);

  if(isDefined(var_1)) {
    var_1 = max(0, var_1 - 0.05);
  }

  var_0 setscriptablepartstate("anims", "capture", 0);
  var_0 setscriptablepartstate("capture", "start", 0);
  var_2 = "airdrop_crate_capture";

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_2 = "airdrop_crate_capture_codmas";
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_2 = "airdrop_crate_capture_valentines";
  }

  playFX(scripts\engine\utility::getfx(var_2), getgroundposition(self.origin, 0.05), anglesToForward(self.angles + (0, 180, 0)), anglestoup(self.angles + (0, 180, 0)));
}

flipcrate(var_0) {
  var_1 = _func_02D7(self _meth_846E(0));
  self waittill("monitorPlayerImpactEnd");
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.angles = self.angles;
  self linkto(var_2);
  var_3 = self.owner getplayerangles(1);
  var_4 = var_2.angles;
  var_5 = var_3 - (0, 90, 0);
  var_6 = var_2.origin;
  var_7 = getgroundposition(var_2.origin, 0.05) + (0, 0, length(var_1 - self.origin));
  var_8 = 50;
  var_9 = 0;
  var_10 = var_0 * 1000;
  var_11 = gettime();
  var_12 = var_11 + var_10;

  while(var_9 < 1) {
    var_2.origin = _func_025E(var_6, var_7, var_9) + (0, 0, sin(var_9 * 180) * var_8);
    var_2.angles = _func_031A(var_4, var_5, var_9);
    var_9 = (gettime() - var_11) / var_10;
    waitframe();
  }

  var_2.origin = var_7;
  var_2.angles = var_5;
  self hide();
}

_id_69D1() {
  return 0;
}

_id_69D0() {
  return::_id_45AC;
}

_id_45AC(var_0) {}

_id_69D5() {
  return level._id_3E85._id_A1C0;
}

_id_6BB2() {
  if(!isDefined(level._id_3E85)) {
    return 0;
  }

  return level._id_3E85._id_3E9B.size;
}

_id_F3F9() {
  if(!isDefined(self._id_5511)) {
    if(self _meth_81CE()) {
      var_0 = self _meth_815A();

      if(isDefined(var_0) && isDefined(var_0._id_3E6D)) {
        self._id_550F = var_0;
        self._id_5510 = var_0._id_3E6D;
      }

      self._id_5511 = gettime() + 1000;
    }
  } else if(gettime() >= self._id_5511) {
    self._id_550F = undefined;
    self._id_5510 = undefined;
    self._id_5511 = undefined;
  } else {
    foreach(var_2 in level._id_3E85._id_3E9B) {
      if(isDefined(var_2) && istrue(var_2._id_B04F) && !istrue(var_2._id_B052)) {
        if(isDefined(self._id_550F)) {
          if(isDefined(var_2._id_A1C0)) {
            if(self._id_550F != var_2._id_A1C0) {
              if(self istouching(var_2._id_A1C0)) {
                self._id_550F = undefined;
                self._id_5510 = undefined;
                self._id_5511 = undefined;

                if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
                  self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
                } else {
                  self suicide();
                }

                return;
              }
            }
          }

          if(self._id_5510 != var_2) {
            if(self istouching(var_2)) {
              self._id_550F = undefined;
              self._id_5510 = undefined;
              self._id_5511 = undefined;

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
                self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
              } else {
                self suicide();
              }

              return;
            }
          }
        } else if(self istouching(var_2) || isDefined(var_2._id_A1C0) && self istouching(var_2._id_A1C0)) {
          self._id_550F = undefined;
          self._id_5510 = undefined;
          self._id_5511 = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
            self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
          } else {
            self suicide();
          }

          return;
        }
      }
    }
  }
}

_id_AD4A(var_0) {
  if(isDefined(self._id_3234) && self._id_3234 == var_0) {
    return;
  }
  self._id_3234 = var_0;
  var_1 = [self];

  if(isDefined(self._id_FE92)) {
    var_1[var_1.size] = self._id_FE92;
  }

  foreach(var_3 in var_1) {
    if(!self._id_EB9F || var_3._id_FEED == 2) {
      var_3 sethintstring(self._id_3234);
    }
  }
}

_id_AD5C(var_0) {
  if(isDefined(self._id_C58F) && self._id_C58F == var_0) {
    return;
  }
  self._id_C58F = var_0;
  var_1 = [self];

  if(isDefined(self._id_FE92)) {
    var_1[var_1.size] = self._id_FE92;
  }

  foreach(var_3 in var_1) {
    if(self._id_EB9F && var_3._id_FEED == 1) {
      var_3 sethintstring(self._id_C58F);
    }
  }
}

_id_AD51(var_0) {
  if(!isDefined(self._id_75E9) && !isDefined(var_0)) {
    return;
  }
  if(isDefined(self._id_75E9) && isDefined(var_0) && self._id_75E9 == var_0) {
    return;
  }
  if(!isDefined(var_0)) {
    self._id_75E9 = undefined;

    if(isDefined(self._id_ED6B)) {
      self._id_ED6B _id_0BBA();
    }
  } else {
    self._id_75E9 = var_0;

    if(self._id_75EB) {
      if(isDefined(self._id_75F3)) {
        _func_0355(self._id_75F3, var_0);
      } else {
        _id_0BA8();
      }
    }
  }
}

_id_AD55(var_0) {
  if(!isDefined(self._id_9F23) && !isDefined(var_0)) {
    return;
  }
  if(isDefined(self._id_9F23) && isDefined(var_0) && self._id_9F23 == var_0) {
    return;
  }
  if(!isDefined(var_0)) {
    self._id_9F23 = undefined;
    _id_4859();
  } else {
    self._id_9F23 = var_0;

    if(self._id_9F25) {
      if(isDefined(self._id_9F26) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "updateObjectiveIcon")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "updateObjectiveIcon")]](self._id_9F26, var_0);
      } else {
        _id_4012();
      }
    }
  }
}

_id_AD5F(var_0) {
  if(self._id_EB9F == var_0) {
    return;
  }
  self._id_EB9F = var_0;

  if(self._id_EB9F) {
    var_1 = [self];

    if(isDefined(self._id_FE92)) {
      var_1[var_1.size] = self._id_FE92;
    }

    foreach(var_3 in var_1) {
      if(var_3._id_FEED == 1) {
        var_3 sethintstring(self._id_C58F);
      }
    }
  }
}

_id_8203() {
  level._id_3E85._id_8E54 = [];
  level._id_3E85._id_8E4D = [];
  level._id_3E85._id_8E52 = [];
  var_0 = ::_id_8DCA;
  var_1 = ::_id_8DCB;
  var_2 = _id_6B00("killstreak");
  var_2._id_0EE7 = var_0;
  var_2._id_3227 = var_1;
  var_2 = _id_6B00("killstreak_no_owner");
  var_2._id_0EE7 = var_0;
  var_2._id_3227 = var_1;
  var_2._id_EB9E = 0;
  var_2._id_5420 = undefined;
  var_3 = getdvarint("#x3dc5d37554c267193", 0) || getdvarint("#x3af4635af5e253c51", 0);

  if(var_3) {
    _id_10DC("intel", undefined, undefined, 100);
    _id_10DC("lmg_streak", undefined, undefined, 100);
    _id_10DC("uav", undefined, undefined, 80);
    _id_10DC("counter_spy_plane", undefined, undefined, 80);
    _id_10DC("mortar_barrage", undefined, undefined, 60);
    _id_10DC("glide_bomb", undefined, undefined, 60);
    _id_10DC("warmachine", undefined, undefined, 40);
    _id_10DC("attack_dogs", undefined, undefined, 10);
  } else {
    _id_10DC("intel", undefined, undefined, 100);
    _id_10DC("lmg_streak", undefined, undefined, 100);
    _id_10DC("guard_dog", undefined, undefined, 100);
    _id_10DC("uav", undefined, undefined, 80);
    _id_10DC("counter_spy_plane", undefined, undefined, 80);
    _id_10DC("mortar_barrage", undefined, undefined, 60);
    _id_10DC("glide_bomb", undefined, undefined, 60);
    _id_10DC("precision_airstrike", undefined, undefined, 40);
    _id_10DC("warmachine", undefined, undefined, 40);
    _id_10DC("attack_dogs", undefined, undefined, 10);
  }

  game["dialog"]["airdrop_hijacked"] = "mp_glob_kill_bchr_cpea";
}

_id_8188() {
  level._id_3E85._id_8E54 = [];
  level._id_3E85._id_8E4D = [];
  level._id_3E85._id_8E52 = [];
  var_0 = ::_id_8DCA;
  var_1 = ::_id_8DCB;
  var_2 = _id_6B00("killstreak");
  var_2._id_0EE7 = var_0;
  var_2._id_3227 = var_1;
  var_2 = _id_6B00("killstreak_no_owner");
  var_2._id_0EE7 = var_0;
  var_2._id_3227 = var_1;
  var_2._id_EB9E = 0;
  var_2._id_5420 = undefined;
  var_3 = 0;
  _id_10DC("intel", undefined, undefined, 100);
  _id_10DC("uav", undefined, undefined, 100);
  _id_10DC("lmg_streak", undefined, undefined, 100);
  _id_10DC("counter_spy_plane", undefined, undefined, 100);
  _id_10DC("guard_dog", undefined, undefined, 100);
  _id_10DC("precision_airstrike", undefined, undefined, 100);
  _id_10DC("glide_bomb", undefined, undefined, 100);
  _id_10DC("toma_strike", undefined, undefined, 50);
  _id_10DC("warmachine", undefined, undefined, 50);
  _id_10DC("attack_dogs", undefined, undefined, 20);
}

_id_8204(var_0) {
  waittillframeend;
  var_1 = scripts\engine\utility::ter_op(_id_09D6::_id_9422(), var_0, 0);
  _id_10DC("bradley", undefined, undefined, var_1);
}

_id_10DC(var_0, var_1, var_2, var_3) {
  level._id_3E85._id_8E4D[var_0] = var_1;
  level._id_3E85._id_8E52[var_0] = var_2;
  level._id_3E85._id_8E54[var_0] = var_3;
}

getkillstreakcratedatabystreakname(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2._id_EB9F = var_1;
  return var_2;
}

_id_AD54(var_0, var_1) {
  level._id_3E85._id_8E54[var_0] = var_1;
}

_id_8DCA(var_0) {
  var_1 = self._id_4350;
  var_2 = level._id_3E85._id_8E4D[var_1.streakname];

  if(isDefined(var_2)) {
    _id_AD4A(var_2);
  }

  var_3 = level._id_3E85._id_8E52[var_1.streakname];

  if(isDefined(var_3)) {
    _id_AD5C(var_3);
  }

  var_4 = var_1._id_EB9F;

  if(isDefined(var_4)) {
    _id_AD5F(var_4);
  }
}

_id_8DCB(var_0) {
  var_1 = self._id_4350.streakname;
  var_2 = 0;

  switch (var_1) {
    case "bradley":
      if(!_id_09D6::_id_9422()) {
        var_1 = "pac_sentry";
      }

      break;
    case "juggernaut":
      if(!istrue(var_0._id_88DF)) {
        var_2 = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "applyImmediateJuggernaut")) {
          var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "applyImmediateJuggernaut")]](var_2);
        } else {
          var_0 _id_09B8::_id_F78E(var_2);
        }
      }

      break;
  }

  if(!istrue(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var_1, self.owner, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var_1, undefined, 1);
    }
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self.owner, "airdrop_acquire");
    }
  } else if(isDefined(self.team)) {
    if(var_0.team != self.team) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("hijacker");
      }

      if(isDefined(self.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showSplash")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showSplash")]]("hijacked_airdrop", undefined, var_0);
        }

        self.owner thread _id_0A8D::_id_9137("airdrop_hijacked");
      }
    } else {}
  }

  if(isDefined(level._id_6016["createKillstreakChallengeEvent"])) {
    level scripts\engine\utility::_id_CD61("createKillstreakChallengeEvent", var_0, var_0, self, 0, "open_carepackage");
  }
}

getrandomkillstreak(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "airdrop";
  }

  var_2 = _id_6CC2(level._id_3E85._id_8E54, var_0);

  if(isDefined(var_1) && var_1 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_reaper")) {
    scripts\cp_mp\utility\killstreak_utility::_id_C0BD();
  }

  return var_2;
}

_id_B16A(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_5 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_6 = getkillstreakcratedatabystreakname(var_2, 0);
  var_7 = _id_B159(var_0, var_1, var_5, var_3, var_4, var_6);

  if(!isDefined(var_7)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_7;
}

_id_5037(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_7 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8 = _id_5028(var_0, var_1, var_6, var_3, var_4, var_5, var_7);

  if(!isDefined(var_8)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_8;
}

_id_5039(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak(undefined, var_0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_9 = getkillstreakcratedatabystreakname(var_2, 0);
  var_9._id_10315 = var_6;
  var_10 = _id_502A(var_0, var_1, var_8, var_3, var_4, var_5, var_9, var_7);

  if(!isDefined(var_10)) {
    return undefined;
  } else if(!isDefined(var_10._id_3E9B) || !isDefined(scripts\engine\utility::_id_1BAC(var_10._id_3E9B))) {
    return undefined;
  }

  if(isDefined(var_0)) {
    var_0 thread _id_1397(var_7);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_10;
}

_id_1397(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gametype == "grnd") {
    return;
  }
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_2 = 1.5;
  }

  var_3 = var_0.streakname;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_3, 1, var_2);
}

_id_5038(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_8 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8._id_10315 = var_6;
  var_9 = _id_5029(var_0, var_1, var_7, var_3, var_4, 30000, 30000, var_5, var_8);

  if(!isDefined(var_9)) {
    return undefined;
  } else if(!isDefined(var_9._id_3E6D)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_9._id_3E6D;
}

_id_F737(var_0) {
  var_1 = var_0.streakname;
  var_2 = var_1;
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "airdrop";
  }

  if(getdvarint("#x32e590719abc7c311", 1) == 0 && var_2 == "airdrop") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(getdvarint("#x3a4b0e87a30547480", 1) == 0 && var_2 == "airdrop_multiple") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  var_4 = 4;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_4 = 10;
  }

  var_5 = 1;

  if((level._id_9593.size >= var_4 || level._id_59E1 >= var_4) && var_2 != "airdrop_mega") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_AIRDROPS");
    }

    return 0;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level._id_59E1 + var_5 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return 0;
    }
  }

  var_6 = getdvarint("#x329d11f2ee6dbe8e4", 0);

  if(var_2 == "airdrop" && var_6) {
    var_0._id_47EE = makeweapon("deploy_airdrop_mp_sticky");
  }

  return 1;
}

_id_13A8(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_13A3(var_0);
  }
}

_id_13A3(var_0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::_id_10897("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_13AC(var_0) {
  var_0._id_13AA = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getTargetMarker")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getTargetMarker")]](var_0);
  }

  if(!isDefined(var_1._id_96CF)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0._id_13AA, self.origin);
  }

  _id_13AB(var_1, var_0._id_13AA, var_0);
  return 1;
}

_id_13AB(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_5000(var_0._id_96CF, 50, -200, (0, 0, 1));
  var_3 = var_3 + (0, 0, 1);
  var_4 = spawn("script_model", var_3);
  var_4 setModel("offhand_wm_grenade_smoke");
  var_4.angles = (0, 90, 90);
  var_5 = spawn("script_model", var_3);
  var_5 setModel("ks_crate_marker_mp");
  var_5 setscriptablepartstate("smoke", "on", 0);

  if(isDefined(var_0._id_04ED)) {
    var_0._id_04ED delete();
  }
}

_id_F767() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("airdrop", self);
  return _id_F768(var_0);
}

_id_F768(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_0._id_47EE = makeweapon("s4_deploy_airdrop_codmas_mp");
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_0._id_47EE = makeweapon("s4_deploy_airdrop_valentines_mp");
  } else {
    var_0._id_47EE = makeweapon("s4_deploy_airdrop_mp");
  }

  var_1 = undefined;

  switch (var_0.streakname) {
    case "airdrop":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
  }

  if(var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return 0;
    }
  }

  if(!_id_F737(var_0)) {
    if(var_1) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    }

    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      if(var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return 0;
    }
  }

  var_2 = _id_09B9::_id_EA03(var_0, var_0._id_47EE, "grenade_fire", undefined, ::_id_13A8, ::_id_13A7, undefined, ::_id_13A9);

  if(!istrue(var_2)) {
    if(var_1) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    }

    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_13A7(var_0, var_1, var_2) {
  var_0._id_13AA = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "incrementFauxVehicleCount")]]();
  }

  var_2.owner = self;
  var_2 thread _id_13A6(var_0._id_13AA, undefined, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0._id_13AA, self.origin);
  }

  var_0._id_13A7 = 1;
  var_0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

_id_13A6(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = self.owner.angles;
  self waittill("explode", var_4);
  var_5 = self.owner;

  if(!isDefined(var_5)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return;
  }

  waitframe();
  var_6 = getkillstreakangles(var_4, var_3, var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_8 = undefined;

  if(var_0 == "airdrop") {
    var_8 = _id_5039(var_5, var_5.team, undefined, var_4, var_6, var_4, 1, var_2);
  } else if(var_0 == "airdrop_multiple") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleDropCrates")) {
      var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleDropCrates")]](var_5, var_5.team, var_4, var_6, var_4, var_2);
    }
  }

  if(!isDefined(var_8)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "awardKillstreakFromStruct")) {
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_2._id_A2B6);
    }

    return;
  }

  var_5 scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_2);
}

_id_13A9(var_0) {
  if(istrue(var_0._id_13A7)) {
    if(isDefined(level._id_8DD3)) {
      level thread[[level._id_8DD3]](var_0);
    }
  }

  if(isDefined(var_0._id_13AA) && !istrue(var_0._id_13A7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }
  }
}

_id_814B() {
  var_0 = _id_6B00("battle_royale");
  var_0._id_3234 = &"MP/BR_CRATE";
  var_0._id_5420 = undefined;
  var_0._id_EB9E = 0;
  var_0._id_75E9 = undefined;
  var_0._id_04C7 = -1;
  var_0._id_FE72 = 180;
  var_0._id_F224 = undefined;
  var_0._id_0EE7 = ::_id_2B4E;
  var_0._id_3227 = ::_id_2B4F;
}

_id_692A(var_0) {
  var_1 = spawnStruct();
  var_1.type = var_0;
  return var_1;
}

_id_2B4E(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }
}

_id_2B4F(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "makeItemsFromCrate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "makeItemsFromCrate")]](var_0);
  }
}

_id_5017(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var_2 = _id_502A(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), var_0, _id_692A(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  } else if(!isDefined(var_2._id_3E9B) || !isDefined(scripts\engine\utility::_id_1BAC(var_2._id_3E9B))) {
    return undefined;
  }

  return var_2._id_3E6D;
}

_id_5016(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var_2 = _id_5029(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), 30000, 30000, var_0, _id_692A(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  } else if(!isDefined(var_2._id_3E6D)) {
    return undefined;
  }

  return var_2._id_3E6D;
}

_id_814C() {
  var_0 = _id_6B00("battle_royale_loadout");
  var_0._id_3234 = &"MP/BR_CRATE_LOADOUT";
  var_0._id_508A = "vm_equip_gen_care_package_00";
  var_0._id_5FB8 = undefined;
  var_0._id_5420 = undefined;
  var_0._id_A1C0 = undefined;
  var_0._id_EB9E = 0;
  var_0._id_75E9 = undefined;
  var_0._id_04C7 = -1;
  var_0._id_FE72 = 180;
  var_0._id_F224 = undefined;
  var_0._id_5FBF = 1;
  var_0._id_ADB3 = 0.5;
  var_0._id_AC9F = 0.5;
  var_0._id_0EE7 = ::_id_2BE0;
  var_0._id_3227 = ::_id_2BE1;
  var_0._id_4841 = ::_id_2BE2;
  var_0._id_485D = 0;
  var_0._id_AABE = 1;
}

_id_2BE0(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brLoadoutCrateFirstActivation")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brLoadoutCrateFirstActivation")]](self);
    }
  }
}

_id_2BE1(var_0) {
  _id_7009(var_0);
}

_id_2BE4(var_0) {
  if(!isDefined(self._id_A79D)) {
    self._id_A79D = 0;
  }

  if(!isDefined(self._id_B7E9)) {
    self._id_B7E9 = [];
  }

  if(!isDefined(self._id_B790)) {
    self._id_B790 = [];
  }

  self._id_B790[var_0 getentitynumber()] = var_0;
  self._id_B7E9[self._id_B7E9.size] = var_0;
  self._id_A79D++;

  if(isDefined(self._id_B732)) {
    foreach(var_2 in self._id_B732) {
      if(isDefined(self._id_ACFE) && isDefined(self._id_ACFE[var_2]) && isDefined(self._id_ACFE[var_2]._id_B7EB)) {
        if(self._id_ACFE[var_2]._id_B7EB.size == 1 && self._id_ACFE[var_2]._id_B7EB[0] == var_0) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var_2, self);
          }

          self._id_B732 = scripts\engine\utility::array_remove(self._id_B732, var_2);
          break;
        }
      }
    }
  }

  if(self._id_A79D >= level._id_EF6A[var_0.team]["teamCount"]) {
    if(isDefined(self._id_B732)) {
      foreach(var_5 in self._id_B732) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var_5, self);
        }
      }
    }

    if(isDefined(self._id_3607) && isDefined(self._id_3607._id_84EF)) {
      self._id_3607._id_84EF = 0;
    }

    thread _id_4843();
  }
}

_id_2BE2(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brOnLoadoutCrateDestroyed")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brOnLoadoutCrateDestroyed")]](var_0);
  }
}

_id_7009(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "br_giveDropBagLoadout")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "br_giveDropBagLoadout")]](var_0);
  }
}

_id_501C(var_0, var_1, var_2) {
  return _id_5028(undefined, var_0, "battle_royale_loadout", var_1, (0, randomfloat(360), 0), var_2);
}

_id_814A() {
  var_0 = _id_6B00("battle_royale_c130_loot");
  var_0._id_3234 = &"MP/DMZ_LOOT_CRATE_CAPTURE";
  var_0._id_508A = "vm_equip_gen_care_package_00";
  var_0._id_5FB8 = undefined;
  var_0._id_5420 = undefined;
  var_0._id_A1C0 = undefined;
  var_0._id_EB9E = 0;
  var_0._id_75E9 = undefined;
  var_0._id_04C7 = -1;
  var_0._id_FE72 = 180;
  var_0._id_F224 = 600;
  var_0._id_5FBF = 1;
  var_0._id_ADB3 = 0.5;
  var_0._id_AC9F = 0.5;
  var_0._id_0EE7 = ::_id_2B40;
  var_0._id_3227 = ::_id_2B41;
  var_0._id_4841 = ::_id_2B42;
  var_0._id_3E9A = ::_id_2B43;
  var_0._id_485D = 1;
}

_id_2B40(var_0) {}

_id_2B41(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "c130Airdrop_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse")]](var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "dmzTut_crateUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "dmzTut_crateUsed")]](var_0);
  }

  if(isDefined(self._id_DE55)) {
    self._id_DE55 setscriptablepartstate("smoke_signal", "off", 0);
    self._id_DE55 delete();
  }

  if(isDefined(level._id_2E3E)) {
    level._id_2E3E = scripts\engine\utility::array_remove(level._id_2E3E, self);
  }
}

_id_2B42(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self._id_DE55)) {
    self._id_DE55 setscriptablepartstate("smoke_signal", "off", 0);
    self._id_DE55 delete();
  }

  if(isDefined(level._id_2E3E)) {
    level._id_2E3E = scripts\engine\utility::array_remove(level._id_2E3E, self);
  }
}

_id_2B43() {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

_id_5015(var_0, var_1, var_2) {
  var_3 = 250;
  var_4 = level._id_2E27;
  var_5 = 1000;
  var_6 = 10500;
  var_7 = 7500;
  var_8 = 3000;
  var_9 = var_1 + (0, 0, var_5);
  var_10 = createcrate(undefined, undefined, "battle_royale_c130_loot", var_0, (0, 0, 0), var_1, undefined, 0);

  if(isDefined(var_10)) {
    var_10._id_DDB4 = 1;

    if(var_9[2] < var_0[2]) {
      var_11 = undefined;
      var_12 = distance(var_0, var_9);

      if(var_12 >= var_6) {
        var_11 = "brc130_drop_high";
      } else if(var_12 >= var_7) {
        var_11 = "brc130_drop_med";
      } else if(var_12 >= var_8) {
        var_11 = "brc130_drop_low";
      }

      if(isDefined(var_11)) {
        var_13 = 1000;
        var_14 = spawn("script_model", var_9 + (0, 0, var_13));
        var_14.angles = var_2;
        var_14 setModel("tag_origin");
        var_15 = spawn("script_model", var_10.origin);
        var_15.angles = var_10.angles;
        var_15 setModel("veh8_mil_lnd_carepackage_parachute_br");
        var_10 thread _id_10A9C();
        var_15 thread _id_10A9D(var_14);
      } else
        var_10 _id_3E99();
    } else
      var_10 _id_3E99();

    var_16 = "cashdrop_common";
    var_17 = getdvarint("#x313d01d213622aa7c", 1);

    if(var_17) {
      var_16 = "cashdrop_common_world";
    }

    var_10 setscriptablepartstate("objective_map", var_16, 0);
    var_10 setscriptablepartstate("crate_audio", "parachuting", 0);
    var_10._id_DE55 = spawn("script_model", var_1);
    var_10._id_DE55 setModel("ks_airdrop_crate_br");
    var_10._id_DE55 setscriptablepartstate("smoke_signal", "on", 0);
  }

  return var_10;
}

_id_10A9C() {
  self endon("death");
  wait(self._id_18AC);

  if(isDefined(self)) {
    self _meth_83EC();
    _id_3E99();
  }
}

_id_10A9D(var_0) {
  self endon("death");
  wait(self._id_18AC);

  if(isDefined(self)) {
    self delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_814D() {
  var_0 = _id_6B00("battle_royale_chopper_loot");
  var_0._id_3234 = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  var_0._id_508A = "vm_equip_gen_care_package_00";
  var_0._id_5FB8 = undefined;
  var_0._id_5420 = undefined;
  var_0._id_A1C0 = undefined;
  var_0._id_EB9E = 0;
  var_0._id_75E9 = undefined;
  var_0._id_04C7 = -1;
  var_0._id_FE72 = 180;
  var_0._id_F224 = 600;
  var_0._id_5FBF = 1;
  var_0._id_ADB3 = 0.5;
  var_0._id_AC9F = 0.5;
  var_0._id_0EE7 = ::_id_2BE8;
  var_0._id_3227 = ::_id_2BE9;
  var_0._id_4841 = ::_id_2BEA;
  var_0._id_485D = 1;
}

_id_2BE8(var_0) {}

_id_2BE9(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_lootchopper", "lootChopper_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_lootchopper", "lootChopper_onCrateUse")]](var_0);
  }

  if(isDefined(self._id_DE55)) {
    self._id_DE55 setscriptablepartstate("smoke_signal", "off", 0);
    self._id_DE55 delete();
  }
}

_id_2BEA(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self._id_DE55)) {
    self._id_DE55 setscriptablepartstate("smoke_signal", "off", 0);
    self._id_DE55 delete();
  }
}

_id_501E(var_0, var_1) {
  var_2 = _id_5028(undefined, undefined, "battle_royale_chopper_loot", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2._id_DDB4 = 1;
    var_3 = "cashdrop_common";
    var_4 = getdvarint("#x313d01d213622aa7c", 1);

    if(var_4) {
      var_3 = "cashdrop_common_world";
    }

    var_2 setscriptablepartstate("objective_map", var_3, 0);
    var_2._id_DE55 = spawn("script_model", var_1);
    var_2._id_DE55 setModel("ks_airdrop_crate_br");
    var_2._id_DE55 setscriptablepartstate("smoke_signal", "on", 0);
  }

  return var_2;
}

_id_8272() {
  var_0 = _id_6B00("esc_cache");
  var_0._id_3234 = &"MP/ESC_CACHE_USE_HINT";
  var_0._id_FEDB = "tag_use";
  var_0._id_FEB0 = 200;
  var_0._id_FE72 = 160;
  var_0._id_04C7 = 0;
  var_0._id_5FB8 = "military_crate_large_stackable_01";
  var_0._id_5420 = undefined;
  var_0._id_A1C0 = undefined;
  var_0._id_EB9E = 0;
  var_0._id_75E9 = undefined;
  var_0._id_04C7 = -10000;
  var_0._id_75E9 = undefined;
  var_0._id_9F23 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "captureLootCacheCallback")) {
    var_0._id_3227 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "captureLootCacheCallback")]]();
  }

  var_0._id_485D = 0;
  var_0._id_AABE = 1;
  var_0._id_3237 = undefined;
  var_0._id_4866 = undefined;
  var_0._id_F224 = undefined;
}

_id_6C74(var_0) {
  var_1 = spawnStruct();
  var_1._id_3BEB = var_0;
  return var_1;
}

_id_B179(var_0, var_1, var_2) {
  var_3 = _id_B159(undefined, undefined, "esc_cache", var_1, var_2, _id_6C74(var_0));
  return var_3;
}

_id_8139() {
  level._id_3E85._id_1B89 = [];
  level._id_3E85._id_1B1E = [];
  var_0 = _id_6B00("arm_no_owner");
  var_0._id_0EE7 = ::_id_1B1F;
  var_0._id_3227 = ::_id_1B20;
  var_0._id_EB9E = 0;
  var_0._id_5420 = undefined;
  var_0._id_75EE = 5000;
  var_0._id_F224 = 180;
  _id_108D("uav", undefined, 5, 10);
  _id_108D("manual_turret", undefined, 5, 5);
  _id_108D("cruise_predator", undefined, 4, 40);
  _id_108D("scrambler_drone_guard", undefined, 4, 20);
  _id_108D("precision_airstrike", undefined, 3, 60);
  _id_108D("toma_strike", undefined, 2, 40);
  _id_108D("chopper_gunner", undefined, 2, 30);
  _id_108D("pac_sentry", undefined, 2, 30);
  _id_108D("gunship", undefined, 2, 30);
  thread _id_813A();
}

_id_813A() {
  waittillframeend;
  var_0 = scripts\engine\utility::ter_op(_id_09D6::_id_9422(), 50, 0);
  _id_108D("bradley", undefined, 4, var_0);
}

_id_108D(var_0, var_1, var_2, var_3) {
  level._id_3E85._id_1B21[var_0] = var_2;
  level._id_3E85._id_1B89[var_0] = var_3;
  level._id_3E85._id_1B1E[var_0] = var_1;
}

_id_68D0(var_0) {
  var_1 = spawnStruct();
  var_1.streakname = var_0;
  return var_1;
}

_id_1B1F(var_0) {
  var_1 = self._id_4350;
  var_2 = level._id_3E85._id_1B1E[var_1.streakname];

  if(isDefined(var_2)) {
    _id_AD4A(var_2);
  }
}

_id_1B20(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "giveKillstreak")) {
    var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "giveKillstreak")]](self._id_4350.streakname, 0, 0, self.owner);
  }
}

_id_8147() {
  var_0 = _id_6B00("base_nuke");
  level.leveldata = var_0;
  var_0._id_0EE7 = ::_id_22B3;
  var_0._id_3227 = ::_id_22B4;
  var_0._id_EB9E = 0;
  var_0._id_5420 = undefined;
  var_0._id_5FB8 = "wm_equip_nebula_warhead_crate_00";
  var_0._id_508A = "wm_equip_nebula_warhead_crate_00";
  var_0._id_A1C0 = getent("nebula_package_col", "targetname");
  var_0.mountmantlemodeloffset = (0, 0, 17);
  var_0._id_75EE = 5000;
  var_0._id_75E9 = undefined;
  var_0._id_4B06 = 1;
  var_0._id_F224 = getdvarint("#x31649a2e0c11941b", 160);

  if(var_0._id_F224 == 0) {
    var_0._id_A443 = 1;
  }

  var_0._id_9F23 = "v_ui_icon_objective_nebula_00";
  var_0._id_ADB3 = 5;
  var_0._id_AC9F = 5;
  var_0._id_3234 = &"MP/ARMSRACE_CRATE_PICKUP";
}

_id_22B3(var_0) {}

_id_22B4(var_0) {
  var_1 = 256;
  var_2 = var_1 * var_1;
  var_3 = [];
  var_4 = var_0.pers["team"];

  foreach(var_6 in level.players) {
    if(distancesquared(var_6.origin, var_0.origin) <= var_2 && var_6.pers["team"] == var_4) {
      var_3[var_3.size] = var_6;
    }
  }

  if(var_3.size > 0 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "addCashForScoreEvent")) {
    foreach(var_9 in var_3) {
      if(var_9 != var_0) {
        var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "addCashForScoreEvent")]]("crate_pickup_assist");
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "addCashForScoreEvent")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "addCashForScoreEvent")]]("crate_picked_up");
  }

  var_0._id_A72C = 1;
  scripts\mp\gametypes\base::recordbaseactivity(var_0, "baseCrateCaptureCallback");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "checkBaseNukeCrateCarrier") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "checkBaseNukeCrateCarrier")]](var_0.origin, undefined)) {
    return;
  }
  var_0 setclientomnvar("ui_base_carrying_nuke", 1);
  self.owner = var_0;
  var_0 setclientomnvar("ui_base_objective_nebula_player", 1);
  var_11 = "";

  if(var_0.team == "axis") {
    var_11 = "ui_base_objective_nebula_axis";
  } else {
    var_11 = "ui_base_objective_nebula_allies";
  }

  var_12 = _func_00BE(var_11);
  var_12 = var_12 + 1;
  setomnvar(var_11, var_12);

  if(!isDefined(var_0._id_413F)) {
    var_0._id_413F = _id_07F9::_id_C57D();
  }

  _id_07F9::_id_A867(var_0._id_413F, "current", var_0.origin + (0, 0, 120), level.leveldata._id_9F23);
  _id_07F9::_id_FB96(var_0._id_413F, var_0.sessionteam);
  _id_07F9::_id_A8B1(var_0._id_413F, 0);
  _id_07F9::_id_FB98(var_0._id_413F, 6);
  _id_07F9::_id_FB93(var_0._id_413F, var_0);
  _id_07F9::_id_FB9D(var_0._id_413F, 120);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "monitorNukeCrateCarrier")) {
    var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "monitorNukeCrateCarrier")]]();
  }

  thread scripts\mp\gametypes\arms_race_audio::nukecrategrabsound(self);
}

_id_6CBC(var_0) {
  var_1 = _id_68D1(var_0);
  var_2 = _id_6CC2(level._id_3E85._id_1B89, var_1);
  return var_2;
}

_id_68D1(var_0) {
  var_1 = level._id_45D3;
  var_2 = undefined;

  if(var_1 > 1) {
    var_2 = [];

    foreach(var_5, var_4 in level._id_3E85._id_1B21) {
      if(var_1 > var_4) {
        var_2[var_2.size] = var_5;
      }
    }
  }

  return var_2;
}

_id_500C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || var_1 == "random") {
    var_1 = _id_6CBC(var_0);
  }

  var_5 = _id_68D0(var_1);
  var_6 = _id_502A(undefined, var_0, "arm_no_owner", var_2, var_3, var_4, var_5);

  if(!isDefined(var_6)) {
    return undefined;
  } else if(!isDefined(var_6._id_3E9B) || !isDefined(scripts\engine\utility::_id_1BAC(var_6._id_3E9B))) {
    return undefined;
  }

  foreach(var_8 in var_6._id_3E9B) {
    return var_8;
  }
}

ischutecratetype(var_0) {
  switch (var_0) {
    case "base_nuke":
      return 0;
    default:
      return 0;
  }
}

isanimatedfreefallcratetype(var_0) {
  switch (var_0) {
    case "base_nuke":
      return 1;
    default:
      return 0;
  }
}

getkillstreakangles(var_0, var_1, var_2) {
  var_3 = var_1;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_2), "killstreak", "killstreak_no_owner");

  if(ischutecratetype(var_4)) {
    return var_3 + (0, 180, 0);
  }

  var_5 = var_0 + (0, 0, 10);
  var_6 = _id_6995(var_0, 1);
  var_7 = 25900.0;
  var_8 = 19.5;
  var_9 = 1300;
  var_10 = var_7 / var_8;
  var_11 = getdvarfloat("#x33c01342f08fa6256");
  var_12 = 150;
  var_13 = 4000 - var_12;
  var_14 = _func_0218(var_13 / (var_11 * 0.5));
  var_15 = var_10 * var_14;
  var_15 = var_15 - var_9;
  var_16 = physics_createcontents(["physicscontents_item", "physicscontents_itemclip", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_17 = [0, -45, 45, -90, 90, -135, 135, -180];

  for(var_18 = 0; var_18 < var_17.size; var_18++) {
    var_19 = var_3 + (0, var_17[var_18], 0);
    var_20 = vectornormalize(-1 * anglesToForward(var_19));
    var_21 = var_6 - var_20 * var_15;
    var_22 = _func_02C1(var_21, var_5, var_16, undefined, 0, "physicsquery_closest");

    if(isDefined(var_22) && var_22.size > 0) {
      continue;
    }
    var_3 = var_19;
    break;
  }

  return var_3 + (0, 180, 0);
}