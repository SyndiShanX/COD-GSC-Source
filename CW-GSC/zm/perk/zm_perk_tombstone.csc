/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_tombstone.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_tombstone;

function private autoexec __init__system__() {
  system::register(#"zm_perk_tombstone", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_27473e44();
  clientfield::register_clientuimodel("hud_items.tombstonePerkAvailable", #"hud_items", #"tombstoneperkavailable", 1, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items.tombstoneReviveTimerShorten", #"hud_items", #"tombstonerevivetimershorten", 1, 1, "int", undefined, 0, 0);
}

function function_27473e44() {
  zm_perks::register_perk_clientfields(#"hash_38c08136902fd553", &client_field_func, &callback_func);
  zm_perks::register_perk_effects(#"hash_38c08136902fd553", "tombstone_light");
  zm_perks::register_perk_init_thread(#"hash_38c08136902fd553", &init_staminup);
  zm_perks::function_f3c80d73("zombie_perk_bottle_tombstone");
  callback::on_spawned(&on_spawned);
  function_12f0cc0d("xanim_pb_tombstone_idle");
}

function init_staminup() {
  if(is_true(level.enable_magic)) {
    level._effect[# "tombstone_light"] = "maps/zm_gold/fx9_sur_machine_tombstone_eye_smk";
  }
}

function client_field_func() {
  clientfield::register("allplayers", "" + # "hash_46072c670fdaf2fa", 8000, 1, "int", &function_e32c696e, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_2897f04212a28873", 8000, 1, "int", &function_2f3a5c2, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5d96e4c9a397fa0", 8000, 1, "int", &function_e2f686a3, 0, 0);
}

function callback_func() {}

function function_e32c696e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(level.var_929ed5c3)) {
    level.var_929ed5c3 = [];
  }

  var_47c85523 = self getentitynumber();

  if(!isDefined(level.var_929ed5c3[var_47c85523])) {
    level.var_929ed5c3[var_47c85523] = spawnStruct();
  }

  if(bwastimejump) {
    self zm_utility::function_88c3a609();

    if(zm_utility::function_f8796df3(fieldname)) {
      self playrenderoverridebundle(#"hash_280405958d740589");

      if(self postfx::function_556665f2(#"hash_3541c7bff1f76832")) {
        self postfx::stoppostfxbundle(#"hash_3541c7bff1f76832");
      }

      self postfx::playpostfxbundle(#"hash_3541c7bff1f76832");

      if(!isDefined(level.var_929ed5c3[var_47c85523].var_70064d7) && self function_da43934d()) {
        level.var_929ed5c3[var_47c85523].var_70064d7 = playfxoncamera(fieldname, #"hash_12ee2927874461e5", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      }

      self thread function_222efb26(fieldname);
    } else {
      self playrenderoverridebundle(#"hash_6b8215cb4fa935e4");

      if(!isDefined(level.var_929ed5c3[var_47c85523].var_ecb39b1e)) {
        level.var_929ed5c3[var_47c85523].var_ecb39b1e = util::playFXOnTag(fieldname, #"hash_803ea6a2550a53a", self, "j_head");
      }

      if(!isDefined(level.var_929ed5c3[var_47c85523].var_7163a06c)) {
        level.var_929ed5c3[var_47c85523].var_7163a06c = util::playFXOnTag(fieldname, #"hash_ee42b8ead6d79d1", self, "j_spine4");
      }
    }

    if(!isDefined(level.var_929ed5c3[var_47c85523].var_44c08b39)) {
      self playSound(fieldname, #"hash_9439f12723cfe43", self.origin + (0, 0, 75));
      level.var_929ed5c3[var_47c85523].var_44c08b39 = self playLoopSound(#"hash_239f90b280cde695", undefined, (0, 0, 75));
    }

    self.var_2642dd3d = 1;
    return;
  }

  self function_acf463c0(fieldname);
}

function on_spawned(localclientnum) {
  self function_acf463c0(localclientnum);
}

function function_acf463c0(localclientnum) {
  var_47c85523 = self getentitynumber();
  self notify(#"hash_3f0adb1cfeb5ef46");

  if(self function_d2503806(#"hash_280405958d740589") && self function_21c0fa55()) {
    self stoprenderoverridebundle(#"hash_280405958d740589");
  }

  if(self function_d2503806(#"hash_6b8215cb4fa935e4")) {
    self stoprenderoverridebundle(#"hash_6b8215cb4fa935e4");
  }

  self zm_utility::function_6c91d22b();

  if(self postfx::function_556665f2(#"hash_3541c7bff1f76832") && self function_21c0fa55()) {
    self postfx::exitpostfxbundle(#"hash_3541c7bff1f76832");
  }

  if(isDefined(level.var_929ed5c3[var_47c85523].var_70064d7)) {
    stopfx(localclientnum, level.var_929ed5c3[var_47c85523].var_70064d7);
    level.var_929ed5c3[var_47c85523].var_70064d7 = undefined;
  }

  if(isDefined(level.var_929ed5c3[var_47c85523].var_ecb39b1e)) {
    stopfx(localclientnum, level.var_929ed5c3[var_47c85523].var_ecb39b1e);
    level.var_929ed5c3[var_47c85523].var_ecb39b1e = undefined;
  }

  if(isDefined(level.var_929ed5c3[var_47c85523].var_7163a06c)) {
    stopfx(localclientnum, level.var_929ed5c3[var_47c85523].var_7163a06c);
    level.var_929ed5c3[var_47c85523].var_7163a06c = undefined;
  }

  if(isDefined(level.var_929ed5c3[var_47c85523].var_44c08b39)) {
    self playSound(localclientnum, #"hash_a486150b3965756", self.origin + (0, 0, 75));
    self stoploopsound(level.var_929ed5c3[var_47c85523].var_44c08b39);
    level.var_929ed5c3[var_47c85523].var_44c08b39 = undefined;
  }

  self.var_2642dd3d = undefined;
}

function private function_222efb26(localclientnum) {
  self notify("19cb22963ee837a1");
  self endon("19cb22963ee837a1");
  self endon(#"death", #"hash_3f0adb1cfeb5ef46");

  while(true) {
    var_b1b72524 = self isplayerads();

    if(self function_d2503806(#"hash_280405958d740589") && var_b1b72524) {
      self stoprenderoverridebundle(#"hash_280405958d740589");
      self zm_utility::function_6c91d22b();
    } else if(!self function_d2503806(#"hash_280405958d740589") && !var_b1b72524) {
      self zm_utility::function_88c3a609();
      self playrenderoverridebundle(#"hash_280405958d740589");
    }

    waitframe(1);
  }
}

function function_2f3a5c2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(isDefined(self.eye_fx)) {
    deletefx(fieldname, self.eye_fx, 1);
    self.eye_fx = undefined;
  }

  if(isDefined(self.var_212f2fe0)) {
    self stoploopsound(self.var_212f2fe0);
    self.var_212f2fe0 = undefined;
    self playSound(fieldname, #"hash_6ece13844ae6d9c4");
  }

  if(bwastimejump) {
    switch (self.model) {
      case # "hash_4bee36a9434de051":
      default:
        str_fx = # "hash_719c2cabe9153a26";
        break;
      case # "hash_4bee33a9434ddb38":
        str_fx = # "hash_73c4fd152aecf624";
        break;
      case # "hash_4bee34a9434ddceb":
        str_fx = # "hash_56b93c93cc14dacf";
        break;
      case # "hash_4bee39a9434de56a":
        str_fx = # "hash_749676da3b26efc8";
        break;
    }

    self.eye_fx = util::playFXOnTag(fieldname, str_fx, self, "tag_origin");
    self playSound(fieldname, #"hash_584010eeca733f75");
    self.var_212f2fe0 = self playLoopSound(#"hash_4bf005ee9faa6c5a");
  }
}

function function_e2f686a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(isDefined(self.smoke_fx)) {
    deletefx(fieldname, self.smoke_fx, 0);
    self.smoke_fx = undefined;
  }

  if(isDefined(self.smoke_sfx)) {
    self stoploopsound(self.smoke_sfx);
    self.smoke_sfx = undefined;
  }

  if(bwastimejump && isDefined(self)) {
    self.smoke_fx = util::playFXOnTag(fieldname, #"hash_75c8e387ce756315", self, "tag_origin");
    self.smoke_sfx = self playLoopSound(#"hash_3d5c6d04514fbbcd");
  }
}