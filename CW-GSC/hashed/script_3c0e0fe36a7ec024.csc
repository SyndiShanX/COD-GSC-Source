/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3c0e0fe36a7ec024.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_12a6a726;

function private autoexec __init__system__() {
  system::register(#"hash_72a9f15f4124442", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_49c3a9d150ecbb16")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("scriptmover", "sr_supply_drop_chest_fx", 1, 2, "int", &sr_supply_drop_chest_fx, 0, 0);
}

function sr_supply_drop_chest_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    self.var_aa4114ee = function_239993de(fieldname, #"hash_23c80cc2126820b2", self, "tag_origin");
    self.var_4b0f392d = self playLoopSound(#"hash_52036cf3cfe2b967");
    playSound(fieldname, #"hash_1f3fbd4b941aceed", self.origin + (0, 0, 35));
    function_239993de(fieldname, #"hash_64f736260391468a", self, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    self.n_fx = function_239993de(fieldname, #"hash_755eec380d6c4e4a", self, "tag_origin");
    self playSound(fieldname, #"hash_259adbb44db3fea8");
    self.var_3dec4e8f = self playLoopSound(#"hash_5a60a8ef6b7d6df1");
    return;
  }

  if(bwastimejump == 3) {
    if(isDefined(self.n_fx)) {
      stopfx(fieldname, self.n_fx);
    }

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

    function_239993de(fieldname, #"hash_160e892a069e168e", self, "tag_origin");
    self playSound(fieldname, #"hash_2d72791853c13b5");
  }
}