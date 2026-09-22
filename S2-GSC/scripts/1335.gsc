/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1335.gsc
**************************************/

init() {
  self._id_569F = 0;
  level._effect["zmb_moon_zmb_blind"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_zmb_blind");
  level._effect["zmb_moon_player_camo_cam"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_player_camo_cam");
  level._effect["zmb_moon_player_camo_wv"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_player_camo_wv");
  level._effect["zmb_moon_speed_up"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_speed_up");
}

_id_3662() {
  _id_054B::_id_6AB2("role_ability_camo_zm");
  self._id_569F = 1;
  _id_0547::_id_8A6D(1);

  if(!isDefined(level.custom_camo_func_on)) {
    self visionsetnakedforplayer("zm_camo", 0.25);
  } else {
    self[[level.custom_camo_func_on]]();
  }

  _playfxontagforclients(level._effect["zmb_moon_player_camo_cam"], self, "Tag_Origin", self);
  _id_0378::_id_8D74("aud_camo_use");
  thread _id_17BB();
  thread camoplayerfx();
  _id_0547::_id_7ACD();

  if(_id_0547::_id_4BA7("specialty_class_survivalist_zm")) {
    var_0 = _id_0547::_id_73E9() + 1;
    _id_0547::_id_7454(int(_min(var_0, 3)));
  }

  thread powerlosswhenfiring();
}

camoplayerfx() {
  if(_id_0547::_id_4BA7("specialty_class_mobilization_zm")) {
    var_0 = _spawnlinkedfx(level._effect["zmb_moon_speed_up"], self, "J_Knee_LE");
    var_1 = _spawnlinkedfx(level._effect["zmb_moon_speed_up"], self, "J_Knee_RI");
    _triggerfx(var_0);
    _triggerfx(var_1);
    common_scripts\utility::_id_A70A("camo_ended", "disconnect");
    var_0 delete();
    var_1 delete();
  }
}

_id_17BB() {
  self endon("camo_ended");

  while(self._id_569F) {
    foreach(var_1 in _id_0547::_id_408F()) {
      if(!isDefined(var_1._id_5689) || var_1._id_5689 == 0) {
        _playfxontagforclients(level._effect["zmb_moon_zmb_blind"], var_1, "J_Head", self);
        var_1._id_5689 = 1;
      }
    }

    wait 0.4;
  }
}

_id_2F9E() {
  if(common_scripts\utility::_id_562E(self._id_569F)) {
    self._id_569F = 0;
    self notify("camo_ended");

    foreach(var_1 in _id_0547::_id_408F()) {
      var_1._id_5689 = 0;
    }

    foreach(var_1 in _id_0547::_id_408F()) {
      _stopFXOnTag(level._effect["zmb_moon_zmb_blind"], var_1, "J_Head");
    }

    _id_0547::_id_8A6D(0);

    if(!isDefined(level.custom_camo_func_off)) {
      self visionsetnakedforplayer("", 0.25);
    } else {
      self[[level.custom_camo_func_off]]();
    }

    _id_0547::_id_7ACD();
  }
}

_id_62A6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_1)) {
    var_5 = common_scripts\utility::_id_562E(var_1._id_3BE1);
  } else {
    var_5 = common_scripts\utility::_id_562E(var_2._id_569F);
  }

  if(var_5) {
    if(_id_0547::_id_5863(var_4) && var_2 _id_0547::_id_4BA7("specialty_class_saboteur_zm")) {
      var_6 = _id_054A::_id_466B(var_4);
      var_0 = var_0 * var_6;
      var_2 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_saboteur_zm");
    }
  }

  return var_0;
}

_id_6ADC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    var_10 = 0;

    if(isDefined(var_0) && var_0 != var_1) {
      var_10 = common_scripts\utility::_id_562E(var_0._id_3BE1);
    } else {
      var_10 = common_scripts\utility::_id_562E(var_1._id_569F);
    }

    if(var_10) {
      if(maps\mp\_utility::_id_5755(var_4) && isPlayer(var_1) && var_1 _id_0547::_id_4BA7("specialty_class_serrated_edge_zm")) {
        var_1 thread linkwaypointtotargetwithoffset(self);
        var_1 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_serrated_edge_zm");
      }

      if(isPlayer(var_1)) {
        if(!0 || maps\mp\_utility::_id_4571() == "mp_zombie_island") {
          if(!0 || isDefined(self._id_0A4B) && self._id_0A4B == "zombie_assassin") {
            var_11 = 0 - var_2 * 0 - 0;
            var_1 _id_0533::_id_0F37(var_11, 0, 1);
          }
        }
      }
    }
  }
}

_id_6B7E(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  if(isPlayer(var_0) && common_scripts\utility::_id_562E(var_0._id_569F) && var_0 _id_0547::_id_4BA7("specialty_class_covert_exfiltration_zm")) {
    thread _id_3F91(var_0);
  }
}

_id_3F91(var_0) {
  self endon("disconnect");
  _id_0547::_id_8A6D(1);
  self _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_covert_exfiltration_zm", 0, var_0);
  var_0 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_covert_exfiltration_zm");
  common_scripts\utility::_id_A71A(5, "death", "enter_last_stand");
  self _meth_866C(&"remove_teammate_mod_buffs", 1, "specialty_class_covert_exfiltration_zm");
  _id_0547::_id_8A6D(0);
}

linkwaypointtotargetwithoffset(var_0) {
  var_1 = "serratedEdgeApplied" + self getentitynumber();
  var_2 = "serratedEdgeExpired" + self getentitynumber();
  var_0 notify(var_1);
  var_0 endon(var_2);
  var_0 endon(var_1);
  var_3 = var_0.linkwaypointtotargetwithoffset;

  if(!isDefined(var_3)) {
    var_3 = _spawnlinkedfx(common_scripts\utility::_id_44F5("serrated_edge_bleed"), var_0, "J_Spine4");
    _triggerfx(var_3);
    var_0.linkwaypointtotargetwithoffset = var_3;
    var_0.getlinkedparent = [];
  }

  if(!common_scripts\utility::_id_0F79(var_0.getlinkedparent, self)) {
    var_0.getlinkedparent[var_0.getlinkedparent.size] = self;
  }

  var_4 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
  var_5 = var_4 * 0.03;
  var_0 childthread _id_0547::_id_AC38(var_0, var_5, self, 1.5, 30, "dot_generic_zm");
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 30);
  var_6 = 0;

  if(isDefined(var_0.getlinkedparent)) {
    var_0.getlinkedparent = common_scripts\utility::_id_0F93(var_0.getlinkedparent, self);
    var_6 = var_0.getlinkedparent.size == 0;
  } else if(isDefined(var_3) && !_isremovedentity(var_3))
    var_6 = 1;

  if(var_6) {
    var_3 delete();
  }

  var_0 notify(var_2);
}

powerlosswhenfiring() {
  if(!0 || maps\mp\_utility::_id_4571() == "mp_zombie_island") {
    self endon("death");
    self endon("disconnect");
    self endon("camo_ended");

    for(;;) {
      self waittill("weapon_fired", var_0);
      var_1 = _id_0547::_id_9475(var_0);

      if(!issubstr(var_1, "pap")) {
        var_1 = var_1 + "_mp";
      }

      var_2 = getzombieweaponclass(var_1);
      var_3 = -0.1;

      switch (var_2) {
        case "weapon_assault":
          if(issubstr(var_0, "m1a1_zm") || issubstr(var_0, "svt40_zm") || issubstr(var_0, "garand") || issubstr(var_0, "g43") || issubstr(var_0, "type5")) {
            var_3 = -0.1;
          } else {
            var_3 = -0.06;
          }

          break;
        case "weapon_lmg":
          var_3 = -0.06;
          break;
        case "weapon_smg":
          var_3 = -0.04;
          break;
        case "weapon_shotgun":
          if(issubstr(var_0, "walther")) {
            var_3 = -0.1;
          } else {
            var_3 = -0.2;
          }

          break;
        case "weapon_sniper":
          if(issubstr(var_0, "karabin")) {
            var_3 = -0.1;
          } else {
            var_3 = -0.2;
          }

          break;
        case "weapon_heavy":
          var_3 = -0.06;
          break;
        case "weapon_pistol":
          var_3 = -0.1;
          break;
        case "other":
          var_3 = -0.1;
          break;
      }

      if(!_id_0547::_id_5565(self.rentingability, "role_ability_camo_zm")) {
        _id_0533::_id_0F37(var_3, 0, 1);
      }
    }
  }
}

getzombieweaponclass(var_0) {
  var_1 = maps\mp\_utility::_id_4431(var_0);
  var_2 = level.zombieweaponclass[var_1];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_2 = tablelookup("mp/statstable.csv", 2, var_1, 0);

  if(var_2 == "") {
    var_2 = tablelookup("mp/statstable.csv", 2, var_0, 0);
  } else if(var_0 == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  if(isDefined(var_2)) {
    level.zombieweaponclass[var_1] = var_2;
  }

  return var_2;
}