/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_7be39c34f66312aa.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_customgame;

#namespace namespace_6a81d072;

init() {
  level.var_ce7f71ea = "n";
  level.var_f6d11e0b = "f";
  level flag::wait_till("magicbox_initialized");
  level thread magic_box_update();
}

get_location_from_chest_index(chest_index) {
  if(isDefined(chest_index) && isDefined(level.chests) && isDefined(level.chests[chest_index]) && isDefined(level.open_chest_location)) {
    chest_loc = level.chests[chest_index].script_noteworthy;

    for(i = 0; i < level.open_chest_location.size; i++) {
      if(level.open_chest_location[i] == chest_loc) {
        return i;
      }
    }
  }

  assertmsg("<dev string:x38>" + chest_index);
}

magic_box_update() {
  self endon(#"end_game");
  util::registerclientsys("box_indicator");
  util::setclientsysstate("box_indicator", level.var_ce7f71ea);

  if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 0) {
    return;
  }

  box_mode = "no_power";

  while(true) {
    if((!level flag::get("power_on") || level flag::get("moving_chest_now")) && level.zombie_vars[#"zombie_powerup_fire_sale_on"] === 0) {
      box_mode = "no_power";
    } else if(level.zombie_vars[#"zombie_powerup_fire_sale_on"] === 1) {
      box_mode = "fire_sale";
    } else {
      box_mode = "box_available";
    }

    switch (box_mode) {
      case #"no_power":
        util::setclientsysstate("box_indicator", level.var_ce7f71ea);

        while(!level flag::get("power_on") && level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 0) {
          wait 0.1;
        }

        break;
      case #"fire_sale":
        util::setclientsysstate("box_indicator", level.var_f6d11e0b);

        while(level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 1) {
          wait 0.1;
        }

        break;
      case #"box_available":
        var_7aa396b9 = get_location_from_chest_index(level.chest_index);

        if(isDefined(var_7aa396b9)) {
          util::setclientsysstate("box_indicator", var_7aa396b9);
        }

        while(!flag::get("moving_chest_now") && level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 0) {
          wait 0.1;
        }

        break;
      default:
        util::setclientsysstate("box_indicator", level.var_ce7f71ea);
        break;
    }

    wait 1;
  }
}