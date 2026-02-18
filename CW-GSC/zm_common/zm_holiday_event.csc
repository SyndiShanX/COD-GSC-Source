/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_holiday_event.csc
***********************************************/

#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_holiday_event;

function private autoexec __init__system__() {
  system::register(#"zm_holiday_event", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_4751990deae37e66"))) {
    callback::on_localclient_connect(&on_localclient_connect);
    callback::function_675f0963(&function_675f0963);
    clientfield::register("actor", "" + # "hash_477ed992854f5645", 28000, 1, "counter", &function_3b11146f, 0, 0);
    level thread function_ff03ce49();
  }
}

function function_675f0963(localclientnum) {
  self endon(#"death");

  if(isDefined(self.archetype) && self.team === "axis") {
    switch (self.archetype) {
      case # "tormentor":
      case # "zombie":
      case # "avogadro":
        self.var_6ffc5953 = array::random([# "hash_3b9bc9fd7d3450e8", #"hash_3b9bccfd7d345601", #"hash_3b9bcbfd7d34544e"]);
        self.var_dee85a7a = "j_head";
        break;
      case # "zombie_dog":
        if(self.subarchetype === # "hash_2a5479b83161cb35") {
          self.var_6ffc5953 = # "hash_2d158c5af72b951c";
        } else {
          self.var_6ffc5953 = # "hash_2d158c5af72b951c";
        }

        self.var_dee85a7a = "j_head";
        break;
      case # "raz":
        self.var_6ffc5953 = # "hash_279687d633e3788b";
        self.var_dee85a7a = "j_head";
        self.var_fbfc64db = # "hash_567c329bd17fa23e";
        break;
      case # "mimic":
        self.var_6ffc5953 = # "hash_577e281da25751ae";
        self.var_dee85a7a = "j_head";
        self.var_fbfc64db = # "hash_567c329bd17fa23e";
        break;
      case # "mechz":
        self.var_6ffc5953 = # "hash_36be37cb09a62a29";
        self.var_dee85a7a = "j_head";
        self.var_fbfc64db = # "hash_567c329bd17fa23e";
        break;
      case # "hash_7c0d83ac1e845ac2":
        self.var_6ffc5953 = # "hash_208ba71db2a5843e";
        self.var_dee85a7a = "j_head";
        self.var_fbfc64db = # "hash_567c329bd17fa23e";
        break;
      case # "soa":
        self.var_6ffc5953 = # "hash_73aa050fa52a8f98";
        self.var_dee85a7a = "j_head";
        wait 1.416;
        break;
    }

    if(isDefined(self.var_6ffc5953) && isDefined(self.var_dee85a7a) && !self isattached(self.var_6ffc5953, self.var_dee85a7a)) {
      self attach(self.var_6ffc5953, self.var_dee85a7a);
    }
  }
}

function function_3b11146f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_6ffc5953) && isDefined(self.var_dee85a7a) && self isattached(self.var_6ffc5953, self.var_dee85a7a)) {
    self detach(self.var_6ffc5953, self.var_dee85a7a);

    if(math::cointoss(20) || level flag::get(#"hash_63e59d16907d2aab")) {
      v_hit_pos = self gettagorigin(self.var_dee85a7a);
      v_force = (randomfloatrange(-0.5, 0.5), randomfloatrange(-0.5, 0.5), randomfloatrange(0.75, 1.5));
      createdynentandlaunch(bwastimejump, self.var_6ffc5953, self gettagorigin(self.var_dee85a7a), self gettagangles(self.var_dee85a7a), v_hit_pos, v_force);
    }

    var_297c3a3d = isDefined(self.var_fbfc64db) ? self.var_fbfc64db : # "hash_2990c4a0be6af31e";
    var_ea8a7e41 = self gettagorigin(self.var_dee85a7a);

    if(isDefined(var_ea8a7e41)) {
      playFX(bwastimejump, var_297c3a3d, var_ea8a7e41);
    }

    playSound(bwastimejump, #"hash_15d4351d6a8d884e", self gettagorigin(self.var_dee85a7a));
    self.var_6ffc5953 = undefined;
    self.var_dee85a7a = undefined;
    self.var_fbfc64db = undefined;
  }
}

function function_ff03ce49() {
  force_stream_model(#"hash_73aa050fa52a8f98", 4, 1);
  force_stream_model(#"hash_2d158c5af72b951c", 4, 1);
  force_stream_model(#"hash_36be37cb09a62a29", 4, 1);
  force_stream_model(#"hash_577e281da25751ae", 4, 1);
  force_stream_model(#"hash_2d158c5af72b951c", 4, 1);
  force_stream_model(#"hash_279687d633e3788b", 4, 1);
  force_stream_model(#"hash_208ba71db2a5843e", 4, 1);
  force_stream_model(#"hash_3b9bc9fd7d3450e8", 4, 1);
  force_stream_model(#"hash_3b9bccfd7d345601", 4, 1);
  force_stream_model(#"hash_3b9bcbfd7d34544e", 4, 1);
}

function private force_stream_model(str_asset, var_9940b166, mip) {
  for(lod = var_9940b166; lod > 1; lod--) {
    forcestreamxmodel(str_asset, lod, mip);
  }
}

function private on_localclient_connect(localclientnum) {
  level thread function_4ebcb98d(localclientnum);
}

function function_4ebcb98d(localclientnum) {
  util::init_dvar(#"hash_4cf563ada0725f21", "<dev string:x38>", &function_5f56213c);
  util::add_devgui(localclientnum, "<dev string:x3c>", "<dev string:x66>");
}

function private function_5f56213c(params) {
  if(params.value === "<dev string:x38>") {
    return;
  }

  switch (params.name) {
    case # "hash_4cf563ada0725f21":
      level flag::toggle(#"hash_63e59d16907d2aab");

      if(level flag::get(#"hash_63e59d16907d2aab")) {
        iprintlnbold("<dev string:x8d>");
      } else {
        iprintlnbold("<dev string:xb4>");
      }

      break;
  }

  setDvar(#"hash_4cf563ada0725f21", "<dev string:x38>");
}