/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\powerups\zm_powerup_fire_sale.gsc
****************************************************************/

_id_BB93() {
  _id_0990::_id_C20E("fire_sale", ::grab_fire_sale);

  if(_id_0990::_id_60F3()) {
    _id_0990::_id_1083("fire_sale", "s4_zm_power_up_firesale", "LUA_MENU_TUGOLF/ZM_POWERUP_FIRE_SALE", ::should_drop_fire_sale, !1, !1, !1, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
    _id_0990::_id_BB18("fire_sale", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "zmb_timeout_flash");
  }
}

should_drop_fire_sale() {
  if(scripts\engine\utility::_id_5C00("magicbox_moving") || scripts\engine\utility::_id_5C00("powerup_fire_sale_active") || !scripts\engine\utility::_id_5C00("can_firesale")) {
    return 0;
  }

  return 1;
}

grab_fire_sale(var_0) {
  level thread run_fire_sale(self, var_0);
  var_0 thread _id_0990::_id_BB20("fire_sale");
}

run_fire_sale(var_0, var_1) {
  level endon("game_ended");
  level notify("run_fire_sale");
  level endon("run_fire_sale");
  scripts\engine\utility::_id_5C1B("powerup_fire_sale_active");
  level thread _id_073E::firesale_start();

  if(isDefined(var_0.n_override_lifetime)) {
    var_2 = var_0.n_override_lifetime;
  } else {
    var_2 = 30;
  }

  level thread _id_0990::_id_DC5B(var_1.team, "fire_sale", var_2);
  var_3 = scripts\cp\utility::_id_6C5C();

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && isPlayer(var_5) && isDefined(var_0._id_7953)) {
      var_5 _id_0990::_id_BB0F(9);
    }
  }

  level scripts\engine\utility::_id_108A7(var_2, "end_fire_sale");
  scripts\engine\utility::_id_5C04("powerup_fire_sale_active");
}