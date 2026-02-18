/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_37560a24283a601.csc
***********************************************/

#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_797fe2e7;

function private autoexec __init__system__() {
  system::register(#"hash_607f0336b64df630", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("missile", "" + # "hash_36112e7cad541b66", 1, 2, "int", &function_9cb928dc, 1, 0);
  clientfield::register("missile", "" + # "hash_2d55ead1309349bc", 1, 3, "int", &function_6bd975fa, 1, 0);
}

function function_9cb928dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
    case 2:
      var_8cce6a5c = # "hash_302e7c518042ef82";
      break;
    case 3:
      var_8cce6a5c = # "hash_57ddfc09a8a5cfee";
      break;
  }

  if(isDefined(var_8cce6a5c)) {
    self.var_b4afca05 = util::spawn_model(fieldname, "tag_origin", self.origin, (0, 0, 0));
    self.var_b4afca05 linkto(self);
    self.var_214a11f9 = util::playFXOnTag(fieldname, var_8cce6a5c, self.var_b4afca05, "tag_origin");
    self thread function_add31c08();

    if(!isDefined(self.var_d912eb65)) {
      playSound(fieldname, #"hash_3f0bee7329c6d063", self.origin + (0, 0, 25));
      self.var_d912eb65 = self playLoopSound(#"hash_d9ada961eacdf0", undefined, (0, 0, 25));
    }

    return;
  }

  if(isDefined(self.var_214a11f9)) {
    stopfx(fieldname, self.var_214a11f9);
    self.var_214a11f9 = undefined;
  }

  if(isDefined(self.var_b4afca05)) {
    self.var_b4afca05 delete();
  }

  if(isDefined(self.var_d912eb65)) {
    self stoploopsound(self.var_d912eb65);
    self.var_d912eb65 = undefined;
  }
}

function function_add31c08() {
  self waittill(#"death");

  if(isDefined(self.var_b4afca05)) {
    self.var_b4afca05 delete();
  }
}

function function_6bd975fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      var_90048701 = # "hash_1afd3356d5225a80";
      break;
    case 2:
      var_90048701 = # "hash_7a5d71decf1bdefb";
      break;
    case 3:
      var_90048701 = # "hash_29fd19d52a45b19e";
      break;
    case 4:
      var_90048701 = # "hash_d33a825314c9dac";
      break;
  }

  if(isDefined(var_90048701)) {
    self.var_90048701 = playFX(fieldname, var_90048701, self.origin, (1, 0, 0), (0, 0, 1));
    self playSound(fieldname, #"hash_6803d4ae1d74d42d");
    return;
  }

  if(isDefined(self.var_90048701)) {
    stopfx(fieldname, self.var_90048701);
    self.var_90048701 = undefined;
  }
}