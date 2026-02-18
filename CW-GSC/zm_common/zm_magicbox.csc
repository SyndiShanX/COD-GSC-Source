/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_magicbox.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\ping;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_magicbox;

function private autoexec __init__system__() {
  system::register(#"zm_magicbox", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._effect[# "hash_63f729c169af0c3e"] = # "hash_43a26488c9e5ce57";
  level._effect[# "chest_light_closed"] = # "zombie/fx_weapon_box_closed_glow_zmb";
  level._effect[# "hash_19f4dd97cbb87594"] = # "hash_5f376e9395e16666";
  level._effect[# "fire_runner"] = # "hash_409439bf8b3dd862";
  level._effect[# "hash_6778cbcf34bfebef"] = # "hash_43a26488c9e5ce57";
  level._effect[# "hash_5f2da0ff081c1699"] = # "hash_43a26488c9e5ce57";
  level._effect[# "hash_63697be07cc11490"] = # "hash_4924963a116d71bd";
  level._effect[# "hash_360e9275d6096589"] = # "hash_1bc8b1078984dbda";
  level._effect[# "hash_66be32f919d8b4a4"] = # "hash_53280ae47e5295e0";
  level._effect[# "hash_638a4ec653717ef6"] = # "hash_1a1142d2a6711364";
  level._effect[# "hash_1fa861cbe30adda9"] = # "hash_344ba1202db8c50a";
  level.var_1d1c6c28 = [];
  clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int", &function_8f69e904, 0, 0);
  clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int", &function_9253a233, 0, 0);
  clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter", &function_68f67f85, 0, 0);
  clientfield::register("zbarrier", "zbarrier_arriving_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0);
  clientfield::register("zbarrier", "zbarrier_leaving_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0);
  clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int", &force_stream_magicbox, 0, 0);
  clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int", &force_stream_magicbox_leave, 0, 0);
  clientfield::register("zbarrier", "" + # "hash_2fcdae6b889933c7", 1, 1, "int", &function_b5807489, 0, 0);
  clientfield::register("zbarrier", "" + # "hash_66b8b96e588ce1ac", 1, 3, "int", &function_abe84c14, 0, 0);
  clientfield::register("toplayer", "stream_magicbox_guns", 1, 1, "int", &stream_magicbox_guns, 0, 0);
}

function stream_magicbox_guns(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    foreach(modelname in level.var_1d1c6c28) {
      forcestreamxmodel(modelname, 8, 1);
    }

    return;
  }

  foreach(modelname in level.var_1d1c6c28) {
    stopforcestreamingxmodel(modelname);
  }
}

function force_stream_magicbox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_d80c44f = self zbarriergetpiece(2);

  if(bwastimejump) {
    forcestreamxmodel(var_d80c44f.model);
    return;
  }

  stopforcestreamingxmodel(var_d80c44f.model);
}

function force_stream_magicbox_leave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_e6289732 = self zbarriergetpiece(1);

  if(bwastimejump) {
    forcestreamxmodel(var_e6289732.model);
    return;
  }

  stopforcestreamingxmodel(var_e6289732.model);
}

function magicbox_show_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(bwastimejump, #"hash_607b61ab8f244087", self.origin);
}

function magicbox_leave_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  audio::stoploopat(#"hash_1b59c1bfb1aa5d37", self.origin);
}

function function_8f69e904(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(fieldname, bwastimejump, "opened");
}

function function_9253a233(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(fieldname, bwastimejump, "closed");
}

function function_68f67f85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_b4b9937(bwastimejump, 1, "leave");
}

function function_b4b9937(localclientnum, newval, str_state) {
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
      self function_be9ece7("open");
      self.var_ed9e4472 = self zbarriergetpiece(1);
      self.var_ed9e4472.var_fc558e74 = "magicbox";

      if(isDefined(var_e0f13b51)) {
        var_e0f13b51.var_fc558e74 = "magicbox";
      }

      waitframe(1);
    }

    if(isDefined(self) && (str_state == "opened" || str_state == "closed")) {
      self function_d7e80953(localclientnum, newval, str_state);

      if(newval) {
        switch (str_state) {
          case # "opened":
            str_fx = level._effect[# "hash_63f729c169af0c3e"];
            var_4c5fde13 = self.var_7e616d59[localclientnum];
            str_tag = "tag_origin";
            audio::playloopat(#"hash_1b59c1bfb1aa5d37", self.origin);
            break;
          case # "closed":
            str_fx = level._effect[# "chest_light_closed"];
            var_4c5fde13 = self.var_93e0dfa9[localclientnum];
            str_tag = "tag_origin";
            audio::stoploopat(#"hash_1b59c1bfb1aa5d37", self.origin);
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
      audio::stoploopat(#"hash_1b59c1bfb1aa5d37", self.origin);
      var_e5fdeba3 = [self zbarriergetpiece(0), self zbarriergetpiece(1), self zbarriergetpiece(2)];

      foreach(piece in var_e5fdeba3) {
        ping::function_f4f18dac(localclientnum, piece);
      }
    }
  }
}

function function_be97e893(localclientnum) {
  self endon(#"end_demo_jump_listener");
  level waittill(#"demo_jump");

  if(isDefined(self)) {
    self function_d7e80953(localclientnum, 1);
  }
}

function function_d7e80953(localclientnum, newval, str_state) {
  if(isDefined(self) && isDefined(self.var_6bcfabea[localclientnum])) {
    if(newval || !newval && self.var_37becd64 === str_state) {
      stopfx(localclientnum, self.var_6bcfabea[localclientnum]);
      self.var_6bcfabea[localclientnum] = undefined;
    }
  }

  self notify(#"end_demo_jump_listener");
}

function function_b5807489(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(bwastimejump) {
      mdl_piece = self zbarriergetpiece(1);
      mdl_piece.tag_origin = mdl_piece gettagorigin("tag_origin");
      self.var_788272f2 = util::playFXOnTag(fieldname, level._effect[# "fire_runner"], mdl_piece, "tag_origin");
      return;
    }

    if(isDefined(self.var_788272f2)) {
      stopfx(fieldname, self.var_788272f2);
    }
  }
}

function function_abe84c14(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  mdl_piece = self zbarriergetpiece(2);

  switch (bwastimejump) {
    case 1:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_6778cbcf34bfebef"], mdl_piece, "tag_origin");
      break;
    case 2:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_5f2da0ff081c1699"], mdl_piece, "tag_origin");
      break;
    case 3:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_63697be07cc11490"], mdl_piece, "tag_origin");
      playSound(fieldname, #"hash_604498b9077301d9", self.origin);
      break;
    case 4:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_360e9275d6096589"], mdl_piece, "tag_origin");
      playSound(fieldname, #"hash_6c870d0f85573f60", self.origin);
      break;
    case 5:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_66be32f919d8b4a4"], mdl_piece, "tag_origin");
      playSound(fieldname, #"hash_65ae6ba40cb558cd", self.origin);
      break;
    case 6:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_638a4ec653717ef6"], mdl_piece, "tag_origin");
      playSound(fieldname, #"hash_66f3cff29be77acd", self.origin);
      break;
    case 7:
      self.var_5ad9ac45 = util::playFXOnTag(fieldname, level._effect[# "hash_1fa861cbe30adda9"], mdl_piece, "tag_origin");
      playSound(fieldname, #"hash_30dce35bee22371a", self.origin);
      break;
    case 0:
    default:
      if(isDefined(self.var_5ad9ac45)) {
        stopfx(fieldname, self.var_5ad9ac45);
        self.var_5ad9ac45 = undefined;
        audio::stoploopat(#"hash_1b59c1bfb1aa5d37", self.origin);
      }

      break;
  }
}