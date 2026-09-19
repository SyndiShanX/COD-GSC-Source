/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_tabun_grenade.gsc
*********************************************************************/

init() {
  level.zm_grenade_funcs["tabun_grenade_zm"] = ::tabunzm_onfired;
  level.zombietacticalweapon["tabun_grenade_zm"] = 1;
  level._effect["zmb_tabun_stun"] = loadfx("vfx/zombie/abilities_perks/zmb_storm_zmb_debuff");
  level.currentconverts = 0;
}

tabun_get_weapon_name() {
  return "tabun_grenade_zm";
}

tabun_player_give_tabun() {
  _id_0555::issprinting("dlc3_tac_hint_2", self);
  var_0 = tabun_get_weapon_name();
  self._id_60A0 = 2;
  self setoffhandsecondaryclass(var_0);
  _id_0586::_id_078C(var_0);
  self setweaponammoclip(var_0, 2);
}

tabunzm_onfired(var_0, var_1) {
  var_1 = self;
  var_1 thread tabunzm_handle(var_0);
  return 1;
}

tabunzm_handle(var_0) {
  self endon("disconnect");
  var_0 endon("make_dud");
  var_0 endon("death");
  var_0 waittill("explode", var_1);
  var_2 = spawnStruct();
  var_2._id_2994 = 10;
  var_2.radius = 100;
  var_2._id_688C = 5;
  var_2._id_99EB = 1;
  var_2._id_6C2C = var_1;
  thread tabunzm_managedamage(var_2, self, tabun_get_weapon_name());
}

tabunzm_managedamage(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("disconnect");
  self endon("death");
  var_3 = 0;

  while(var_3 < var_0._id_688C) {
    var_3++;
    var_4 = _id_0547::_id_408F();

    foreach(var_6 in var_4) {
      var_7 = var_6._id_0A4B;

      if(!_id_0547::_id_5565(var_7, "zombie_generic")) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_6.isconverted)) {
        continue;
      }
      if(tabunzm_collisionpassed(var_6.origin, var_0._id_6C2C, var_0.radius)) {
        if(tabunzm_zombieishittable(var_6, var_0._id_6C2C)) {
          if(isDefined(var_1) && (isDefined(level.currentconverts) && level.currentconverts < 8))
            level tabunzm_convertzombie(var_6, var_1);
        }
      }
    }

    wait(var_0._id_99EB);
  }
}

tabunzm_convertzombie(var_0, var_1) {
  var_0 maps\mp\agents\_agent_utility::hudoutlineenable("allies", var_1);
  var_0 thread tabunzm_handletimeout();
  level thread tabunzm_onzombiedeath(var_0);
  var_0._id_6816 = 1;
  var_0.isconverted = 1;
  _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_tabun_stun"), var_0, "J_Head", var_1);
}

tabunzm_onzombiedeath(var_0) {
  var_0 endon("kill_tabun_listener");
  level.currentconverts++;
  var_0 waittill("death");
  level.currentconverts--;
}

tabunzm_handletimeout() {
  self endon("death");
  wait 60;
  self notify("kill_tabun_listener");
  level.currentconverts--;
  self dodamage(self._id_0008 + 666, self.origin, undefined, undefined, "MOD_EXPLOSIVE", tabun_get_weapon_name());
}

tabunzm_collisionpassed(var_0, var_1, var_2) {
  return distancesquared(var_0, var_1) < var_2 * var_2;
}

tabunzm_zombieishittable(var_0, var_1) {
  if(var_0.origin[2] <= var_1[2])
    return _bullettracepassed(var_0.origin + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0) && _bullettracepassed(var_1 + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0);
  else
    return _bullettracepassed(var_1 + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0) && _bullettracepassed(var_0.origin + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0);
}