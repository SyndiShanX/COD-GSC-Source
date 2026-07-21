/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\helper_drone_cp.gsc
***********************************************/

helper_drone_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B4CB0D5B07A33271E08DB18AF7CA58", ::helperdrone_markplayers_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_A2CE16BBB03A8D1A531627DA4BE6D951E63AA6A358D1EADC", ::markent_watchmarkingentstatus_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_AC07157F27F318D0A15AA03E838109CD5BD3EBD1EFAA58", ::get_mark_ui_duration);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B8921A9DAC1DBEDB57E85639F527CA47D26CD859FA1D85399DCAE837", ::get_outer_reticle_targets);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9", scripts\cp\coop_super::superusefinished);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_87850E106B0CBDECEF034DD6FC175061", scripts\cp\cp_laststand::player_in_laststand);
  var_0 = getarraykeys(level.helperdronesettings);

  foreach(var_2 in var_0) {
    var_3 = level.helperdronesettings[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", var_3, var_2);
    }
  }
}

get_mark_ui_duration() {
  return 30;
}

helperdrone_markplayers_cp(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    var_2 = get_mark_target_array();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_4))
          continue;
      }

      if(var_4 == var_1) {
        continue;
      }
      if(level.teambased && var_4.team == var_1.team) {
        continue;
      }
      if(scripts\cp_mp\killstreaks\helper_drone::isbeingmarked(var_4)) {
        continue;
      }
      if(scripts\cp_mp\killstreaks\helper_drone::isreconmarked(var_4)) {
        continue;
      }
      scripts\cp_mp\killstreaks\helper_drone::_id_131C9(self.targetmarkergroup, var_4, 0);

      if(!scripts\cp_mp\killstreaks\helper_drone::isinmarkingrange(var_4)) {
        continue;
      }
      if(!scripts\cp_mp\killstreaks\helper_drone::canseetarget(var_4)) {
        continue;
      }
      scripts\cp_mp\killstreaks\helper_drone::_id_131C9(self.targetmarkergroup, var_4, 1);

      if(istrue(self.markingtarget)) {
        continue;
      }
      if(var_1 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var_4, 70, 40))
        thread startmarkingtarget_cp(var_4, "_encstr_88BF06FD784A6393", 0, 1);
    }

    waitframe();
  }
}

startmarkingtarget_cp(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_5 = spawnStruct();
  var_5.target = var_0;
  var_5.targetnum = var_0 getentitynumber();
  var_5.markingent = self;
  var_5.ownerteam = var_4.team;
  var_5.outlineid = undefined;
  var_5.headicon = undefined;
  var_5.beingmarked = undefined;
  var_5.reconmarked = undefined;
  var_5.notifytoendmark = "_encstr_BDA60A23731A7F40B3876906" + var_5.targetnum;

  if(!isDefined(var_5.targetnum)) {
    return;
  }
  var_6 = self.targetmarkergroup;

  if(!isDefined(var_6)) {
    return;
  }
  var_5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("_encstr_921D0FCBD1C8481B52778FDB7BA3D9101B");
  self.owner setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", 2);
  var_7 = scripts\cp_mp\killstreaks\helper_drone::getmarkingdelay(var_0);

  while(var_7 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_4 scripts\cp_mp\killstreaks\helper_drone::helperdrone_istargetinreticle(var_0, 70, 40)) {
      var_5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", 1);
      return;
    }

    var_7 = var_7 - 0.05;
    wait 0.05;
  }

  var_5.reconmarked = 1;
  self.markingtarget = undefined;
  scripts\cp_mp\killstreaks\helper_drone::markent(var_5, 30);
  self.owner setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", 4);
  scripts\cp_mp\killstreaks\helper_drone::_id_131C9(var_6, var_0, 2);
  scripts\cp_mp\killstreaks\helper_drone::addmarkpoints(var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E")]]("_encstr_A1DB1015333230A545C3C855DFB5F9508F4F", 1);

  self.usedcount++;

  if(!isDefined(self._id_1406B))
    self._id_1406B = 0;

  if(isalive(var_0) && isDefined(var_0.ridingvehicle))
    self._id_1406B++;

  var_8 = 35.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6"))
      var_8 = var_8 + 2;
  }

  thread _id_13F20(var_5);
  scripts\cp_mp\killstreaks\helper_drone::waituntilunmarked(var_5, var_8);
}

_id_13F20(var_0) {
  var_1 = var_0.target;
  var_1 waittill("_encstr_AD75063D571AE108");
  scripts\cp_mp\killstreaks\helper_drone::unmark(var_0);
}

get_mark_target_array() {
  return level.spawned_enemies;
}

get_outer_reticle_targets(var_0) {
  var_1 = 3000;
  var_2 = var_1 * var_1;
  var_3 = [];
  var_4 = cos(70);

  foreach(var_6 in level.spawned_enemies) {
    if(distancesquared(self.origin, var_6.origin) < var_2) {
      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_6.origin, var_4))
        var_3[var_3.size] = var_6;
    }
  }

  return var_3;
}

markent_watchmarkingentstatus_cp(var_0) {}