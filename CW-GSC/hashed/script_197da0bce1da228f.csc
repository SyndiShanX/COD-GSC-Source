/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_197da0bce1da228f.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_4aff7b6b;

function private autoexec __init__system__() {
  system::register(#"hash_11b091d0ce567b82", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!isarchetypeloaded(#"mimic")) {
    return;
  }

  clientfield::register("scriptmover", "mimic_prop_rob", 6000, 3, "int", &function_62708cfa, 0, 0);
  clientfield::register("scriptmover", "mimic_prop_rattle_cf", 6000, 1, "counter", &function_f0e03255, 0, 0);
}

function private postinit() {}

function private function_62708cfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  switch (bwastimejump) {
    case 1:
      rob = # "hash_c7c1fdf822a1a26";
      break;
    case 2:
      rob = # "hash_6d27d975efe79b4";
      break;
    case 3:
      rob = # "hash_348ef4791d409901";
      break;
    case 4:
      rob = # "hash_286a43b21719f503";
      break;
    case 5:
      rob = # "hash_27be64a191e50e23";
      break;
    case 6:
      rob = # "hash_19412ffb8206f9cb";
      break;
    case 7:
      rob = # "hash_b7a62ed4703e9e4";
      break;
    default:
      break;
  }

  var_a194b407 = 1;

  if(isDefined(self.model)) {
    var_e2a65b72 = [#"sr_ee_hulk_wild_thing", #"hash_7b7cbb4eb2fd70e3", #"p9_fxanim_zm_gold_essence_trap_mod", #"p9_sur_console_launch_key_01"];

    if(isinarray(var_e2a65b72, self.model)) {
      var_a194b407 = 0;
    }
  }

  if(var_a194b407) {
    self.var_fc558e74 = "mimic_prop_spawn";
  }

  itemid = self getitemindex();
  self.item = function_b1702735(itemid);

  if(isDefined(rob)) {
    self playrenderoverridebundle(rob);
    self thread function_81c73263(fieldname, rob);
  }
}

function function_81c73263(localclientnum, rob) {
  self notify("7e9465bbc3328d10");
  self endon("7e9465bbc3328d10");
  self endon(#"death");
  var_6369afab = item_world::function_963d3f6e();
  maxdist = getdvarfloat(#"hash_2cd1a08f81049564", var_6369afab);

  while(true) {
    wait 0.1;

    if(!self function_d2503806(rob) && getplayers(localclientnum, undefined, self.origin, maxdist).size) {
      self playrenderoverridebundle(rob);
    }
  }
}

function function_f0e03255(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  trace_result = physicstrace(self.origin + (0, 0, 64), self.origin + (0, 0, -64), (0, 0, 0), (0, 0, 0), self);
  var_ab1d2284 = trace_result[#"position"];
  playFX(bwastimejump, "zm_ai/fx9_mimic_prop_shake", var_ab1d2284);
  playSound(bwastimejump, #"hash_76bf07d326e705c0", var_ab1d2284 + (0, 0, 20));
}