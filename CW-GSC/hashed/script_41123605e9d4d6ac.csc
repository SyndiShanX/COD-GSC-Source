/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_41123605e9d4d6ac.csc
***********************************************/

#using script_20fe86d43b7f18f1;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_cc727a3b;

function private autoexec __init__system__() {
  system::register(#"hash_507ba1ac0432a7e6", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("scriptmover", "" + # "dog_launcher_explode_fx", 16000, 1, "int", &function_9666c7b1, 0, 0);
  clientfield::register("scriptmover", "hs_swarm_state", 1, 1, "counter", &function_440e968, 0, 0);
  clientfield::register("allplayers", "hs_swarm_damage", 1, 1, "counter", &function_64d1f09b, 1, 0);
  clientfield::register("allplayers", "" + # "hash_2201faa112c8313", 16000, 1, "counter", &function_ea257a5f, 1, 0);
  clientfield::register("scriptmover", "" + # "hash_2201faa112c8313", 16000, 1, "counter", &function_ea257a5f, 1, 0);
  clientfield::register("scriptmover", "" + # "dog_projectile_fx", 16000, 1, "int", &dog_projectile_fx, 0, 0);
}

function function_9666c7b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.fx = playFX(fieldname, #"hash_1a93b9b31b5d1d3b", self.origin + (0, 0, 18), anglestoup(self.angles));
    self playSound(fieldname, #"hash_6a76932cce379c66");
    return;
  }

  if(isDefined(self.fx)) {
    stopfx(fieldname, self.fx);
    self.fx = undefined;
  }
}

function private function_440e968(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(isDefined(self.var_d61d7100)) {
    stopfx(fieldname, self.var_d61d7100);
  }

  fx = undefined;

  if(bwastimejump) {
    fx = # "hash_78ae17d0e989e328";
  }

  if(!isDefined(fx)) {
    return;
  }

  if(!isDefined(self.var_af4484a7)) {
    self.var_af4484a7 = 1;
    self callback::on_shutdown(&function_95dc19b0);
  }

  self.var_d61d7100 = util::playFXOnTag(fieldname, fx, self, "tag_origin");
}

function private function_95dc19b0(localclientnum) {
  if(isDefined(self)) {
    fx = # "hash_69eb668e9f7736bd";
    playFX(localclientnum, fx, self.origin);
  }
}

function private function_64d1f09b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");

  if(!isalive(self) || self !== function_5c10bd79(fieldname)) {
    return;
  }

  fx = undefined;

  if(bwastimejump) {
    fx = # "hash_26265474bcb72a8a";
  }

  if(!isDefined(fx)) {
    return;
  }

  viewmodelfx = playfxoncamera(fieldname, fx, (0, 0, 0), (1, 0, 0), (0, 0, 1));
  self waittilltimeout(2, #"death");
  stopfx(fieldname, viewmodelfx);
}

function private function_ea257a5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");
  fx = playFX(bwastimejump, #"hash_840483659ea54c4", self.origin + (0, 0, 10));
  wait 7;

  if(isDefined(fx)) {
    stopfx(bwastimejump, fx);
  }
}

function dog_projectile_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_e65311fc = util::playFXOnTag(fieldname, #"hash_901b71115b1cd3f", self, "j_spine4");
    return;
  }

  if(isDefined(self.var_e65311fc)) {
    stopfx(fieldname, self.var_e65311fc);
    self.var_e65311fc = undefined;
  }
}

function function_5565725d(localclientnum, dissolve, rob) {
  if(dissolve === 1) {
    self namespace_14ee8104::function_54d0d2d1(localclientnum);
  }

  if(!isDefined(self.var_553a42c)) {
    return;
  }

  if(dissolve === 1) {
    foreach(zombie in self.var_553a42c) {
      if(isDefined(zombie)) {
        zombie playrenderoverridebundle(rob);
      }
    }

    return;
  }

  foreach(zombie in self.var_553a42c) {
    if(isDefined(zombie)) {
      zombie stoprenderoverridebundle(rob);
    }
  }
}