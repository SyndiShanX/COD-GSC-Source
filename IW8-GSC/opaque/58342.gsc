/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58342.gsc
***********************************************/

_id_1380C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1;

  ammo_manager();

  if(!ammo_cache_used()) {
    return;
  }
  if(isDefined(self._id_136E6)) {
    if(isDefined(self._id_136E6.type) && self._id_136E6.type == var_0) {
      _id_12CBB(var_0, var_1);
      return;
    } else {
      if(isDefined(var_4))
        self._id_136E6._encstr_8AE0169B18CF6F23B8811F284FCB70C3487B890778B28895 = undefined;

      _id_138C8();
    }
  }

  _encstr_974D19B16870EF53A9BF100DBB58511B28408B8B3656D38A80872C(var_0);
  thread ammo_crate_think(var_0, var_1, var_2, var_3, var_4, var_5);
}

_encstr_974D19B16870EF53A9BF100DBB58511B28408B8B3656D38A80872C(var_0) {
  self._id_136E6 = spawnStruct();
  self._id_136E6.type = var_0;
  self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755 = undefined;
  self._id_136E6._encstr_8AE0169B18CF6F23B8811F284FCB70C3487B890778B28895 = undefined;
}

preinfilstreamfunc() {
  if(isDefined(self._id_136E6) && isDefined(self._id_136E6.type))
    return self._id_136E6.type;

  return undefined;
}

_id_12CBB(var_0, var_1) {
  if(isDefined(self._id_136E6) && isDefined(self._id_136E6.type))
    self notify("_encstr_A1D70DE6E0ACCA8CAF31EDF6CD47D7" + var_0 + "_encstr_AA410DEBE8A5ADAC39AF39AC6E59A3", var_1);
}

_id_138C8() {
  if(isDefined(self._id_136E6) && isDefined(self._id_136E6.type)) {
    ammo_crate_spawn();
    var_0 = self._id_136E6.type;
    self._id_136E6 = undefined;
    self notify("_encstr_A9B01237E8BD38FA6E382B5619BE89DBF6B947FA" + var_0);
  }
}

ammo_crate_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A9B01237E8BD38FA6E382B5619BE89DBF6B947FA" + var_0);
  self notify("_encstr_915313A304AFFE53978FCBEF4833078A17988EDB46" + var_0);

  if(istrue(var_5))
    childthread ammo_crate_trial_think();

  childthread ammo_crates();
  childthread ammo_crate_use();
  childthread ammo_cache_setup(var_2, var_3, var_4);
  self refreshsprinttime();
  ammobox_bufferedattachmentweapon(var_0, var_1);
  _id_138C8();
}

ammo_crates() {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  thread _id_138C8();
}

ammo_crate_trial_think() {
  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "_encstr_B607038AAB" && (var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" || var_4 == "_encstr_BDB50C41D83F8F9F030B60E80F5B")) {
      continue;
    }
    thread _id_138C8();
    return;
  }
}

ammo_crate_use() {
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1");
  thread _id_138C8();
}

ammobox_bufferedattachmentweapon(var_0, var_1) {
  var_2 = _id_143CC("_encstr_A1D70DE6E0ACCA8CAF31EDF6CD47D7" + var_0 + "_encstr_AA410DEBE8A5ADAC39AF39AC6E59A3", var_1);

  if(isstring(var_2) && var_2 == "_encstr_995408F398012F656821")
    return;
  else
    ammobox_bufferedattachmentweapon(var_0, var_2);
}

ammo_cache_setup(var_0, var_1, var_2) {
  self.movespeedscaler = var_0;
  scripts\mp\weapons::updatemovespeedscale();

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  childthread ammobox_addrandomweapon(var_1);

  if(isDefined(var_2) && ammo_cache_think()) {
    self._id_136E6._encstr_8AE0169B18CF6F23B8811F284FCB70C3487B890778B28895 = var_2;
    self lerpfovbypreset(var_2);
  }
}

ammo_crate_spawn() {
  if(ammo_cache_used()) {
    if(scripts\mp\utility\perk::_hasperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"))
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    else
      self.movespeedscaler = 1;

    scripts\mp\weapons::updatemovespeedscale();
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::removeperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::removeperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::removeperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  if(isDefined(self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755))
    thread ammo_restock();

  if(ammo_cache_think() && isDefined(self._id_136E6._encstr_8AE0169B18CF6F23B8811F284FCB70C3487B890778B28895))
    self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

ammobox_addrandomweapon(var_0) {
  while(isDefined(self.vehicle))
    waitframe();

  if(isDefined(self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755)) {
    self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755 = var_0;
    self.operatorcustomization.suit = var_0;
    scripts\mp\utility\player::_setsuit(var_0);
  } else if(!isDefined(self._id_12147) && _encstr_AD0115D29BFA8DAE6E1DDBB6BECD57A51D7DCE0BC6A546(var_0)) {
    self._id_12147 = self.operatorcustomization.suit;
    self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755 = var_0;
    self.operatorcustomization.suit = var_0;
    scripts\mp\utility\player::_setsuit(var_0);
  }
}

ammo_restock() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755;

  while(isDefined(self._id_136E6))
    waitframe();

  while(isDefined(self.vehicle))
    waitframe();

  if(isDefined(self._id_136E6)) {
    self._id_136E6._encstr_AB3E17F345795E5F361B6A72460E179478579978F94864C755 = var_0;
    return;
  }

  var_1 = isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit) && self.operatorcustomization.suit == var_0;

  if(isDefined(self._id_12147) && var_1) {
    self.operatorcustomization.suit = self._id_12147;
    scripts\mp\utility\player::_setsuit(self._id_12147);
    self._id_12147 = undefined;
  }
}

ammo_cache_used() {
  if((!isDefined(self.isjuiced) || !istrue(self.isjuiced)) && (!isDefined(self.cranked) || !istrue(self.cranked)) && (!isDefined(self.isjuggernaut) || !istrue(self.isjuggernaut)) && (!isDefined(self.adrenalinepoweractive) || !istrue(self.adrenalinepoweractive)) && !allassassin_initteamlist_timed("_encstr_9A570C4FD8FF88ADE7B260684BA3"))
    return 1;

  return 0;
}

_encstr_AD0115D29BFA8DAE6E1DDBB6BECD57A51D7DCE0BC6A546(var_0) {
  var_1 = isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit);
  return isDefined(var_0) && var_1;
}

ammo_cache_think() {
  if((!isDefined(self.adrenalinepoweractive) || !istrue(self.adrenalinepoweractive)) && !allassassin_initteamlist_timed("_encstr_9A570C4FD8FF88ADE7B260684BA3"))
    return 1;

  return 0;
}

ammo_manager() {
  if(allassassin_initteamlist_timed("_encstr_9A570C4FD8FF88ADE7B260684BA3")) {
    if(isDefined(level._id_12838) && isDefined(level._id_12838.area1_targets)) {
      foreach(var_1 in level._id_12838.area1_targets) {
        if(var_1._id_138FD == "_encstr_9A570C4FD8FF88ADE7B260684BA3") {
          var_2 = _keypadscriptableused_bunkeralt::_id_1249C(var_1._id_138FD);

          if(isDefined(var_2))
            var_2 thread _keypadscriptableused_bunkeralt::isempdamage();
        }
      }
    }
  }
}

allassassin_initteamlist_timed(var_0) {
  if(!isDefined(level._id_12838) || !isDefined(level._id_12838.applyquest))
    return 0;

  var_1 = level._id_12838.applyquest[var_0];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, self))
    return 1;

  return 0;
}

_id_143CC(var_0, var_1) {
  var_2 = spawnStruct();
  thread _id_143CD(var_2, var_0);
  thread scripts\engine\utility::waittill_timeout_proc(var_2, var_1);
  var_2 waittill("_encstr_9B620E9F2BA0F3234370C2F91B2697EE", var_3);
  return var_3;
}

_id_143CD(var_0, var_1) {
  var_0 endon("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  self waittill(var_1, var_2);
  var_0 notify("_encstr_9B620E9F2BA0F3234370C2F91B2697EE", var_2);
}