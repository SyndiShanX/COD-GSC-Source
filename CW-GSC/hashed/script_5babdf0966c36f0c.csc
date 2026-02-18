/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5babdf0966c36f0c.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace world_event_black_chest;

function private autoexec __init__system__() {
  system::register(#"hash_24e8e2e7c9881782", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_3626be8164d82cbc")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("scriptmover", "sr_black_chest_fx", 1, 2, "int", &function_f1dc3a2c, 0, 0);
  clientfield::register("scriptmover", "sr_black_chest_swarm_fx", 1, 3, "int", &function_372485e9, 0, 0);
}

function function_f1dc3a2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    self.var_aa4114ee = function_239993de(fieldname, #"hash_64b0865c260e817", self, "tag_origin");
    self.var_4b0f392d = self playLoopSound(#"hash_3b6ec57280c13f40");
    return;
  }

  if(bwastimejump == 2) {
    playSound(fieldname, #"hash_265dc7bbebe2c9a5", self.origin + (0, 0, 20));

    if(isDefined(self.var_4b0f392d)) {
      self stoploopsound(self.var_4b0f392d);
      self.var_4b0f392d = undefined;
    }

    self.var_3dec4e8f = self playLoopSound(#"hash_7391c95dbcf9cfc2");
    playSound(fieldname, #"hash_779a84be63566050", self.origin + (0, 0, 20));
    self.var_65297126 = function_239993de(fieldname, #"hash_27ce04be3dbc0401", self, "tag_origin");
    self.var_6a713ba5 = function_239993de(fieldname, #"hash_27ce02be3dbc009b", self, "tag_origin");
    self.var_29313552 = function_239993de(fieldname, #"hash_27ce03be3dbc024e", self, "tag_origin");
    return;
  }

  if(bwastimejump == 3) {
    if(isDefined(self.var_65297126)) {
      killfx(fieldname, self.var_65297126);
      self.var_65297126 = undefined;
      playSound(fieldname, #"hash_1cd1dad84277f521", self.origin + (0, 0, 20));
      return;
    }

    if(isDefined(self.var_6a713ba5)) {
      killfx(fieldname, self.var_6a713ba5);
      self.var_6a713ba5 = undefined;
      playSound(fieldname, #"hash_1cd1d7d84277f008", self.origin + (0, 0, 20));
      return;
    }

    if(isDefined(self.var_29313552)) {
      killfx(fieldname, self.var_29313552);
      self.var_29313552 = undefined;

      if(isDefined(self.var_aa4114ee)) {
        stopfx(fieldname, self.var_aa4114ee);
      }

      if(isDefined(self.var_4b0f392d)) {
        self stoploopsound(self.var_4b0f392d);
        self.var_4b0f392d = undefined;
      }

      if(isDefined(self.var_3dec4e8f)) {
        self stoploopsound(self.var_3dec4e8f);
        self.var_3dec4e8f = undefined;
      }

      function_239993de(fieldname, #"hash_77bddd3682fbdda5", self, "tag_origin");
      self playSound(fieldname, #"hash_24989877bfd5a764");
    }
  }
}

function private function_372485e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_d61d7100)) {
    stopfx(fieldname, self.var_d61d7100);
  }

  fx = undefined;

  switch (bwastimejump) {
    case 1:
      fx = # "hash_6056afc2dadb83c6";
      self.var_af4484a7 = 0;
      break;
    case 2:
      fx = # "hash_45d44373b029b4c8";
      break;
    case 3:
      fx = # "hash_45a53073b00223bd";
      break;
    case 4:
      fx = # "hash_68a705e07e5e43f3";
      break;
  }

  self.var_9e8d031c = bwastimejump;

  if(!isDefined(fx)) {
    return;
  }

  if(!isDefined(self.var_af4484a7)) {
    self.var_af4484a7 = 1;
    self callback::on_shutdown(&function_5dbf2fbf);
  }

  self.var_d61d7100 = util::playFXOnTag(fieldname, fx, self, "tag_origin");
}

function private function_5dbf2fbf(localclientnum) {
  if(isDefined(self) && self hasdobj(localclientnum) && isvec(self.origin) && is_true(self.var_af4484a7)) {
    fx = # "hash_6056afc2dadb83c6";
    playFX(localclientnum, fx, self.origin);
  }
}