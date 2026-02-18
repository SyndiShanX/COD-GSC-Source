/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_aoe.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;
#namespace zm_aoe;
class class_698343df {}

function private autoexec __init__system__() {
  system::register(#"zm_aoe", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(5), "int", &function_dcc24343, 0, 0);
  clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(2), "int", &function_6bcf2a61, 0, 0);
}

function private postinit() {
  function_15dea507(1, "zm_aoe_spear", "zm_aoe_spear");
  function_15dea507(2, "zm_aoe_spear_small", "zm_aoe_spear_small");
  function_15dea507(3, "zm_aoe_spear_big", "zm_aoe_spear_big");
  function_15dea507(4, "zm_aoe_strafe_storm", "zm_aoe_strafe_storm");
  function_15dea507(5, "zm_aoe_chaos_bolt", "zm_aoe_chaos_bolt");
  function_15dea507(6, "zm_aoe_chaos_bolt_2", "zm_aoe_chaos_bolt_2");
  function_15dea507(7, "zm_aoe_chaos_bolt_annihilate", "zm_aoe_chaos_bolt_annihilate");
  function_15dea507(1, "zm_aoe_radiation_hazard", "zm_aoe_radiation_hazard");
  function_1b06433("zm_aoe_radiation_hazard", "zm_aoe_radiation_hazard_ieu_override");
}

function private function_e969e75(aoeid) {
  assert(isDefined(level.var_400ae143));

  if(!isDefined(level.var_400ae143)) {
    level.var_400ae143 = [];
  }

  foreach(var_46f1b5eb in level.var_400ae143) {
    assert(isDefined(var_46f1b5eb.aoeid));

    if(var_46f1b5eb.aoeid == aoeid) {
      return var_46f1b5eb;
    }
  }

  return undefined;
}

function function_15dea507(aoeid, type, var_5ff737c1) {
  assert(isDefined(var_5ff737c1));
  var_6ec6e01 = getscriptbundle(var_5ff737c1);

  if(!isDefined(var_6ec6e01)) {
    return;
  }

  if(!isDefined(level.var_400ae143)) {
    level.var_400ae143 = [];
  }

  arraykeys = getarraykeys(level.var_400ae143);
  assert(!isinarray(arraykeys, hash(type)));
  var_46f1b5eb = new class_698343df();
  level.var_400ae143[type] = var_46f1b5eb;
  var_46f1b5eb.startfx = var_6ec6e01.start_effect;
  var_46f1b5eb.endfx = var_6ec6e01.end_effect;
  var_46f1b5eb.loopfx = var_6ec6e01.loop_effect;
  var_46f1b5eb.startsound = var_6ec6e01.var_e41627fe;
  var_46f1b5eb.endsound = var_6ec6e01.var_99ec7d60;
  var_46f1b5eb.loopsound = var_6ec6e01.var_1ee49376;
  var_46f1b5eb.startrumble = var_6ec6e01.startrumble;
  var_46f1b5eb.endrumble = var_6ec6e01.endrumble;
  var_46f1b5eb.var_a8609f98 = var_6ec6e01.var_a8609f98;
  var_46f1b5eb.earthquakescale = var_6ec6e01.earthquakescale;
  var_46f1b5eb.earthquakeduration = var_6ec6e01.earthquakeduration;
  var_46f1b5eb.effectradius = var_6ec6e01.effectradius;
  var_46f1b5eb.aoeid = aoeid;
}

function function_1b06433(type, var_2badd710) {
  assert(isDefined(var_2badd710));
  var_3d910b11 = getscriptbundle(var_2badd710);

  if(!isDefined(var_3d910b11)) {
    return;
  }

  if(!isDefined(level.var_400ae143[type])) {
    return;
  }

  var_46f1b5eb = level.var_400ae143[type];
  var_46f1b5eb.var_3eb74948 = var_3d910b11.end_effect;
  var_46f1b5eb.var_8f85134 = var_3d910b11.var_99ec7d60;
}

function private function_dcc24343(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!isDefined(self.aoeid)) {
    return;
  }

  player = function_5c10bd79(fieldname);
  aoeorigin = self.origin;
  distsq = distancesquared(player.origin, aoeorigin);
  var_46f1b5eb = function_e969e75(self.aoeid);

  if(!isDefined(var_46f1b5eb)) {
    return;
  }

  if(bwastimejump == 1) {
    if(isDefined(var_46f1b5eb.startfx)) {
      playFX(fieldname, var_46f1b5eb.startfx, self.origin, (0, 0, 1));
    }

    if(isDefined(var_46f1b5eb.startsound)) {
      playSound(fieldname, var_46f1b5eb.startsound, self.origin);
    }

    if(isDefined(var_46f1b5eb.effectradius) && distsq <= sqr(var_46f1b5eb.effectradius)) {
      if(isDefined(var_46f1b5eb.earthquakescale)) {
        earthquake(fieldname, var_46f1b5eb.earthquakescale, var_46f1b5eb.earthquakeduration, self.origin, var_46f1b5eb.effectradius);
      }

      if(isDefined(var_46f1b5eb.startrumble)) {
        function_36e4ebd4(fieldname, var_46f1b5eb.startrumble);
      }
    }

    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(var_46f1b5eb.loopfx)) {
      self.aoefx = playFX(fieldname, var_46f1b5eb.loopfx, self.origin, (0, 0, 1));
    }

    if(isDefined(var_46f1b5eb.loopsound)) {
      self.var_e0952422 = self playLoopSound(var_46f1b5eb.loopsound);
    }

    return;
  }

  if(bwastimejump == 3 || bwastimejump == 4) {
    if(isDefined(self.aoefx)) {
      stopfx(fieldname, self.aoefx);
    }

    if(isDefined(self.var_e0952422)) {
      self stoploopsound(self.var_e0952422);
      self.var_e0952422 = undefined;
    }

    endfx = var_46f1b5eb.endfx;
    endsound = var_46f1b5eb.endsound;

    if(bwastimejump == 4) {
      endfx = var_46f1b5eb.var_3eb74948;
      endsound = var_46f1b5eb.var_8f85134;
    }

    if(isDefined(endfx)) {
      playFX(fieldname, endfx, self.origin, (0, 0, 1));
    }

    if(isDefined(endsound)) {
      playSound(fieldname, endsound, self.origin);
    }

    if(isDefined(var_46f1b5eb.effectradius) && distsq <= sqr(var_46f1b5eb.effectradius)) {
      if(isDefined(var_46f1b5eb.endrumble)) {
        function_36e4ebd4(fieldname, var_46f1b5eb.endrumble);
      }
    }
  }
}

function private function_6bcf2a61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.aoeid = bwastimejump;
}