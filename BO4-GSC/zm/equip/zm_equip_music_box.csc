/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\equip\zm_equip_music_box.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace music_box;

autoexec __init__system__() {
  system::register(#"music_box", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"music_box_light_fx", 24000, 1, "int", &music_box_light_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"music_box_teleport", 1, 1, "int", &music_box_teleport, 0, 0);
  clientfield::register("actor", "" + #"hash_4881cb6bc59fdc49", 24000, 1, "int", &function_e722a4fd, 0, 0);
}

function_3224694(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(newval == 1) {
      self.fx_handle = playFX(localclientnum, "maps/zm_orange/fx8_samantha_ground_portal", self.origin);

      if(!isDefined(self.var_30b8668)) {
        self playSound(localclientnum, #"hash_1780eaf4c052b271");
        self.var_30b8668 = self playLoopSound(#"hash_13b5daba3191a299");
      }

      return;
    }

    if(newval == 0) {
      if(isDefined(self.fx_handle)) {
        deletefx(localclientnum, self.fx_handle);
        self.fx_handle = undefined;
      }

      if(isDefined(self.var_30b8668)) {
        self playSound(localclientnum, #"hash_63bbef4e60ff503b");
        self stoploopsound(self.var_30b8668);
        self.var_30b8668 = undefined;
      }
    }
  }
}

function_7ee98254(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    playFX(localclientnum, "maps/zm_orange/fx8_samantha_ground_portal_blast", self.origin);
  }
}

music_box_light_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(newval == 1) {
      self.fx_handle = util::playFXOnTag(localclientnum, "zm_weapons/fx8_music_box_open_world", self, "tag_origin");
      return;
    }

    if(newval == 0) {
      if(isDefined(self.fx_handle)) {
        deletefx(localclientnum, self.fx_handle);
        self.fx_handle = undefined;
      }
    }
  }
}

music_box_teleport(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    waitframe(1);
    v_up = (360, 0, 0);
    v_forward = (0, 0, 360);

    if(isDefined(self)) {
      playFX(localclientnum, "maps/zm_white/fx8_monkey_bomb_reveal", self.origin, v_forward, v_up);
      self playSound(localclientnum, #"hash_21206f1b7fb27f81");
    }
  }
}

function_e722a4fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(newval == 1) {
      self.fx_id = util::playFXOnTag(localclientnum, "zm_weapons/fx8_music_box_zombie_flame_trail", self, "j_spine4");
      return;
    }

    if(newval == 0) {
      if(isDefined(self.fx_id)) {
        deletefx(localclientnum, self.fx_id);
        self.fx_id = undefined;
      }
    }
  }
}