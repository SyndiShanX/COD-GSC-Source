/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\variant_asm.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace variant_asm;

function function_406984e213848212(anim_id, selector_fn, var_ebc45f79e4f8b88b) {
  level.var_448d3472e546de8e = default_to(level.var_448d3472e546de8e, []);
  level.var_2fa0bfdf1601c2f5 = default_to(level.var_2fa0bfdf1601c2f5, []);
  level.var_21cce249b717fda9 = default_to(level.var_21cce249b717fda9, []);
  level.var_448d3472e546de8e[self.animsetname] = default_to(level.var_448d3472e546de8e[self.animsetname], []);
  level.var_2fa0bfdf1601c2f5[self.animsetname] = default_to(level.var_2fa0bfdf1601c2f5[self.animsetname], []);
  assertex(!isDefined(level.var_448d3472e546de8e[self.animsetname][anim_id]), "<dev string:x1c>" + self.animsetname + "<dev string:x31>" + anim_id + "<dev string:x42>");
  level.var_448d3472e546de8e[self.animsetname][anim_id] = [];
  level.var_2fa0bfdf1601c2f5[self.animsetname][anim_id] = selector_fn;
  level.var_21cce249b717fda9[self.animsetname][anim_id] = var_ebc45f79e4f8b88b;
}

function function_3f5173a731bdfe2f(anim_id, base_struct, num_variants) {
  assert(isDefined(level.var_448d3472e546de8e[self.animsetname]));
  level.var_448d3472e546de8e[self.animsetname][anim_id] = default_to(level.var_448d3472e546de8e[self.animsetname][anim_id], []);
  index = level.var_448d3472e546de8e[self.animsetname][anim_id].size;
  base_struct.num_variants = num_variants;
  level.var_448d3472e546de8e[self.animsetname][anim_id][index] = base_struct;
}

function function_a5390330ee29d0eb(anim_id) {
  self.variant_cache[anim_id] = [];
}

function function_8626c13b5be18c1b(anim_id) {
  function_a5390330ee29d0eb(anim_id);
  self.variant_cache[anim_id]["alias"] = "";
  animset = self.animsetname;

  if(!isDefined(level.var_448d3472e546de8e[self.animsetname]) || !isDefined(level.var_448d3472e546de8e[self.animsetname])) {
    animset = self findoverridearchetype("default");
  }

  assert(isDefined(level.var_448d3472e546de8e[animset][anim_id]));
  assert(isDefined(level.var_2fa0bfdf1601c2f5[animset][anim_id]));

  foreach(variant_type in level.var_448d3472e546de8e[animset][anim_id]) {
    alias = [[level.var_2fa0bfdf1601c2f5[animset][anim_id]]](variant_type);

    if(isDefined(alias)) {
      self.variant_cache[anim_id]["alias"] = alias;

      if(isDefined(variant_type.num_variants)) {
        variant_index = randomint(variant_type.num_variants);
        self.variant_cache[anim_id]["variant_index"] = variant_index;
        self.variant_cache[anim_id]["alias"] = self.variant_cache[anim_id]["alias"] + "_v" + ter_op(variant_index < 10, "0", "") + string(variant_index);
      }

      if(isDefined(level.var_21cce249b717fda9[animset][anim_id])) {
        self[[level.var_21cce249b717fda9[animset][anim_id]]](self.variant_cache[anim_id]["alias"]);
      }

      return self.variant_cache[anim_id]["alias"];
    }
  }

  assertmsg("<dev string:x59>" + anim_id);
  return "failed_anim_variant";
}

function function_70705ab80bbaca39(asmname, statename, params) {
  anim_id = params;

  if(!isDefined(self.variant_cache) || !isDefined(self.variant_cache[anim_id]) || !isDefined(self.variant_cache[anim_id]["alias"])) {
    function_8626c13b5be18c1b(anim_id);
  }

  return asm_lookupanimfromalias(statename, self.variant_cache[anim_id]["alias"]);
}

function function_5ab423119778dda3(asmname, statename, params) {
  anim_id = params;
  assert(isDefined(self.variant_cache[anim_id]["<dev string:xa3>"]));
  return asm_lookupanimfromalias(statename, self.variant_cache[anim_id]["alias"]);
}

function function_18086be1394726c9(asmname, statename, params) {
  anim_id = params;

  if(!isDefined(self.variant_cache) || !isDefined(self.variant_cache[anim_id]) || !isDefined(self.variant_cache[anim_id]["alias"])) {
    return asm_chooseanim(asmname, statename, undefined);
  }

  return asm_lookupanimfromalias(statename, self.variant_cache[anim_id]["alias"]);
}