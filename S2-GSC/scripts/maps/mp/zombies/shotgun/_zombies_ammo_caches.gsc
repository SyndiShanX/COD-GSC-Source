/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_ammo_caches.gsc
********************************************************************/

ammo_cache_setup() {
  var_0 = common_scripts\utility::_id_44BE("ammo_cache", "targetname");
  var_1 = 500;

  foreach(var_3 in var_0) {
    var_4 = common_scripts\utility::_id_44BE(var_3.target, "targetname");
    var_3._id_9DC2 = [];
    var_3._id_629F = [];

    foreach(var_6 in var_4) {
      var_7 = var_6._id_0165;

      if(!isDefined(var_7)) {
        continue;
      }
      switch (var_7) {
        case "ammo_cache_trigger":
          var_6.look_pos = var_3.origin;
          var_6._id_267B = var_1;
          var_3._id_9DC2[var_3._id_9DC2.size] = var_6;
          break;
        case "ammo_cache_model":
          var_3._id_629F[var_3._id_629F.size] = var_6;
          break;
      }
    }

    foreach(var_10 in var_3._id_9DC2) {
      var_10 _meth_8660(1, var_3.origin);
      var_10.face_pos = var_3.origin;

      if(_id_0547::_id_5819(var_10))
        _id_0547::_id_8A4F(var_10, ::ammo_cache_update_hints_for_player);
      else {}

      var_10 thread ammo_cache_think(var_3, var_10._id_267B);
    }
  }

  level thread maps\mp\_utility::_id_6F74(::ammo_cache_low_ammo_highlight);
}

ammo_cache_update_hints_for_player(var_0) {
  var_1 = self;
  var_0 endon("disconnect");
  var_0.ammo_cache_available_uses = 3;
  var_0.ammo_cache_uses = 0;
  var_2 = _id_0552::_id_7BE1(var_0, self, 1, self.face_pos);
  var_2._id_4028 = _id_0552::_id_44FF("ammo_cache_3");
  var_3 = 500;

  for(;;) {
    waittillframeend;
    var_2._id_6642 = 1;
    var_2._id_401E = var_3;
    self._id_267B = int(var_2._id_401E);
    [var_5, var_6] = common_scripts\utility::_id_A70E(var_0, "ammo_cache_used", level, "sg_obj_end");
    waittillframeend;

    if(_id_0547::_id_5565(var_5, "sg_obj_end")) {
      if(var_0.ammo_cache_available_uses < 3)
        var_0.ammo_cache_available_uses++;
    } else {
      var_3 = var_3 * 2;

      if(var_3 > 2000)
        var_3 = 2000;
    }

    var_7 = "ammo_cache_3";

    if(var_0.ammo_cache_available_uses == 2)
      var_7 = "ammo_cache_2";
    else if(var_0.ammo_cache_available_uses == 1)
      var_7 = "ammo_cache_1";
    else if(var_0.ammo_cache_available_uses <= 0)
      var_7 = "ammo_cache_0";

    var_2._id_4028 = _id_0552::_id_44FF(var_7);
  }
}

ammo_cache_get_cost_for_player(var_0, var_1) {
  return 500;
}

ammo_cache_hide_from_other_player() {}

ammo_cache_think(var_0, var_1) {
  var_2 = self;

  for(;;) {
    [var_4, var_5] = var_2 _id_0547::_id_A795();
    var_6 = _id_0547::_id_462A(var_4);
    var_7 = 0;

    if(!_id_0547::_id_5836(var_6)) {
      continue;
    }
    if(_id_0548::_id_4B6A(var_4, var_6)) {
      _id_0548::_id_300A(var_4, var_7);
      continue;
    }

    if(var_4.ammo_cache_available_uses <= 0) {
      _id_0555::_id_83DD("blitz_soldout", var_4);
      continue;
    }

    if(var_4 maps\mp\gametypes\zombies::_id_11C2(var_2._id_267B)) {
      _id_0548::_id_3AC1(var_4, var_6);
      var_4.ammo_cache_uses++;
      var_4.ammo_cache_available_uses--;
      var_4 notify("ammo_cache_used");
      var_4 givemaxammo(var_6);
      var_4 thread _id_054E::_id_62D9();
      continue;
    }

    var_4 thread _id_054E::_id_0695("needmoney");
  }
}

ammo_cache_low_ammo_remove_highlights(var_0) {
  var_1 = common_scripts\utility::_id_44BE("ammo_cache", "targetname");

  foreach(var_3 in var_1) {
    foreach(var_5 in var_3._id_629F)
    var_5 _meth_8428(var_0);
  }

  var_0.caches_highlighted = 0;
}

ammo_cache_low_ammo_apply_highlights(var_0) {
  var_1 = common_scripts\utility::_id_44BE("ammo_cache", "targetname");

  foreach(var_3 in var_1) {
    foreach(var_5 in var_3._id_629F)
    var_5 _meth_8427(var_0, 0, 0);
  }

  var_0.caches_highlighted = 1;
}

ammo_cache_low_ammo_highlight() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isalive(var_0))
    var_0 common_scripts\utility::_id_A70A("spawned_player", "faux_spawn");

  var_0.caches_highlighted = 0;
  var_0.ammocachelowammohighlightneedsupdate = 1;
  var_0 childthread ammo_cache_low_ammo_highlight_watcher();
  var_1 = 0.2;

  while(isDefined(var_0) && var_0 getentitynumber() % 4 != int(gettime() / 50) % 4)
    waitframe();

  var_2 = common_scripts\utility::_id_44BE("ammo_cache", "targetname");

  while(isDefined(var_0)) {
    wait(var_1);

    if(!common_scripts\utility::_id_562E(var_0.ammocachelowammohighlightneedsupdate)) {
      continue;
    }
    var_0.ammocachelowammohighlightneedsupdate = 0;

    if(!isalive(var_0)) {
      if(common_scripts\utility::_id_562E(var_0.caches_highlighted))
        ammo_cache_low_ammo_remove_highlights(var_0);

      continue;
    }

    if(_id_0547::_id_577E(var_0)) {
      continue;
    }
    var_3 = var_0 getcurrentweapon();

    if(_id_0547::_id_5565(var_3, "none")) {
      continue;
    }
    if(_id_0547::_id_5865(var_3) || _id_0547::_id_585B(var_3) || _id_0547::iszombieconsumableweapon(var_3) || _id_0547::_id_585C(var_3)) {
      continue;
    }
    var_4 = var_0 _meth_8338(var_3);

    if(var_4 >= 0.2) {
      if(common_scripts\utility::_id_562E(var_0.caches_highlighted))
        ammo_cache_low_ammo_remove_highlights(var_0);

      continue;
    }

    if(var_0.ammo_cache_available_uses <= 0) {
      if(common_scripts\utility::_id_562E(var_0.caches_highlighted))
        ammo_cache_low_ammo_remove_highlights(var_0);

      continue;
    }

    ammo_cache_low_ammo_apply_highlights(var_0);
  }
}

ammo_cache_low_ammo_highlight_watcher() {
  for(var_0 = self; isDefined(var_0); var_0.ammocachelowammohighlightneedsupdate = 1)
    [var_2, var_3] = common_scripts\utility::_id_A70E(var_0, "weapon_fired", var_0, "weapon_change", var_0, "ammo_cache_used", var_0, "death", level, "maxAmmoPickup");
}