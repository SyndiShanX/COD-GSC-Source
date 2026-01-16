/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_ui_inventory.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_inventory;

#namespace zm_ui_inventory;

autoexec __init__system__() {
  system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connecting(&onconnect);
  clientfield::register_bgcache("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, 1);
  zm_inventory::function_c7c05a13();
  registeredfields = [];

  foreach(mapping in level.var_a16c38d9) {
    if(!isDefined(registeredfields[mapping.var_cd35dfb2])) {
      registeredfields[mapping.var_cd35dfb2] = 1;
      var_9cf9ba9 = "worlduimodel";

      if(isDefined(mapping.ispersonal)) {
        var_9cf9ba9 = "clientuimodel";
      }

      clientfield::register(var_9cf9ba9, mapping.var_cd35dfb2, 1, mapping.numbits, "int");
    }
  }
}

private onconnect() {
  self thread function_13ad9a60();
}

private function_13ad9a60() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"menuresponse");
    response = waitresult.response;

    if(response == "zm_inventory_opened") {
      self notify(#"zm_inventory_menu_opened");
    }
  }
}

function_7df6bb60(fieldname, value, player) {
  var_d5423fb8 = level.var_a16c38d9[fieldname];

  if(!(isDefined(var_d5423fb8) && isDefined(var_d5423fb8.ispersonal) && var_d5423fb8.ispersonal)) {
    self clientfield::set_world_uimodel(var_d5423fb8.var_cd35dfb2, value);
    return;
  }

  assert(isplayer(player));

  if(!isDefined(player)) {
    return;
  }

  player clientfield::set_player_uimodel(var_d5423fb8.var_cd35dfb2, value);
}

function_d8f1d200(var_ee9637ec) {
  self clientfield::set_player_uimodel("hudItems.zmFeatureDescription", var_ee9637ec);
}