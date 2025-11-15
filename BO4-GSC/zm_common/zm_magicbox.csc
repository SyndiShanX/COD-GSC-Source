/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_magicbox.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_magicbox;

autoexec __init__system__() {
  system::register(#"zm_magicbox", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_3b22162a96d9389";
  level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
  level._effect[#"hash_19f4dd97cbb87594"] = #"hash_5f376e9395e16666";
  level._effect[#"hash_246062f68a34e289"] = #"hash_55cc904817de4a07";
  level._effect[#"hash_73c11d9bf55cbb6"] = #"hash_31c4723879504cb7";
  level._effect[#"hash_5239f7431d4c72ca"] = #"hash_3f4154d786124350";
  level._effect[#"hash_b6e7f724af1ad5b"] = #"hash_7ed77a22f165e308";
  level._effect[#"fire_runner"] = #"hash_409439bf8b3dd862";
  clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int", &function_8f69e904, 0, 0);
  clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int", &function_9253a233, 0, 0);
  clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter", &function_68f67f85, 0, 0);
  clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0);
  clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0);
  clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int", &force_stream_magicbox, 0, 0);
  clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int", &force_stream_magicbox_leave, 0, 0);
  clientfield::register("scriptmover", "force_stream", 1, 1, "int", &force_stream_changed, 0, 0);
  clientfield::register("zbarrier", "t8_magicbox_crack_glow_fx", 1, 1, "int", &t8_magicbox_crack_glow_fx, 0, 0);
  clientfield::register("zbarrier", "t8_magicbox_ambient_fx", 1, 1, "int", &t8_magicbox_ambient_fx, 0, 0);
  clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int", &function_b5807489, 0, 0);
}

force_stream_magicbox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_d80c44f = self zbarriergetpiece(2);

  if(newval) {
    forcestreamxmodel(var_d80c44f.model);
    return;
  }

  stopforcestreamingxmodel(var_d80c44f.model);
}

force_stream_magicbox_leave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_e6289732 = self zbarriergetpiece(1);

  if(newval) {
    forcestreamxmodel(var_e6289732.model);
    return;
  }

  stopforcestreamingxmodel(var_e6289732.model);
}

force_stream_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    model = self.model;

    if(isDefined(model)) {
      thread stream_model_for_time(localclientnum, model, 15);
    }
  }
}

stream_model_for_time(localclientnum, model, time) {
  util::lock_model(model);
  wait time;
  util::unlock_model(model);
}

magicbox_show_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

magicbox_leave_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function_8f69e904(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(localclientnum, newval, "opened");
}

function_9253a233(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(localclientnum, newval, "closed");
}

function_68f67f85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(localclientnum, 1, "leave");
}

function_b4b9937(localclientnum, newval, str_state) {
  if(!isDefined(self.var_7e616d59)) {
    self.var_7e616d59 = [];
  }

  if(!isDefined(self.var_93e0dfa9)) {
    self.var_93e0dfa9 = [];
  }

  if(!isDefined(self.var_6bcfabea)) {
    self.var_6bcfabea = [];
  }

  if(localclientnum != 0) {
    return;
  }

  if(isDefined(self)) {
    if(!isDefined(self.var_7e616d59[localclientnum])) {
      var_e0f13b51 = self zbarriergetpiece(2);
      v_tag_origin = var_e0f13b51 gettagorigin("tag_fx");
      v_tag_angles = var_e0f13b51 gettagangles("tag_fx");

      if(!isDefined(v_tag_origin)) {
        v_tag_origin = var_e0f13b51 gettagorigin("tag_origin");
        v_tag_angles = var_e0f13b51 gettagangles("tag_origin");
      }

      if(isDefined(level.var_4016a739)) {
        v_tag_angles += level.var_4016a739;
      }

      var_5b1d3ef = util::spawn_model(localclientnum, #"tag_origin", v_tag_origin, v_tag_angles);
      self.var_7e616d59[localclientnum] = var_5b1d3ef;
      waitframe(1);
    }

    if(isDefined(self) && !isDefined(self.var_93e0dfa9[localclientnum])) {
      v_tag_angles = self.angles;

      if(isDefined(level.var_4016a739)) {
        v_tag_angles += level.var_4016a739;
      }

      fx_obj = util::spawn_model(localclientnum, #"tag_origin", self.origin, v_tag_angles);
      self.var_93e0dfa9[localclientnum] = fx_obj;
      waitframe(1);
    }

    if(isDefined(self) && !isDefined(self.var_ed9e4472)) {
      self.var_ed9e4472 = self zbarriergetpiece(1);
      waitframe(1);
    }

    if(isDefined(self) && (str_state == "opened" || str_state == "closed")) {
      self function_d7e80953(localclientnum, newval, str_state);

      if(newval) {
        switch (str_state) {
          case #"opened":
            str_fx = level._effect[#"hash_2bba72fdcc5508b5"];
            var_4c5fde13 = self.var_7e616d59[localclientnum];
            str_tag = "tag_origin";
            break;
          case #"closed":
            str_fx = level._effect[#"chest_light_closed"];
            var_4c5fde13 = self.var_93e0dfa9[localclientnum];
            str_tag = "tag_origin";
            break;
        }

        if(isDefined(str_fx)) {
          self.var_37becd64 = str_state;
          self.var_6bcfabea[localclientnum] = util::playFXOnTag(localclientnum, str_fx, var_4c5fde13, str_tag);
          self function_be97e893(localclientnum);
        }
      }

      return;
    }

    if(isDefined(self) && str_state == "leave") {
      util::playFXOnTag(localclientnum, level._effect[#"hash_19f4dd97cbb87594"], self.var_ed9e4472, "tag_fx");
    }
  }
}

function_be97e893(localclientnum) {
  self endon(#"end_demo_jump_listener");
  level waittill(#"demo_jump");

  if(isDefined(self)) {
    self function_d7e80953(localclientnum, 1);
  }
}

function_d7e80953(localclientnum, newval, str_state) {
  if(isDefined(self) && isDefined(self.var_6bcfabea[localclientnum])) {
    if(newval || !newval && self.var_37becd64 === str_state) {
      stopfx(localclientnum, self.var_6bcfabea[localclientnum]);
      self.var_6bcfabea[localclientnum] = undefined;
    }
  }

  self notify(#"end_demo_jump_listener");
}

t8_magicbox_crack_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_c142c34f)) {
    self.var_c142c34f = [];
  }

  if(isDefined(self)) {
    self function_db505504(localclientnum);

    if(newval) {
      mdl_piece = self zbarriergetpiece(1);
      self.var_c142c34f[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_246062f68a34e289"], mdl_piece, "tag_fx");
      self function_e8a16acc(localclientnum);
    }
  }
}

function_e8a16acc(localclientnum) {
  self endon(#"hash_22de3d549a25efd3");
  level waittill(#"demo_jump");

  if(isDefined(self)) {
    self function_db505504(localclientnum);
  }
}

function_db505504(localclientnum) {
  if(isDefined(self) && isDefined(self.var_c142c34f[localclientnum])) {
    killfx(localclientnum, self.var_c142c34f[localclientnum]);
    self.var_c142c34f[localclientnum] = undefined;
  }

  self notify(#"hash_22de3d549a25efd3");
}

function_b5807489(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(newval) {
      mdl_piece = self zbarriergetpiece(1);
      mdl_piece.tag_origin = mdl_piece gettagorigin("tag_origin");
      self.var_788272f2 = util::playFXOnTag(localclientnum, level._effect[#"fire_runner"], mdl_piece, "tag_origin");
      return;
    }

    if(isDefined(self.var_788272f2)) {
      stopfx(localclientnum, self.var_788272f2);
    }
  }
}

t8_magicbox_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_4d1d25b5)) {
    self.var_4d1d25b5 = [];
  }

  if(!isDefined(self.var_cf76db4a)) {
    self.var_cf76db4a = [];
  }

  if(isDefined(self)) {
    self function_24deca6d(localclientnum);

    if(newval) {
      if(!isDefined(self.var_4d1d25b5[localclientnum])) {
        self.var_4d1d25b5[localclientnum] = [];
      }

      if(!isDefined(self.var_cf76db4a[localclientnum])) {
        self.var_cf76db4a[localclientnum] = [];
      }

      mdl_piece = self zbarriergetpiece(1);
      self.var_4d1d25b5[localclientnum][self.var_4d1d25b5[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_73c11d9bf55cbb6"], mdl_piece, "top_skull_head_jnt");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_b6e7f724af1ad5b"], mdl_piece, "tag_fx");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_05");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_06");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_07");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_08");
      mdl_piece = self zbarriergetpiece(2);
      self.var_4d1d25b5[localclientnum][self.var_4d1d25b5[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_73c11d9bf55cbb6"], mdl_piece, "top_skull_head_jnt");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_b6e7f724af1ad5b"], mdl_piece, "tag_fx");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_05");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_06");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_07");
      self.var_cf76db4a[localclientnum][self.var_cf76db4a[localclientnum].size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_08");
      self function_4a16fb9(localclientnum);
    }
  }
}

function_4a16fb9(localclientnum) {
  self endon(#"hash_33c72dec301d4a01");
  level waittill(#"demo_jump");

  if(isDefined(self)) {
    self function_24deca6d(localclientnum);
  }
}

function_24deca6d(localclientnum) {
  if(isDefined(self) && isDefined(self.var_4d1d25b5[localclientnum])) {
    for(i = 0; i < self.var_4d1d25b5[localclientnum].size; i++) {
      killfx(localclientnum, self.var_4d1d25b5[localclientnum][i]);
    }

    self.var_4d1d25b5[localclientnum] = undefined;
  }

  if(isDefined(self) && isDefined(self.var_cf76db4a[localclientnum])) {
    for(i = 0; i < self.var_cf76db4a[localclientnum].size; i++) {
      stopfx(localclientnum, self.var_cf76db4a[localclientnum][i]);
    }

    self.var_cf76db4a[localclientnum] = undefined;
  }

  self notify(#"hash_33c72dec301d4a01");
}