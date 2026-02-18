/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_naughty_or_nice.csc
*****************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#namespace namespace_f0a1fe5c;

function private autoexec __init__system__() {
  system::register(#"hash_520d565ef38560b8", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_7e8e34cc69a77e0b")) || getdvarint(#"hash_40bd34b35079cf2e", 0) > 0) {
    zm_powerups::include_zombie_powerup("naughty_or_nice");

    if(zm_powerups::function_cc33adc8()) {
      clientfield::register("scriptmover", "powerup_pickup_sequence", 1, 4, "int", &function_feb491ef, 0, 0);
      zm_powerups::add_zombie_powerup("naughty_or_nice", "powerup_naughty_or_nice");
    }
  }
}

function function_feb491ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_4cf2e329)) {
    stopfx(fieldname, self.var_4cf2e329);
  }

  if(isDefined(bwastimejump)) {
    switch (bwastimejump) {
      case 1:
        self.var_4cf2e329 = playFX(fieldname, "maps/ltm/fx9_winter_powerup_nice", self.origin);
        break;
      case 2:
        self.var_4cf2e329 = playFX(fieldname, "maps/ltm/fx9_winter_powerup_naughty", self.origin);
        break;
      case 3:
        self.var_4cf2e329 = playFX(fieldname, "maps/ltm/fx9_winter_powerup_nice_final", self.origin);
        break;
      case 4:
        self.var_4cf2e329 = playFX(fieldname, "maps/ltm/fx9_winter_powerup_naughty_final", self.origin);
        break;
      default:
        if(isDefined(self.var_4cf2e329)) {
          stopfx(fieldname, self.var_4cf2e329);
        }

        break;
    }
  }
}