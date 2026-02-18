/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4eecbd20dc9a462c.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#namespace namespace_e8c18978;

function preinit(bundlename) {
  clientfield::register("toplayer", "" + # "hash_7c907650b14abbbe", 1, 1, "int", &function_d3a9eef4, 0, 0);
  clientfield::register("vehicle", "" + # "hash_4ddf67f7aa0f6884", 1, 1, "int", &function_241229f1, 0, 0);
  clientfield::register("vehicle", "" + # "hash_46646871455cab15", 1, 2, "int", &function_1da732e, 0, 0);
  clientfield::register("vehicle", "" + # "hash_6cf1a3b26118d892", 1, 1, "int", &function_d6f6757c, 0, 0);
  level.var_f7dac9d2 = getscriptbundle("killstreak_chopper_gunner");

  if(!getdvarint(#"hash_4aad305a4a7f93db", 0)) {
    level thread function_53e5abd3();
  }
}

function function_53e5abd3() {
  level endon(#"game_ended");
  wait 15;
  forcestreamxmodel(#"veh_t9_mil_us_helicopter_large_doors_rear_open_attach_chopper_gunner", 8, 1);
  forcestreamxmodel(#"veh_t9_mil_us_helicopter_large_doors_mid_attach", 8, 1);
  forcestreamxmodel(#"veh_t9_mil_us_helicopter_large_interior_attach", 8, 1);

  if(sessionmodeiszombiesgame()) {
    forcestreamxmodel(#"veh_t9_mil_us_helicopter_large_right_gun_mount_attach", 8, 1);
  }
}

function function_d3a9eef4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(issplitscreen() && function_65b9eb0f(fieldname)) {
      level.var_c7064907 = self;
    } else if(!isDefined(level.var_bb4264e3)) {
      level.var_bb4264e3 = self;
    }

    return;
  }

  if(isDefined(level.var_f7dac9d2.ksvehicleposteffectbun)) {
    postfxbundle = level.var_f7dac9d2.ksvehicleposteffectbun;

    if(self function_d2cb869e(postfxbundle)) {
      self codestoppostfxbundle(postfxbundle);
    }
  }

  if(isDefined(level.var_f7dac9d2.var_917dc7d4)) {
    self stoprumble(fieldname, level.var_f7dac9d2.var_917dc7d4);
  }

  level.var_bb4264e3 = undefined;
  level.var_c7064907 = undefined;
}

function function_241229f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self util::waittill_dobj(fieldname);

    if(!isDefined(self)) {
      return;
    }

    var_2d9c55a6 = function_5c10bd79(fieldname);

    if(isDefined(level.var_bb4264e3) && var_2d9c55a6 == level.var_bb4264e3) {
      player = level.var_bb4264e3;
    } else if(isDefined(level.var_c7064907)) {
      player = level.var_c7064907;
    }

    if(isDefined(player)) {
      self setsoundentcontext("plr_vehicle", "driver");
      player playrumblelooponentity(fieldname, #"chopper_gunner_rumble_intro");
      self thread scene::play(#"chopper_gunner_door_open_client");

      if(isDefined(level.var_f7dac9d2.ksvehicleposteffectbun)) {
        postfxbundle = level.var_f7dac9d2.ksvehicleposteffectbun;
        player codeplaypostfxbundle(postfxbundle);
      }
    }

    self function_1f0c7136(2);
    self setanim(#"hash_7483c325182bab52");
    wait getanimlength(#"hash_7483c325182bab52");

    if(isDefined(player)) {
      player stoprumble(fieldname, #"chopper_gunner_rumble_intro");
    }

    if(isDefined(self)) {
      self clearanim(#"hash_7483c325182bab52", 0.2);
    }
  }
}

function function_1da732e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    alarm_sound = self gettagorigin("TAG_PROBE_COCKPIT");
    util::playFXOnTag(fieldname, level.var_f7dac9d2.var_24b7aa85, self, "tag_body");

    if(isDefined(level.var_bb4264e3)) {
      if(isDefined(level.var_f7dac9d2.var_c6eb2a1d)) {
        level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_c6eb2a1d);
      }

      level.var_bb4264e3 playSound(fieldname, #"hash_7b6b109a826f44cf");
      waitframe(1);

      if(isDefined(level.var_bb4264e3)) {
        level.var_bb4264e3 playSound(fieldname, #"hash_733033c981df7144", alarm_sound);
      }
    } else {
      self playSound(fieldname, #"hash_2879bee00b0dbf87");
    }

    return;
  }

  if(bwastimejump == 2) {
    alarm_sound = self gettagorigin("TAG_PROBE_COCKPIT");
    util::playFXOnTag(fieldname, level.var_f7dac9d2.var_8334e8e, self, "tag_body");

    if(isDefined(level.var_bb4264e3)) {
      if(isDefined(level.var_f7dac9d2.var_c6eb2a1d)) {
        level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_bf7c296c);
      }

      level.var_bb4264e3 playSound(fieldname, #"hash_7b6b119a826f4682");
      waitframe(1);

      if(isDefined(level.var_bb4264e3)) {
        level.var_bb4264e3 playSound(fieldname, #"hash_733036c981df765d", alarm_sound);
      }

      return;
    }

    self playSound(fieldname, #"hash_331a5d0f62ba4e66");
  }
}

function function_d6f6757c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(level.var_bb4264e3)) {
      util::playFXOnTag(fieldname, level.var_f7dac9d2.var_1d9da603, self, "tag_deathfx");
      level.var_bb4264e3 playSound(fieldname, #"hash_7b6b129a826f4835");

      if(isDefined(level.var_f7dac9d2.var_a97fd8e0)) {
        level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_a97fd8e0);
      }

      if(isDefined(level.var_f7dac9d2.var_917dc7d4)) {
        level.var_bb4264e3 playrumblelooponentity(fieldname, level.var_f7dac9d2.var_917dc7d4);
      }

      return;
    }

    if(isDefined(level.var_f7dac9d2.var_2a77dc37)) {
      util::playFXOnTag(fieldname, level.var_f7dac9d2.var_2a77dc37, self, "tag_deathfx");
      playSound(fieldname, #"hash_331a5d0f62ba4e66");
    }
  }
}